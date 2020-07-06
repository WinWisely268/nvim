function! ts#FoldExpr(...)
	call plug#load('lazy-ts')
	return nvim_treesitter#foldexpr(a:000)
endfunction
