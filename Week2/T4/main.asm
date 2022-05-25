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
FibArray WORD 1,2, 10 DUP(0)
ShowArray db '%d ',0
Pointer DWORD FibArray
.code
main PROC


;循环计算fib数列
;cx存储循环次数
mov ecx,10d
mov esi,Pointer
add esi,4d
;
L1:
mov dx,0d
add dx,[esi - 4d]
add dx,[esi - 2d]
mov [esi],dx
add esi,2d
loop L1

;循环输出结果
mov ecx,12d
mov esi,Pointer
L2:
mov dx,[esi]
;printf会修改ecx结果，必须做好pushpop工作及时恢复
push ecx
invoke crt_printf, addr ShowArray, dx
pop ecx
add esi,2d
loop L2

INVOKE ExitProcess,0
main ENDP
END main