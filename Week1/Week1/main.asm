.386
.model flat,stdcall
option casemap:none ;此代码非常重要，否则编译报错
;include文件
include     windows.inc
include     user32.inc
includelib  user32.lib
include     masm32.inc
includelib  masm32.lib
include     kernel32.inc
includelib  kernel32.lib
;数据段
.data
szText       db '姓名：沈冠霖, 性别：男， 学号：2017013569，班级：软73'


;代码段
.code
main:
invoke StdOut, addr szText
invoke ExitProcess,0
end main