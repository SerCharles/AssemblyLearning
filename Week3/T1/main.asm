.386
.MODEL flat,stdcall
.STACK 4096
ExitProcess PROTO, dwExitCode:DWORD

option casemap:none ;�˴���ǳ���Ҫ��������뱨��
;include�ļ�
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
push ebp    ;����ebp��esp���洢�Ĵ���
mov ebp,esp
push edx
push esi

mov esi,[ebp + 8]
mov edx,0h
mov eax,esi
cmp esi,edx ;�ж�����
jNL EndAbs
Not eax;eaxȡ�෴��
inc eax
EndAbs:
pop esi
pop edx	;����ebp��esp���ָ��Ĵ���
pop ebp
ret 4
ABS ENDP


GCD PROC
push ebp    ;����ebp��esp���洢�Ĵ���
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
div ecx;������ int n = x % y, n = edx
mov esi,ecx ;x = y
mov ecx,edx ;y = n
.UNTIL ecx <= 0
mov eax,esi;return x

pop ecx
pop esi
pop edx	;����ebp��esp���ָ��Ĵ���
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