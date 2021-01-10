local au = require('lib.au')

local ft_md = {
    WikiFt = {{'FileType', 'md', 'nmap <buffer><silent> ,ts set spell!'}}
}

return au.create_augroups(ft_md)
