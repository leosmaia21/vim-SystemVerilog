" SystemVerilog - after/syntax - clean version
" Based on Vera + leosmaia21 fixes
" Fixes: instance with ( on next line + param WIDTH / wIDTH + instance.member chain

if exists("b:current_syntax")
endif

"runtime! syntax/verilog.vim

" --- Extra SystemVerilog keywords ---
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
syn keyword verilogType logic bit byte shortint longint shortreal int unsigned chandle string void semaphore mailbox
syn keyword verilogStatement import export inside dist with fork join join_any join_none unique unique0 priority timeunit timeprecision var ref const protected local static automatic virtual new

" --- FIX 1: Instance with ( on next line ---
syn clear verilogInstantiation
syn clear verilogInstanceName
syn match verilogInstanceName contained "\<\h\w*\>"
syn match verilogInstantiation "\<\h\w*\>\_s\+\<\h\w*\>\_s*(\@=" contains=verilogInstanceName
syn match verilogInstantiation "\<\h\w*\>\_s\+\<\h\w*\>\_s*#\_s*(\@=" contains=verilogInstanceName
syn match verilogInstantiation "\<\h\w*\>\_s\+\<\h\w*\>\_s*#\_s*\_s*(\_s*.*\_s*)\_s*\_s*(\@=" contains=verilogInstanceName
hi def link verilogInstanceName Identifier

" --- FIX 2: Parameter WIDTH and wIDTH ---
syn clear verilogConstant
syn match verilogConstant "`\<\h\w*\>"
syn match verilogParamMixed "\<[A-Za-z][A-Z0-9_]\+\>" 
hi def link verilogParamMixed Constant

" --- FIX 3: Instance members CHAIN: a.b.c.d ---
" Clear old
syn clear verilogMember
syn clear verilogDotMember
syn clear verilogMemberName
syn clear verilogDotAccess
syn clear verilogDotAccessChain
syn clear verilogMethodCall

" Member name after dot (contained, will be highlighted)
syn match verilogMemberName contained "\<\h\w*\>"

" CHAIN: matches first identifier plus one or more .identifier
" Example: my_inst.a.b.c  -> my_inst = normal, .a .b .c = Function
" \(\s*\.\s*\<\h\w*\>\)\+ = one or more repetitions of .member
syn match verilogMemberChain "\<\h\w*\>\(\s*\.\s*\<\h\w*\>\)\+" contains=verilogMemberName
" Also match standalone .member for cases like .member inside struct assignment
syn match verilogDotOnly "\.\s*\<\h\w*\>" contains=verilogMemberName

" Method chain: a.b.c() - highlights c as Function when followed by (
syn match verilogMethodChain "\<\h\w*\>\(\s*\.\s*\<\h\w*\>\)*\s*\.\s*\<\h\w*\>\s*(\@=" contains=verilogMemberName

hi def link verilogMemberName Function
hi def link verilogMemberChain Operator
hi def link verilogDotOnly Operator
hi def link verilogMethodChain Function

" --- FIX 4: Comments ---
syn clear verilogComment
syn match verilogComment "//.*$" contains=verilogTodo,@Spell
syn region verilogComment start="/\*" end="\*/" contains=verilogTodo,@Spell fold

let b:current_syntax = "systemverilog"
