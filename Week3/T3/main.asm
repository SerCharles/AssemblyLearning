.386
.model flat,stdcall
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

;���ݶ�
.data
targetStr BYTE "ABCDEDE10ICJEHB3829UCIbxihw", 10 DUP(0)
sourceStr BYTE "FGHCLJ2JB",0
OutputLine1 db ' is the target',0Ah, 0Dh, 0
OutputLine2 db ' is the source',0Ah, 0Dh, 0
OutputLine3 db ' is the concat answer',0Ah, 0Dh, 0


;�����
.code

Str_concat PROC, target:DWORD, source:DWORD
;����
push ebx
push ecx
push esi
push edx
push edi

;���source��target
invoke crt_printf, target
invoke crt_printf, addr OutputLine1
invoke crt_printf, source
invoke crt_printf, ADDR OutputLine2

;concat
mov ecx,0
;mov esi,LENGTHOF target
;mov ebx,LENGTHOF source

;�ҵ���λ
mov edi,target
mov al,[edi]
.WHILE al != 0
inc edi
inc ecx
mov al,[edi]
.ENDW

;concat
;��ʼ��
mov edi,target ;edi:Ŀ���ַ
add edi,ecx 
mov ecx,0h
mov esi,source ;esi:Դ��ַ

;����concat
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

;�˻�
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