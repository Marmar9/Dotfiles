#!/usr/bin/python

from math import sin, cos, tan, acos, radians, degrees ,pi
from datetime import datetime, date, timedelta

import signal
import os
import ctypes
import ctypes.util
import sys
import traceback

from zoneinfo import ZoneInfo
from sys import stdin, stdout

def log(*args, level="INFO", sep=" "):
    timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    line = f"[{timestamp}] [{level}] {sep.join(str(arg) for arg in args)}\n"

    with open("/home/marcin/night_light.log", "a", encoding="utf-8") as f:
        f.write(line)


def get_sunr_suns_date(date, timezone):
    lat = radians(52.23)
    lon = 21.0
    N = date.timetuple().tm_yday
    tz_offset = now_local.utcoffset().total_seconds() / 3600
    decl = radians(23.44 * sin(2 * pi * (284 + N) / 365.0))
    
    # Use solar altitude -0.833° for official sunrise/sunset
    altitude = radians(-0.833)
    cosH = (sin(altitude) - sin(lat) * sin(decl)) / (cos(lat) * cos(decl))
    cosH = max(-1, min(1, cosH))
    H = acos(cosH)
    H_deg = degrees(H)
    
    B = 2 * pi * (N - 81) / 364
    EoT = 9.87 * sin(2 * B) - 7.53 * cos(B) - 1.5 * sin(B)
    
    lon_std = 15 * tz_offset
    solar_noon = 12 + (4 * (lon_std - lon) - EoT) / 60
    
    sunrise = solar_noon - H_deg / 15
    sunset  = solar_noon + H_deg / 15
    
    sunrise_d = datetime(now_local.year, 1,1, tzinfo=timezone) + timedelta(days=N - 1, hours= int(sunrise), minutes=int((sunrise - int(sunrise)) * 60))
    sunset_d = datetime(now_local.year, 1,1, tzinfo=timezone) + timedelta(days=N - 1, hours= int(sunset), minutes=int((sunset - int(sunset)) * 60))

    return (sunrise_d, sunset_d)


def run_hyprsunset():
    pid = os.fork()
    if pid == 0:
        os.close(stdin.fileno())
        os.close(stdout.fileno())
        os.execvp("hyprsunset", ["hyprsunset","-t", "4300"])

    return pid

# Load the C standard library (libc)
libc = ctypes.CDLL(ctypes.util.find_library("c"), use_errno=True)

# Constants from <time.h>
CLOCK_BOOTTIME = 7  # Typically 7 on Linux, check <linux/time.h>
TIMER_ABSTIME = 1

# Define struct timespec
class timespec(ctypes.Structure):
    _fields_ = [("tv_sec", ctypes.c_long),
                ("tv_nsec", ctypes.c_long)]

# Define clock_nanosleep function prototype
libc.clock_nanosleep.argtypes = [ctypes.c_int, ctypes.c_int,
                                 ctypes.POINTER(timespec),
                                 ctypes.POINTER(timespec)]
libc.clock_nanosleep.restype = ctypes.c_int

def boottime_sleep(seconds):
    sec = int(seconds)
    nsec = int((seconds % int(seconds)) * 1000000000)
    req = timespec(sec, nsec)

    # Call clock_nanosleep
    res = libc.clock_nanosleep(CLOCK_BOOTTIME, 0, ctypes.byref(req), None)
    if res != 0:
        errno = ctypes.get_errno()
        raise OSError(errno, "clock_nanosleep failed")

def log_signal(sig, frame):
    log(f"Received signal {sig} ({signal.Signals(sig).name})", level="ERROR")
    log("Stack:\n" + "".join(traceback.format_stack(frame)), level="ERROR")
    sys.exit(128 + sig)

for s in (signal.SIGTERM, signal.SIGHUP, signal.SIGINT, signal.SIGQUIT):
    signal.signal(s, log_signal)



with open("/etc/localtime", "rb") as f:
    timezone = ZoneInfo.from_file(f, key="Local")
    
    log("Detected timezone:", timezone)
    
    now_local = datetime.now(timezone)
    
    log("Now_local: ", now_local)


while(True):
    now_local = datetime.now(timezone)
    this_sunrise, this_sunset = get_sunr_suns_date(now_local, timezone )
    
    if (this_sunset < now_local):
        log("Before midnight")
        # Night before midnight
        next_sunrise, next_sunset = get_sunr_suns_date(now_local + timedelta(days=1), timezone )
        
        pid = run_hyprsunset()

        td = (next_sunrise - now_local)
        log("Now: ", now_local)
        log("Sleeping for: ", td)
        boottime_sleep(td.total_seconds())

        os.kill(pid, signal.SIGKILL)
        os.waitpid(pid)

    elif (this_sunset > now_local and now_local < this_sunrise):
        log("After midnight")
        # Night after midnight
        
        pid = run_hyprsunset()

        td = (this_sunrise - now_local)
        log("Now: ", now_local)
        log("Sleeping for: ", td)
        boottime_sleep(td.total_seconds())

        os.kill(pid, signal.SIGKILL)
        os.waitpid(pid)
    else:
        log("Day")
        # Is a day
        next_sunrise, next_sunset = get_sunr_suns_date(now_local + timedelta(days=1), timezone )

        td = (this_sunset - now_local)
        log("Now: ", now_local)
        log("Sleeping for: ", td)

        boottime_sleep(td.total_seconds())
