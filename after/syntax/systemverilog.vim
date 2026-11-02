" Vim syntax file - FINAL minimal + UVM
" Language: SystemVerilog
" Requires: nvim's native verilog.vim (already loaded by systemverilog.vim)
" Only contains what nvim does NOT have + your fixes

" --- FIX 1: Instance name with ( on next line ---
" nvim uses \s (space/tab only) so my_mod my_inst\n( fails
for s:g in ["verilogInstantiation", "verilogInstanceName"]
  if hlexists(s:g)
    execute 'syn clear ' .. s:g
  endif
endfor
" Highlight ONLY the instance name (2nd word); module name left untouched
syn match verilogInstantiation "\<\h\w*\>\_s\+\zs\<\h\w*\>\ze\%(\_s\|//.*\n\)*("
syn match verilogInstantiation "\(#\_s*(\_[^;]\{-})\_s*\)\@300<=\<\h\w*\>\ze\%(\_s\|//.*\n\)*("
hi link verilogInstantiation svInstanceName
hi def svInstanceName guifg=#ff9e64 ctermfg=215 gui=bold cterm=bold

" --- FIX 2: Parameter WIDTH and wIDTH ---
" Matches: WIDTH, MY_PARAM, wIDTH, pDEPTH (first A-Z or a-z, rest UPPERCASE)
syn match svUserConstant "\<[A-Za-z][A-Z0-9_]\+\>"
hi def link svUserConstant Constant

" --- FIX 3: Member chain a.b.c and port .clk( ---
syn match svMemberName contained "\.\s*\zs\<\h\w*\>"
syn match svMemberChain "\<\h\w*\>\(\s*\.\s*\<\h\w*\>\)\+" contains=svMemberName
syn match svPortName contained "\<\h\w*\>"
syn match svPortConn "\.\s*\<\h\w*\>\s*(\@=" contains=svPortName
hi def link svMemberName Function
hi def link svPortName Type

" --- UVM: Macros `uvm_* and `ovm_* (not in nvim native) ---
syn match svUvmMacro "`\(u\|o\)vm_\w\+"
hi def link svUvmMacro Function

" --- UVM/Class methods (not in nvim native) ---
syn keyword svMethods atobin atohex atoi atooct atoreal backref bittostr capacity
syn keyword svMethods compare constraint_mode DisableTrigger DoAction empty EnableCount EnableTrigger Event find
syn keyword svMethods find_index find_first find_first_index find_last find_last_index
syn keyword svMethods GetAssert get_at_least get_auto_bin getc GetCount get_coverage_goal get_cov_weight
syn keyword svMethods get_cross_bin_max GetFirstAssert GetName GetNextAssert get_status get_status_msg hide hash
syn keyword svMethods icompare insert inst_get_at_least inst_get_auto_bin_max inst_get_collect
syn keyword svMethods inst_get_coverage_goal inst_get_cov_weight inst_getcross_bin_max inst_query
syn keyword svMethods inst_set_at_least inst_set_auto_bin_max inst_set_bin_activiation inst_set_collect
syn keyword svMethods inst_set_coverage_goal inst_set_cov_weight inst_set_cross_bin_max itoa last_index
syn keyword svMethods len load match max max_index min min_index new object_compare object_copy object_print pack pick_index
syn keyword svMethods pop_back pop_front post_boundary postmatch post_pack post_randomize post_unpack
syn keyword svMethods pre_boundary prematch pre_pack pre_randomize pre_unpack product push_back push_front putc query
syn keyword svMethods query_str rand_mode randomize reserve reverse rsort search set_at_least set_auto_bin_max
syn keyword svMethods set_bin_activiation set_coverage_goal set_cov_weight set_cross_bin_max shuffle size sort substr sum
syn keyword svMethods thismatch tolower toupper unique_index Wait num delete exists first last next prev
hi def link svMethods Statement

let b:current_syntax = "systemverilog"

