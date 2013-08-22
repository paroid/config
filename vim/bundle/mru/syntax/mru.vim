" File:        mru.vim
" Description: MRU syntax settings
" Author:      paroid chen <paroid@paroid.org>
" Licence:     Vim licence
" Website:     http://paroid.org
" Version:     0.1

scriptencoding utf-8

if exists("b:current_syntax")
    finish
endif

syntax match MRUFileNameMatch '^\S*'
syntax match MRUFilePathMatch '\s\S*'

highlight default link MRUFileNameMatch MRUFileName
highlight default link MRUFilePathMatch MRUFilePath

highlight default MRUFileName guifg=#fd971f 
highlight default MRUFilePath guifg=#414141


let b:current_syntax = "mru"

" vim: ts=8 sw=4 sts=4 et foldenable foldmethod=marker foldcolumn=1
