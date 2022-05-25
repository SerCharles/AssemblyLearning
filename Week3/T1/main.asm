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
X1 SDWORD 48d
Y1 SDWORD -32d
X2 SDWORD 60d
Y2 SDWORD -12d
X3 SDWORD -7d
Y3 SDWORD 113d
ShowText db 'The GCD of %d and %d is %d (decimal)',0Ah, 0Dh, 0
.code
ABS PROC
push ebp    ;更新ebp，esp，存储寄存器
mov ebp,esp
push edx
push esi

mov esi,[ebp + 8]
mov edx,0h
mov eax,esi
cmp esi,edx ;判断正负
jNL EndAbs
Not eax;eax取相反数
inc eax
EndAbs:
pop esi
pop edx	;更新ebp，esp，恢复寄存器
pop ebp
ret 4
ABS ENDP


GCD PROC
push ebp    ;更新ebp，esp，存储寄存器
mov ebp,esp
push edx
push esi
push ecx

mov esi,[ebp+12];x
push esi
call ABS
mov esi,eax ;esi = abs(x)

mov ecx,[ebp+8];y
push ecx
call ABS
mov ecx,eax ;ecx = abs(y)

.REPEAT;do while
mov eax,esi
CDQ
div ecx;除法求 int n = x % y, n = edx
mov esi,ecx ;x = y
mov ecx,edx ;y = n
.UNTIL ecx <= 0
mov eax,esi;return x

pop ecx
pop esi
pop edx	;更新ebp，esp，恢复寄存器
pop ebp
ret 8
GCD ENDP


main PROC
mov esi,X1
mov ecx,Y1
push esi
push ecx
call GCD
invoke crt_printf, addr ShowText, esi, ecx, eax
mov esi,X2
mov ecx,Y2
push esi
push ecx
call GCD
invoke crt_printf, addr ShowText, esi, ecx, eax
mov esi,X3
mov ecx,Y3
push esi
push ecx
call GCD
invoke crt_printf, addr ShowText, esi, ecx, eax

INVOKE ExitProcess,0
main ENDP
END main