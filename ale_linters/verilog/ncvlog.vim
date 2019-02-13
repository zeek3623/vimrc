" Author: Tim Nolan
" Description: ALE syntax checker for Verilog using Cadence NCVLOG

call ale#Set('verilog_ncvlog_options', '')

function! ale_linters#verilog#ncvlog#GetCommand(buffer) abort
    return 'ncvlog '
    \   . ale#Var(a:buffer, 'verilog_ncvlog_options')
    \   . ' %t'
endfunction

function! ale_linters#verilog#ncvlog#Handle(buffer, lines) abort
    let l:pattern = 'ncvlog:\ *%t,%\=%\w%#\ (%f\,%l|%c):\ %m'
    let l:output  = []

    for l:match in ale#util#GetMatches(a:lines, l:pattern)
        let l:line = l:match[3] + 0
        let l:type = l:match[1] is# 'Error' ? 'E' : 'W'
        let l:text = l:match[4]
        let l:file = l:match[2]
        call add(l:output, {
        \   'lnum': l:line,
        \   'text': l:text,
        \   'type': l:type,
        \})
    endfor

    return l:output
endfunction

call ale#linter#Define('verilog', {
\   'name': 'ncvlog',
\   'output_stream': 'stderr',
\   'executable': 'ncvlog',
\   'command_callback': 'ale_linters#verilog#ncvlog#GetCommand',
\   'callback': 'ale_linters#verilog#ncvlog#Handle',
\})
