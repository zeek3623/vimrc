" Custom filetype
if exists("did_load_filetypes")
  finish
endif

augroup filetypedetect
	" All verilog opens a systemverilog
	au! BufNewFile,BufRead *.v,*.vh,*.sv,*.svh setfiletype systemverilog
augroup END
