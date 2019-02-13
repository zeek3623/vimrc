" Vim Syntax File
" Language: SystemVerilog
" Maintainer: Tim Nolan
" Version: 0.1
"
" Notes:
"  - Keywords separated between V2001 & SV. Will allow separate highlighting if desired
if exists("b:current_syntax")
  finish
endif

" Set the local value of the 'iskeyword' option.
" Note: '?' was added so that verilogNumber would be processed correctly when '?' is the last character of the number.
" Note: Always do this regardless for if something adds ':' to iskeyword then todo words do not match if : straight after
if version >= 600
   setlocal iskeyword=@,48-57,63,_,192-255
else
   set iskeyword=@,48-57,63,_,192-255
endif

"-------------------------------------------------------------------------------
" Matching Rules
"  - When multiple Match or Region items start in the same position, the item defined last has priority.
"  - A Keyword has priority over Match and Region items.
"  - An item that starts in an earlier position has priority over items that start in later positions.
"-------------------------------------------------------------------------------

" Verilog Keywords from 2001 LRM
syn keyword vStatement   always and assign
syn keyword vStatement   buf bufif0 bufif1
syn keyword vStatement   cell cmos config
syn keyword vStatement   deassign defparam design disable
syn keyword vStatement   edge endconfig endfunction endgenerate endmodule endprimitive endspecify endtable endtask
syn keyword vStatement   force function
syn keyword vStatement   generate
syn keyword vStatement   highz0 highz1
syn keyword vStatement   ifnone incdir include initial instance
syn keyword vStatement   large liblist library
syn keyword vStatement   macromodule medium module
syn keyword vStatement   nand negedge nmos nor noshowcancelled not notif0 notif1
syn keyword vStatement   or
syn keyword vStatement   pmos posedge primitive pull0 pull1 pulldown pullup pulsestyle_ondetect pulsestyle_onevent
syn keyword vStatement   rcmos release rnmos rpmos rtran rtranif0 rtranif1
syn keyword vStatement   scalared showcancelled small specify strong0 strong1 supply0 supply1
syn keyword vStatement   table task tran tranif0 tranif1 tri tri0 tri1 triand trior trireg
syn keyword vStatement   use
syn keyword vStatement   vectored
syn keyword vStatement   wait wand weak0 weak1 wor
syn keyword vStatement   xnor xor

syn keyword vType        event integer genvar real realtime reg signed specparam unsigned time wire
syn keyword vStorage     automatic inout input localparam output parameter
syn keyword vLabel       begin end fork join
syn keyword vConditional if else case casex casez default endcase
syn keyword vLoop        forever repeat while for

" SV Keywords from the LRM Annex B that are not in the verilog list above
syn keyword svStatement   accept_on alias always_comb always_ff always_latch assert assume
syn keyword svStatement   before bind bins binsof break
syn keyword svStatement   checker class clocking constraint context continue cover covergroup coverpoint cross
syn keyword svStatement   dist do
syn keyword svStatement   endchecker endclass endclocking endgroup endinterface endpackage endprogram endproperty endsequence enum eventually expect extends
syn keyword svStatement   final first_match
syn keyword svStatement   global
syn keyword svStatement   ignore_bins illegal_bins implements implies inside interconnect interface intersect
syn keyword svStatement   let local
syn keyword svStatement   matches modport
syn keyword svStatement   nettype new nexttime null
syn keyword svStatement   package packed priority program property pure
syn keyword svStatement   randc randcase randsequence reject_on repeat restrict return
syn keyword svStatement   s_always s_eventually s_nexttime s_until s_until_with sequence soft solve strong struct super sync_accept_on sync_reject_on
syn keyword svStatement   tagged this throughout timeprecision timeunit type typedef
syn keyword svStatement   union unique unique0 until until_with untyped uwire
syn keyword svStatement   wait_order while wildcard with within

syn keyword svType        bit byte chandle int logic longint shortint shortreal string void
syn keyword svStorage     const export extern forkjoin import protected rand ref static virtual var
syn keyword svLabel       join_any join_none
syn keyword svConditional iff
syn keyword svLoop        foreach

" Operators
" TODO: Add delimiters as separate
syn match  svOp     "[&|~><!)(*#%@+/=?:;}{,.\^\-\[\]]"

" Comments
syn keyword svTodo contained TODO FIXME REVISIT CHECKME
syn region  svComment start="/\*" end="\*/" contains=svTodo,@Spell
syn match   svComment "//.*$" contains=svTodo,@Spell

" Directives
syn match  svDirective "//\s*\(synopsys\|synthesis\|pragma\|spyglass\)\>.*$"
syn region svDirective start="/\*\s*\(synopsys\|synthesis\|pragma\|spyglass\)\>" end="\*/"

" Attributes
" - Don't catch always @(*)...
" TODO: Better way?
syn region svAttr matchgroup=svComment start="(\*[^)]" end="\*)" contains=ALL

" Constants
" - A bit tricky. Ideal would be dynamic from localparams...
" - For now do `<text> and words all caps with an _
syn match svConstant "`[a-zA-Z0-9_]\+\>"
syn match svConstant "\<[A-Z0-9]\+_[A-Z0-9_]\+\>"

