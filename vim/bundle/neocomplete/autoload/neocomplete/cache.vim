"=============================================================================
" FILE: cache.vim
" AUTHOR: Shougo Matsushita <Shougo.Matsu@gmail.com>
" Last Modified: 29 Jul 2013.
" License: MIT license  {{{
"     Permission is hereby granted, free of charge, to any person obtaining
"     a copy of this software and associated documentation files (the
"     "Software"), to deal in the Software without restriction, including
"     without limitation the rights to use, copy, modify, merge, publish,
"     distribute, sublicense, and/or sell copies of the Software, and to
"     permit persons to whom the Software is furnished to do so, subject to
"     the following conditionneocomplete#cache#
"
"     The above copyright notice and this permission notice shall be included
"     in all copies or substantial portions of the Software.
"
"     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
"     OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
"     MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
"     IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
"     CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
"     TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
"     SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
" }}}
"=============================================================================

let s:save_cpo = &cpo
set cpo&vim

let s:Cache = neocomplete#util#get_vital().import('System.Cache')

" Cache loader.
function! neocomplete#cache#load_from_cache(cache_dir, filename, ...) "{{{
  let is_string = get(a:000, 0, 0)

  try
    " Note: For neocomplete.
    let path = neocomplete#cache#encode_name(a:cache_dir, a:filename)
    let list = []

    if is_string
      lua << EOF
do
  local ret = vim.eval('list')
  local list = {}
  for line in io.lines(vim.eval('path')) do
    list = loadstring('return ' .. line)()
  end

  for i = 1, #list do
    ret:add(list[i])
  end
end
EOF
    else
      let list = eval(get(neocomplete#cache#readfile(
            \ a:cache_dir, a:filename), 0, '[]'))
    endif

    "echomsg string(list)
    if !empty(list) && is_string && type(list[0]) != type('')
      " Type check.
      throw 'Type error'
    endif

    return list
  catch
    " Delete old cache file.
    let cache_name =
          \ neocomplete#cache#encode_name(a:cache_dir, a:filename)
    if filereadable(cache_name)
      call delete(cache_name)
    endif

    return []
  endtry
endfunction"}}}

" New cache loader.
function! neocomplete#cache#check_cache(cache_dir, key, async_cache_dictionary, keyword_cache, is_string) "{{{
  if !has_key(a:async_cache_dictionary, a:key)
    return
  endif

  let cache_list = a:async_cache_dictionary[a:key]

  for cache in filter(copy(cache_list), 'filereadable(v:val.cachename)')
    let a:keyword_cache[a:key] = neocomplete#cache#load_from_cache(
              \ a:cache_dir, cache.filename, a:is_string)
    break
  endfor

  call filter(cache_list, '!filereadable(v:val.cachename)')

  if empty(cache_list)
    " Delete from dictionary.
    call remove(a:async_cache_dictionary, a:key)
    return
  endif
endfunction"}}}

" For buffer source cache loader.
function! neocomplete#cache#check_cache_dictionary(cache_dir, key, async_cache_dictionary, keywords, is_string) "{{{
  if !has_key(a:async_cache_dictionary, a:key)
    return
  endif

  let cache_list = a:async_cache_dictionary[a:key]

  for cache in filter(copy(cache_list), 'filereadable(v:val.cachename)')
    let loaded_keywords = neocomplete#cache#load_from_cache(
              \ a:cache_dir, cache.filename, a:is_string)

  lua << EOF
do
    local keywords = vim.eval('a:keywords')
    local loaded_keywords = vim.eval('loaded_keywords')
    for i = 0, #loaded_keywords-1 do
      if keywords[loaded_keywords[i]] == nil then
        keywords[loaded_keywords[i]] = ''
      end
    end
end
EOF
    break
  endfor

  call filter(cache_list, '!filereadable(v:val.cachename)')

  if empty(cache_list)
    " Delete from dictionary.
    call remove(a:async_cache_dictionary, a:key)
    return
  endif
