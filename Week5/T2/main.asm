;.386
;.MODEL flat,stdcall
;.STACK 4096
;ExitProcess PROTO, dwExitCode:DWORD

;option casemap:none ;此代码非常重要，否则编译报错
;include文件
;include     windows.inc
;include     user32.inc
;includelib  user32.lib
;include     masm32.inc
;includelib  masm32.lib
;include     kernel32.inc
;includelib  kernel32.lib
include Irvine32.inc
;include msvcrt.inc
;includelib msvcrt.lib

.data
Num1 DWORD 7fffffffh
Num2 WORD 7fffh
Num3 Byte 7fh


mWriteInt MACRO Number
IF TYPE NUMBER EQ 4
	mov eax, Number
ELSE
	movzx eax, Number
ENDIF
call WriteInt
ENDM
	
.code
main PROC

mWriteInt Num1
mWriteInt Num2
mWriteInt Num3
INVOKE ExitProcess,0
main ENDP
END main