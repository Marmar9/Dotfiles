#!/usr/bin/env bash
set -eu

# scrollback_pager /usr/bin/nvim -c "set relativenumber nolist showtabline=0 foldcolumn=0 laststatus=0 cmdheight=0 ruler noruler clipboard+=unnamedplus" -c "hi Normal guibg=NONE ctermbg=NONE" -c "highlight Visual ctermfg=NONE guifg=NONE" -c "nnoremap <C-C> <Esc>:qa!<CR>" -c "autocmd TermOpen * normal G" -c "silent write /tmp/kitty_scrollback_buffer | te echo -n \"$(cat /tmp/kitty_scrollback_buffer && rm /tmp/kitty_scrollback_buffer)\" && sleep infinity " -u NONE

if [ "$#" -eq 3 ]; then
    INPUT_LINE_NUMBER=${1:-0}
    CURSOR_LINE=${2:-1}
    CURSOR_COLUMN=${3:-1}
    AUTOCMD_TERMCLOSE_CMD="call cursor(max([0,${INPUT_LINE_NUMBER}-1])+${CURSOR_LINE}, ${CURSOR_COLUMN})"
else
    AUTOCMD_TERMCLOSE_CMD="normal G"
fi

exec nvim 63<&0 0</dev/null \
    -u NONE \
    -c "map <silent> q :qa!<CR>" \
    -c "set shell=bash scrollback=100000 clipboard+=unnamedplus" \
    -c "set termguicolors relativenumber nolist showtabline=0 foldcolumn=0 laststatus=0 cmdheight=0 ruler noruler" \
    -c "highlight Normal guibg=NONE ctermbg=NONE" \
    -c "highlight Visual ctermfg=NONE guifg=NONE" \
    -c "autocmd TermEnter * stopinsert" \
    -c "autocmd TermClose * ${AUTOCMD_TERMCLOSE_CMD}" \
    -c 'terminal sed </dev/fd/63 -e "s/'$'\x1b'']8;;file:[^\]*[\]//g" && sleep 0.01 && printf "'$'\x1b'']2;"'