endfunction"}}}

function! neocomplete#cache#save_cache(cache_dir, filename, keyword_list) "{{{
  " Output cache.
  let string = substitute(substitute(
        \ string(a:keyword_list), '^[', '{', ''), ']$', '}', '')
  call neocomplete#cache#writefile(
        \ a:cache_dir, a:filename, [string])
endfunction"}}}

" Cache helper.
function! neocomplete#cache#getfilename(cache_dir, filename) "{{{
  let cache_dir = neocomplete#get_data_directory() . '/' . a:cache_dir
  return s:Cache.getfilename(cache_dir, a:filename)
endfunction"}}}
function! neocomplete#cache#filereadable(cache_dir, filename) "{{{
  let cache_dir = neocomplete#get_data_directory() . '/' . a:cache_dir
  return s:Cache.filereadable(cache_dir, a:filename)
endfunction"}}}
function! neocomplete#cache#readfile(cache_dir, filename) "{{{
  let cache_dir = neocomplete#get_data_directory() . '/' . a:cache_dir
  return s:Cache.readfile(cache_dir, a:filename)
endfunction"}}}
function! neocomplete#cache#writefile(cache_dir, filename, list) "{{{
  let cache_dir = neocomplete#get_data_directory() . '/' . a:cache_dir
  return s:Cache.writefile(cache_dir, a:filename, a:list)
endfunction"}}}
function! neocomplete#cache#encode_name(cache_dir, filename)
  " Check cache directory.
  let cache_dir = neocomplete#get_data_directory() . '/' . a:cache_dir
  return s:Cache.getfilename(cache_dir, a:filename)
endfunction
function! neocomplete#cache#check_old_cache(cache_dir, filename) "{{{
  let cache_dir = neocomplete#get_data_directory() . '/' . a:cache_dir
  return  s:Cache.check_old_cache(cache_dir, a:filename)
endfunction"}}}
function! neocomplete#cache#make_directory(directory) "{{{
  let directory =
        \ neocomplete#get_data_directory() .'/'.a:directory
  if !isdirectory(directory)
    call mkdir(directory, 'p')
  endif
endfunction"}}}

let s:sdir = neocomplete#util#substitute_path_separator(
      \ fnamemodify(expand('<sfile>'), ':p:h'))

function! neocomplete#cache#async_load_from_file(cache_dir, filename, pattern, mark) "{{{
  if !neocomplete#cache#check_old_cache(a:cache_dir, a:filename)
    return neocomplete#cache#encode_name(a:cache_dir, a:filename)
  endif

  let pattern_file_name =
        \ neocomplete#cache#encode_name('keyword_patterns', a:filename)
  let cache_name =
        \ neocomplete#cache#encode_name(a:cache_dir, a:filename)

  " Create pattern file.
  call neocomplete#cache#writefile(
        \ 'keyword_patterns', a:filename, [a:pattern])

  " args: funcname, outputname, filename pattern mark
  "       minlen maxlen encoding
  let fileencoding =
        \ &fileencoding == '' ? &encoding : &fileencoding
  let argv = [
        \  'load_from_file', cache_name, a:filename, pattern_file_name, a:mark,
        \  g:neocomplete#min_keyword_length, fileencoding
        \ ]
  return s:async_load(argv, a:cache_dir, a:filename)
