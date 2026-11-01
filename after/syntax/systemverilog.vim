" SystemVerilog - after/syntax - clean version
" Based on Vera + leosmaia21 fixes
" Fixes: instance with ( on next line + param WIDTH / wIDTH

if exists("b:current_syntax")
  " Don't finish, we want to load on top of verilog.vim
endif

" Load default verilog syntax first
" runtime! syntax/verilog.vim

" --- Extra SystemVerilog keywords (not in native verilog.vim) ---
syn keyword verilogStatement always_comb always_ff always_latch
syn keyword verilogStatement checker endchecker
syn keyword verilogStatement rand randc constraint
syn keyword verilogStatement interface endinterface modport
syn keyword verilogStatement package endpackage
syn keyword verilogStatement program endprogram
syn keyword verilogStatement class endclass extends implements
syn keyword verilogStatement function endfunction
syn keyword verilogStatement covergroup endgroup coverpoint cross
syn keyword verilogStatement property endproperty sequence endsequence
syn keyword verilogStatement let
syn keyword verilogType logic bit byte shortint longint shortreal
syn keyword verilogType int unsigned
syn keyword verilogType chandle string void
syn keyword verilogType semaphore mailbox
syn keyword verilogStatement import export
syn keyword verilogStatement inside dist with
syn keyword verilogStatement fork join join_any join_none
syn keyword verilogStatement unique unique0 priority
syn keyword verilogStatement timeunit timeprecision
syn keyword verilogStatement var ref const
syn keyword verilogStatement protected local
syn keyword verilogStatement static automatic
syn keyword verilogStatement virtual
syn keyword verilogStatement new

" --- FIX 1: Instance with ( on next line ---
" Clear old definitions if they exist
syn clear verilogInstantiation
syn clear verilogInstanceName

" Instance name (contained) - second identifier
syn match verilogInstanceName contained "\<\h\w*\>"

" Instantiation: <module> <instance> \_s* (
" \_s = space + tab + newline (allows ( on next line)
" (\@= = lookahead, does not include ( in the match
" contains = only highlights instance name as Identifier
syn match verilogInstantiation "\<\h\w*\>\_s\+\<\h\w*\>\_s*(\@=" contains=verilogInstanceName
syn match verilogInstantiation "\<\h\w*\>\_s\+\<\h\w*\>\_s*#\_s*(\@=" contains=verilogInstanceName
syn match verilogInstantiation "\<\h\w*\>\_s\+\<\h\w*\>\_s*#\_s*\_s*(\_s*.*\_s*)\_s*\_s*(\@=" contains=verilogInstanceName

hi def link verilogInstanceName Identifier

" --- FIX 2: Parameter WIDTH and wIDTH (first letter A-Z or a-z, rest UPPERCASE) ---
" Remove old rule that matched any UPPERCASE word anywhere
syn clear verilogConstant

" Redefine constant only for `DEFINE macros
syn match verilogConstant "`\<\h\w*\>"

" Our pattern: first letter can be upper or lower, rest MUST be UPPERCASE/NUMBER/_
" Matches: WIDTH, MY_PARAM, wIDTH, pDEPTH
" Does NOT match: width, myParam
syn match verilogParamMixed "\<[A-Za-z][A-Z0-9_]\+\>" 
hi def link verilogParamMixed Constant

" Optional: highlight parameter name in declaration with any case
" If you want 'parameter myParam' to also be Constant, uncomment:
" syn match verilogParamName contained "\<\h\w*\>"
" syn match verilogParamDecl "\<\(parameter\|localparam\)\>" nextgroup=verilogParamName skipwhite skipempty
" hi def link verilogParamName Constant
" hi def link verilogParamDecl StorageClass

" --- FIX 3: Comments (ensure // does not highlight whole line as infinite comment) ---
syn clear verilogComment
syn match verilogComment "//.*$" contains=verilogTodo,@Spell
syn region verilogComment start="/\*" end="\*/" contains=verilogTodo,@Spell fold

let b:current_syntax = "systemverilog"
