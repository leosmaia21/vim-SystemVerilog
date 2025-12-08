SystemVerilog
============
This is a fork of [WeiChungWu/vim-SystemVerilog](https://github.com/WeiChungWu/vim-SystemVerilog), however it was moved to after folder to load the default vim highling before loading the plugin, and comment rules were disable, the entire line appear as comment now!

Support SystemVerilog: indent, syntax highlight, matchit

##About

The **syntax** file is modified from **Vera** syntax highlighting.  
The **indent** file is modified from **Verilog** indent file.  


* * *
Installation
----------------

###With [Pathogen](https://github.com/tpope/vim-pathogen)

Check out from github

     cd ~/.vim/bundle
     git clone git://github.com/WeiChungWu/vim-SystemVerilog.git

###Manual install details
Copy all files into your personal vim directory, keeping the directory structure.

* Ex.   
copy `ftdetect/systemverilog.vim` to `~/.vim/ftdetect`  
copy `ftplugin/systemverilog.vim` to `~/.vim/ftplugin`  
copy `indent/systemverilog.vim` to `~/.vim/indent`  
copy `syntax/systemverilog.vim` to `~/.vim/syntax`  
