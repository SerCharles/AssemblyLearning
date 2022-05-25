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
OutPutText BYTE ?
source BYTE 'This is the source string', 0
PointerSource DWORD source
PointerResult DWORD OutPutText
;代码段
.code
main:
;遍历拷贝
mov ecx,LENGTHOF source
mov esi,PointerSource
mov edi,PointerResult
L1:
mov al,[esi]
mov [edi],al
add esi,1d
add edi,1d
loop L1


;输出
invoke StdOut, addr OutPutText
invoke ExitProcess,0
end main