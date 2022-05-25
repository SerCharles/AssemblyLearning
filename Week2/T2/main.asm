.386
.MODEL flat,stdcall
.STACK 4096
ExitProcess PROTO, dwExitCode:DWORD

option casemap:none ;此代码非常重要，否则编译报错
;include文件
include     windows.inc
include     user32.inc
includelib  user32.lib
include     masm32.inc
includelib  masm32.lib
include     kernel32.inc
includelib  kernel32.lib
include msvcrt.inc
includelib msvcrt.lib

.data
IntArray  WORD 500h, 400h, 300h, 200h, 100h
ArraySum db 'The Sum of the array (decimal) (no loop) is %d, the sum of the array (loop) is %d',0
Pointer DWORD IntArray
.code
main PROC
;非循环计算数组和
;长度为2，所以是2,4,6,8
mov ax,0h
add ax,[IntArray]
add ax,[IntArray + 2]
add ax,[IntArray + 4]
add ax,[IntArray + 6]
add ax,[IntArray + 8]

;循环计算数组和
;cx存储循环次数
mov dx,0h
mov ecx,LENGTHOF IntArray
mov esi,Pointer

L1:
add dx,[esi]
add esi,2d
loop L1

invoke crt_printf, addr ArraySum, ax, dx

INVOKE ExitProcess,0
main ENDP
END main