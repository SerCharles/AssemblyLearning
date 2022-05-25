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
OutputLine1 db 'Stack parameters:',0Ah, 0Dh, 0
OutputLine2 db '---------------------------',0Ah, 0Dh, 0
OutputFormat db 'Address %08x = %08x',0Ah, 0Dh, 0

.code
ShowParams PROC num:DWORD
push edx
push ecx
push esi
push ebx
mov ecx,num;num=ecx

;输出基本信息
push ecx
invoke crt_printf, addr OutputLine1
invoke crt_printf,addr OutputLine2
pop ecx

mov edx,20d
;递归获取参数并且输出
GetParams:
mov ebx,ebp
add ebx,edx
mov esi,[ebx]
push edx
push ecx
push esi
push ebx
invoke crt_printf, addr OutputFormat, ebx, esi
pop ebx
pop esi
pop ecx
pop edx
add edx,4d
Loop GetParams

;退出函数
pop ebx
pop esi
pop ecx
pop edx
pop ebp
ret 4
ShowParams ENDP


MySample PROC first:DWORD, second:DWORD, third:DWORD, fourth:DWORD, fifth:DWORD, sixth:DWORD, seventh:DWORD
paramCount = 7
INVOKE ShowParams, paramCount
pop ebp
ret
MySample ENDP

main PROC
INVOKE MySample, 1234h, 5000h, 6543h,7197h,1837h,197h,193h
INVOKE ExitProcess,0
main ENDP
END main