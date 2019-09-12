" Author: Tim Nolan
" Description: ALE syntax checker for Verilog using Cadence NCVLOG

call ale#Set('verilog_ncvlog_options', '')

function! ale_linters#verilog#ncvlog#GetCommand(buffer) abort
    return '%e '
    \   . ale#Var(a:buffer, 'verilog_ncvlog_options')
    \   . ' %s'
endfunction

function! ale_linters#verilog#ncvlog#Handle(buffer, lines) abort
    " ncvlog: *E,<tag> (<file>,<line>|<col>): <msg>
    let l:pattern = '\v^ncvlog: \*(E|W),\w+ \((\S+),(\d+)\|(\d+)\):(.+)'
    let l:output  = []

    for l:match in ale#util#GetMatches(a:lines, l:pattern)
        let l:line = l:match[3] + 0
        let l:type = l:match[1]
        let l:text = l:match[5]
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
\   'output_stream': 'both',
\   'executable': '/home/timnol01/scripts/bin/vlg_check_syntax_ncvlog',
\   'command_callback': 'ale_linters#verilog#ncvlog#GetCommand',
\   'callback': 'ale_linters#verilog#ncvlog#Handle',
\   'lint_file': 1,
\})

"   'executable': '/arm/tools/cadence/incisive/15.20.039/tools.lnx86/bin/64bit/ncvlog',