endfunction"}}}
function! neocomplete#cache#async_load_from_tags(cache_dir, filename, filetype, mark, is_create_tags) "{{{
  if !neocomplete#cache#check_old_cache(a:cache_dir, a:filename)
    return neocomplete#cache#encode_name(a:cache_dir, a:filename)
  endif

  let cache_name =
        \ neocomplete#cache#encode_name(a:cache_dir, a:filename)
  let pattern_file_name =
        \ neocomplete#cache#encode_name('tags_pattens', a:filename)

  if a:is_create_tags
    if !executable(g:neocomplete#ctags_command)
      echoerr 'Create tags error! Please install '
            \ . g:neocomplete#ctags_command . '.'
      return neocomplete#cache#encode_name(a:cache_dir, a:filename)
    endif

    " Create tags file.
    let tags_file_name =
          \ neocomplete#cache#encode_name('tags_output', a:filename)

    let default = get(g:neocomplete#ctags_arguments, '_', '')
    let args = get(g:neocomplete#ctags_arguments, a:filetype, default)

    if has('win32') || has('win64')
      let filename =
            \ neocomplete#util#substitute_path_separator(a:filename)
      let command = printf('%s -f "%s" %s "%s" ',
            \ g:neocomplete#ctags_command, tags_file_name, args, filename)
    else
      let command = printf('%s -f ''%s'' 2>/dev/null %s ''%s''',
            \ g:neocomplete#ctags_command, tags_file_name, args, a:filename)
    endif

    if neocomplete#has_vimproc()
      call vimproc#system_bg(command)
    else
      call system(command)
    endif
  else
    let tags_file_name = '$dummy$'
  endif

  let filter_pattern =
        \ get(g:neocomplete#tags_filter_patterns, a:filetype, '')
  call neocomplete#cache#writefile('tags_pattens', a:filename,
        \ [neocomplete#get_keyword_pattern(),
        \  tags_file_name, filter_pattern, a:filetype])

  " args: funcname, outputname, filename
  "       pattern mark minlen encoding
  let fileencoding = &fileencoding == '' ? &encoding : &fileencoding
  let argv = [
        \  'load_from_tags', cache_name, a:filename, pattern_file_name, a:mark,
        \  g:neocomplete#min_keyword_length, fileencoding
        \ ]
  return s:async_load(argv, a:cache_dir, a:filename)
endfunction"}}}
function! s:async_load(argv, cache_dir, filename) "{{{
  " if 0
  if neocomplete#has_vimproc()
    let paths = vimproc#get_command_name(v:progname, $PATH, -1)
    if empty(paths)
      if has('gui_macvim')
        " MacVim check.
        if !executable('/Applications/MacVim.app/Contents/MacOS/Vim')
          call neocomplete#print_error(
                \ 'You installed MacVim in not default directory!'.
                \ ' You must add MacVim installed path in $PATH.')
          let g:neocomplete#use_vimproc = 0
          return
        endif

        let vim_path = '/Applications/MacVim.app/Contents/MacOS/Vim'
      else
        call neocomplete#print_error(
              \ printf('Vim path : "%s" is not found.'.
              \        ' You must add "%s" installed path in $PATH.',
              \        v:progname, v:progname))
        let g:neocomplete#use_vimproc = 0
        return
      endif
    else
      let base_path = neocomplete#util#substitute_path_separator(
            \ fnamemodify(paths[0], ':p:h'))

      let vim_path = base_path .
            \ (neocomplete#util#is_windows() ? '/vim.exe' : '/vim')
    endif

    if !executable(vim_path) && neocomplete#util#is_mac()
      " Note: Search "Vim" instead of vim.
      let vim_path = base_path. '/Vim'
    endif

    if !executable(vim_path)
      call neocomplete#print_error(
            \ printf('Vim path : "%s" is not executable.', vim_path))
      let g:neocomplete#use_vimproc = 0
      return
    endif

    let args = [vim_path, '-u', 'NONE', '-i', 'NONE', '-n',
          \       '-N', '-S', s:sdir.'/async_cache.vim']
          \ + a:argv
    call vimproc#system_bg(args)
    " call vimproc#system(args)
    " call system(join(args))
  else
    call neocomplete#async_cache#main(a:argv)
  endif

  return neocomplete#cache#encode_name(a:cache_dir, a:filename)
endfunction"}}}

let &cpo = s:save_cpo
unlet s:save_cpo

" vim: foldmethod=marker
