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
MyArray  WORD 600h,500h,400h
ArraySize db 'The size of the Array (decimal) is %d',0
.code
main PROC
mov eax,SIZEOF MyArray
invoke crt_printf, addr ArraySize, eax

INVOKE ExitProcess,0
main ENDP
END main