" Pre-processor
syn match svPreProcCond "`\(else\|elsif\|endif\|ifdef\|ifndef\)\>"
syn match svPreProcInc  "`include\>"
syn match svPreProcDef  "`\(define\|undef\)\>"
syn match svPreProcMisc "`\(__FILE__\|__LINE__\|begin_keywords\|celldefine\|default_nettype\|end_keywords\|endcelldefine\|line\|nounconnected_drive\|pragma\|resetall\|timescale\|unconnected_drive\|undefineall\)\>"

" System Functions
" - I don't believe this list is complete... Cannot get a clear list from the standard.
syn match vSysFn  "\$\(display\|write\|strobe\|monitor\|time\|stime\|realtime\|reset\|stop\|finish\|scope\|showscope\|random\|dumpfile\|dumpvar\|dumpon\|dumpoff\|dumpall\|fopen\|fdisplay\|fstrobe\|fmonitor\|fwrite\|readmemh\|readmemb\)\>"
syn match svSysFn "\$\(exit\|printtimescale\|timeformat\|bitstoreal\|realtobits\|bitstoshortreal\|shortrealtobits\|itor\|rtoi\|signed\|unsigned\|cast\|bits\|isunbounded\|typename\|unpacked_dimensions\|dimensions\|left\|right\|low\|high\|increment\|size\|clog2\|asin\|ln\|acos\|log10\|atan\|exp\|atan2\|sqrt\|hypot\|pow\|sinh\|floor\|cosh\|ceil\|tanh\|sin\|asinh\|cos\|acosh\|tan\|atanh\|countbits\|countones\|onehot\|onehot0\|isunknown\|fatal\|error\|warning\|info\|fatal\|error\|warning\|info\|asserton\|assertoff\|assertkill\|assertcontrol\|assertpasson\|assertpassoff\|assertfailon\|assertfailoff\|assertnonvacuouson\|assertvacuousoff\|sampled\|rose\|fell\|stable\|changed\|past\|past_gclk\|rose_gclk\|fell_gclk\|stable_gclk\|changed_gclk\|future_gclk\|rising_gclk\|falling_gclk\|steady_gclk\|changing_gclk\|coverage_control\|coverage_get_max\|coverage_get\|coverage_merge\|coverage_save\|get_coverage\|set_coverage_db_name\|load_coverage_db\|urandom\|urandom_range\|dist_chi_square\|dist_erlang\|dist_exponential\|dist_normal\|dist_poisson\|dist_t\|dist_uniform\|q_initialize\|q_add\|q_remove\|q_full\|q_exam\|asyncandarray\|asyncandplane\|asyncnandarray\|asyncnandplane\|asyncorarray\|asyncorplane\|asyncnorarray\|asyncnorplane\|syncandarray\|syncandplane\|syncnandarray\|syncnandplane\|syncorarray\|syncorplane\|syncnorarray\|syncnorplane\|system\|contained\|transparent\)\>"

" Object Functions
syntax match svObjFn "\.\(num\|size\|delete\|exists\|first\|last\|next\|prev\|insert\|pop_front\|pop_back\|push_front\|push_back\|find\|find_index\|find_first\|find_first_index\|find_last\|find_last_index\|min\|max\|reverse\|sort\|rsort\|shuffle\|sum\|product\|and\|or\|xor\)\>\(\s\|\n\)*("he=e-1


" Types
" - numbers
syn match  svNum    "\<[0-9_]\+\([munpf]\|\)s\>"
syn match  svNum    "\(\<\d\+\|\)'[sS]\?[bB]\s*[0-1_xXzZ?]\+\>"
syn match  svNum    "\(\<\d\+\|\)'[sS]\?[oO]\s*[0-7_xXzZ?]\+\>"
syn match  svNum    "\(\<\d\+\|\)'[sS]\?[dD]\s*[0-9_xXzZ?]\+\>"
syn match  svNum    "\(\<\d\+\|\)'[sS]\?[hH]\s*[0-9a-fA-F_xXzZ?]\+\>"
syn match  svNum    "\<[+-]\=[0-9_]\+\(\.[0-9_]*\|\)\(e[0-9_]*\|\)\>"
" - strings
syn match  svEscape +\\[nt"\\]+ contained
syn match  svEscape "\\\o\o\=\o\=" contained
syn region svString start=+"+ skip=+\\"+ end=+"+ contains=svEscape,@Spell

"-------------------------------------------------------------------------------
" Assign Highlighting
"-------------------------------------------------------------------------------

hi def link svComment     Comment
hi def link svTodo        Todo
hi def link svDirective   SpecialComment
hi def link svAttr        SpecialComment

hi def link svConstant    Constant
hi def link svPreProcCond PreCondit
hi def link svPreProcInc  Include
hi def link svPreProcDef  Define
hi def link svPreProcMisc PreProc

hi def link vStatement    Keyword
hi def link svStatement   Keyword
hi def link vConditional  Conditional
hi def link svConditional Conditional
hi def link vLoop         Repeat
hi def link svLoop        Repeat
"hi def link svOp          Operator
hi def link svOp          Special
hi def link vType         Type
hi def link svType        Type
hi def link vStorage      StorageClass
hi def link svStorage     StorageClass
hi def link vLabel        Label
hi def link svLabel       Label

hi def link  vSysFn       Function
hi def link svSysFn       Function
hi def link svObjFn       Function

hi def link svNum         Number
hi def link svString      String
hi def link svEscape      Special

" Finally tell VIM the syntax
let b:current_syntax = "systemverilog"

