.386
.model flat,stdcall
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

;数据段
.data
targetStr BYTE "ABCDEDE10ICJEHB3829UCIbxihw", 10 DUP(0)
sourceStr BYTE "FGHCLJ2JB",0
OutputLine1 db ' is the target',0Ah, 0Dh, 0
OutputLine2 db ' is the source',0Ah, 0Dh, 0
OutputLine3 db ' is the concat answer',0Ah, 0Dh, 0


;代码段
.code

Str_concat PROC, target:DWORD, source:DWORD
;调用
push ebx
push ecx
push esi
push edx
push edi

;输出source和target
invoke crt_printf, target
invoke crt_printf, addr OutputLine1
invoke crt_printf, source
invoke crt_printf, ADDR OutputLine2

;concat
mov ecx,0
;mov esi,LENGTHOF target
;mov ebx,LENGTHOF source

;找到空位
mov edi,target
mov al,[edi]
.WHILE al != 0
inc edi
inc ecx
mov al,[edi]
.ENDW

;concat
;初始化
mov edi,target ;edi:目标地址
add edi,ecx 
mov ecx,0h
mov esi,source ;esi:源地址

;遍历concat
mov al,[esi]
.WHILE al != 0
mov [edi],al
inc edi
inc esi
inc ecx
mov al,[esi]
.ENDW

invoke crt_printf, target
invoke crt_printf, addr OutputLine3

;退回
pop edi
pop edx
pop esi
pop ecx
pop ebx
ret
Str_concat ENDP


main PROC
invoke Str_concat, ADDR targetStr, ADDR sourceStr
invoke ExitProcess,0
main ENDP



end main