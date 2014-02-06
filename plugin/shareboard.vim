if exists('g:shareboard_loaded')
  finish
endif
let g:shareboard_loaded = 1

let g:shareboard_path = get(g:, 'shareboard_path', 'shareboard')
let g:shareboard_host = get(g:, 'shareboard_host', 'localhost')
let g:shareboard_port = get(g:, 'shareboard_port', '8081')
let g:shareboard_command = get(g:, 'shareboard_command', "pandoc -Ss --webtex -t html")
let g:shareboard_compile_ext = get(g:, 'shareboard_compile_ext', ".html")
let g:shareboard_use_default_mapping = get(g:, 'shareboard_use_default_mapping', 1)
"let g:shareboard_debug = 1

function! s:Get()
  let l:lines = getline(1, '$')
  return substitute(shellescape(join(l:lines, "\n")), "\\\\\n", "\n", "g")
endfunction


function! s:Exec(command, null)
  if exists('g:shareboard_debug') && g:shareboard_debug
    echo "shareboard.vim: " . a:command
  endif

  if has('win32') || has('win64')
    if exists('g:shareboard_python_path')
      silent exe printf("!start %s %s",
            \ shellescape(g:shareboard_python_path),
            \ a:command)
    else
      silent exe "!start pythonw " . shellescape(a:command)
    endif
  else
    if a:null
      let l:suffix = "& 2>&1 /dev/null"
    else
      let l:suffix = ""
    endif
    if exists('g:shareboard_python_path')
      call system(printf("%s %s %s",
            \ shellescape(g:shareboard_python_path),
            \ a:command,
            \ l:suffix))
    else
      call system(printf("%s %s", a:command, l:suffix))
    endif
  endif
endfunction

function! s:Start()
  let l:command = printf('%s -o %s -p %s start -v',
        \ g:shareboard_path,
        \ g:shareboard_host,
        \ g:shareboard_port)
  if exists('g:shareboard_command')
    let l:command = l:command . printf(' -c %s', shellescape(g:shareboard_command))
  endif
  call s:Exec(l:command, 1)

  augroup Preview
    autocmd!
    autocmd BufWritePost <buffer> call <SID>Update()
  augroup END
endfunction

function! s:Update()
  let l:command = printf('%s -o %s -p %s set %s --filename %s',
        \ g:shareboard_path,
        \ g:shareboard_host,
        \ g:shareboard_port,
        \ s:Get(),
        \ shellescape(expand("%:p")))
  call s:Exec(l:command, 1)
endfunction

function! s:Preview()
  call s:Start()
  sleep 1
  call s:Update()
endfunction

function! s:Compile()
  let l:command = printf('echo -nE %s | %s | tee %s',
        \ s:Get(),
        \ g:shareboard_command,
        \ shellescape(expand("%:r:h") . g:shareboard_compile_ext))
  call s:Exec(l:command, 0)
endfunction

command! ShareboardStart call <SID>Start()
command! ShareboardUpdate call <SID>Update()
command! ShareboardPreview call <SID>Preview()
command! ShareboardCompile call <SID>Compile()

finish
