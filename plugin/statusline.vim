function! TabLine()
    return luaeval("require'cosmetics.tabline'.tabline()")
endfunction

set tabline=%!TabLine()
