
fu! s:tags_db_init(dirname)
  call tags#db#init(a:dirname)
  nnoremap <buffer> <leader>r :<C-U>call tags#db#reload()<cr>
endfu

augroup tags-db
  autocmd!
  autocmd FileType c,cpp call s:tags_db_init(expand('<afile>:p:h'))
  autocmd BufWritePost tags.db call tags#db#generate(expand('<afile>:p'))
augroup END
