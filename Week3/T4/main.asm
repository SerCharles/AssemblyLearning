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
ShowArray db '%d ',0
ChangeLine db ' ',0Ah, 0Dh, 0
myArray1 WORD 3, 1, 7, 5, 2, 9, 4, 3
myArray2 WORD 114,514,1919,810
myArray3 WORD 1701,1871,1763,1814,1949,1919,1990
myArray4 WORD 1
myArray5 WORD 18,2,1923,10,38,18,138,139,1,2,13,13,3,41,212,1
LenLess DWORD ?

.code
Sort PROC Pointer:DWORD, Len:DWORD

push esi
push ebx
push edi
push eax
push edx
push ecx

;输出原始数组
mov edi,Pointer ;指针
mov ebx,0 ;索引i
.WHILE ebx < Len
	mov dx,[edi]
	invoke crt_printf, addr ShowArray, dx
	inc edi
	inc edi
	inc ebx
.ENDW
invoke crt_printf, addr ChangeLine

;排序
mov ecx,1     ;是否交换的标志
mov edi,Pointer ;f[j]位置
mov ebx,0 ;索引i
.WHILE ebx < Len && ecx != 0
	mov eax,0 ;eax:j,记录内层循环位置
	mov ecx,0 ;ecx:标签，记录是否交换
	mov edi,Pointer
	
	;j循环结束：Lenless
	mov esi,Len
	mov LenLess,esi
	sub LenLess,1
	sub LenLess,ebx


	.WHILE eax < LenLess
		mov si,[edi] ;f[j]
		mov dx,[edi + 2] ;f[j+1]
		cmp si,dx
		jNA EndSwap
		;交换
		mov [edi + 2],si
		mov [edi],dx
		mov ecx,1
		EndSwap:
		;j++
		inc edi
		inc edi
		inc eax
	.ENDW
	;i++
	inc ebx
.ENDW

;输出新数组
mov edi,Pointer ;指针
mov ebx,0 ;索引i
.WHILE ebx < Len
	mov dx,[edi]
	invoke crt_printf, addr ShowArray, dx
	inc edi
	inc edi
	inc ebx
.ENDW
invoke crt_printf, addr ChangeLine

pop ecx
pop edx
pop eax
pop esi
pop ebx
pop edi
ret
Sort ENDP


main PROC
mov eax, LENGTHOF myArray1
invoke Sort, ADDR myArray1,eax
mov eax, LENGTHOF myArray2
invoke Sort, ADDR myArray2,eax
mov eax, LENGTHOF myArray3
invoke Sort, ADDR myArray3,eax
mov eax, LENGTHOF myArray4
invoke Sort, ADDR myArray4,eax
mov eax, LENGTHOF myArray5
invoke Sort, ADDR myArray5,eax
INVOKE ExitProcess,0
main ENDP
END main