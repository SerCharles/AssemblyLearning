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
FibArray WORD 1,2, 10 DUP(0)
ShowArray db '%d ',0
Pointer DWORD FibArray
.code
main PROC


;ѭ������fib����
;cx�洢ѭ������
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

;ѭ��������
mov ecx,12d
mov esi,Pointer
L2:
mov dx,[esi]
;printf���޸�ecx�������������pushpop������ʱ�ָ�
push ecx
invoke crt_printf, addr ShowArray, dx
pop ecx
add esi,2d
loop L2

INVOKE ExitProcess,0
main ENDP
END main