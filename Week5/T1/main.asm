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
FileName db "Output.txt",0
RepeatTime DWORD 5d
ConsoleHandle DWORD ?
FileHandle DWORD ?
Bytes DWORD ?
StudentID Byte 100 DUP(?)
StudentName Byte 100 DUP(?)
StudentBirthday Byte 100 DUP(?)
OutputMessageID Byte "Please input the student ID.",0Ah,0Dh 
OutputMessageName Byte "Please input the student Name.",0Ah,0Dh
OutputMessageBirthday Byte "Please input the student Birthday.",0Ah,0Dh 


.code
ReadAndWrite PROC
;��дѧ��
	; Get the console output handle:
	INVOKE GetStdHandle, STD_OUTPUT_HANDLE
	mov ConsoleHandle,eax
	mov ebx, SIZEOF OutputMessageID

	; Write a string to the console:
	INVOKE WriteConsole,
	ConsoleHandle,; console output handle
	ADDR OutputMessageID, ; string pointer
	ebx,; string length
	ADDR Bytes,; ret num bytes written
	0; not used
	
	; Get the console output handle:
	INVOKE GetStdHandle, STD_INPUT_HANDLE
	mov ConsoleHandle,eax
	mov ebx,100d

	; Write a string to the console:
	INVOKE ReadConsole,
	ConsoleHandle,; console output handle
	ADDR StudentID, ; string pointer
	ebx,; string length
	ADDR Bytes,; ret num bytes read
	0; not used

	mov ebx,Bytes
	INVOKE WriteFile,
	FileHandle,
	ADDR StudentID,
	ebx,
	ADDR Bytes,
	NULL

	;��д����
	; Get the console output handle:
	INVOKE GetStdHandle, STD_OUTPUT_HANDLE
	mov ConsoleHandle,eax
	mov ebx, SIZEOF OutputMessageName

	; Write a string to the console:
	INVOKE WriteConsole,
	ConsoleHandle,; console output handle
	ADDR OutputMessageName, ; string pointer
	ebx,; string length
	ADDR Bytes,; ret num bytes written
	0; not used
	
	; Get the console output handle:
	INVOKE GetStdHandle, STD_INPUT_HANDLE
	mov ConsoleHandle,eax
	mov ebx,100d

	; Write a string to the console:
	INVOKE ReadConsole,
	ConsoleHandle,; console output handle
	ADDR StudentName, ; string pointer
	ebx,; string length
	ADDR Bytes,; ret num bytes read
	0; not used

	mov ebx,Bytes
	INVOKE WriteFile,
	FileHandle,
	ADDR StudentName,
	ebx,
	ADDR Bytes,
	NULL

	;��д����
	; Get the console output handle:
	INVOKE GetStdHandle, STD_OUTPUT_HANDLE
	mov ConsoleHandle,eax
	mov ebx, SIZEOF OutputMessageBirthday

	; Write a string to the console:
	INVOKE WriteConsole,
	ConsoleHandle,; console output handle
	ADDR OutputMessageBirthday, ; string pointer
	ebx,; string length
	ADDR Bytes,; ret num bytes written
	0; not used
	
	; Get the console output handle:
	INVOKE GetStdHandle, STD_INPUT_HANDLE
	mov ConsoleHandle,eax
	mov ebx,100d

	; Write a string to the console:
	INVOKE ReadConsole,
	ConsoleHandle,; console output handle
	ADDR StudentBirthday, ; string pointer
	ebx,; string length
	ADDR Bytes,; ret num bytes read
	0; not used

	mov ebx,Bytes
	INVOKE WriteFile,
	FileHandle,
	ADDR StudentBirthday,
	ebx,
	ADDR Bytes,
	NULL

	ret
ReadAndWrite ENDP


main PROC
;���ļ�����ȡ���
INVOKE CreateFile,
ADDR FileName,
GENERIC_WRITE, 
0, 
NULL, 
CREATE_ALWAYS, 
FILE_ATTRIBUTE_NORMAL, 
0
mov FileHandle,eax
mov ecx,RepeatTime

L1:
	push ecx
	INVOKE ReadAndWrite
	pop ecx
Loop L1



INVOKE ExitProcess,0
main ENDP
END main