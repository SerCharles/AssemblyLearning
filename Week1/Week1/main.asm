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
;���ݶ�
.data
szText       db '�����������, �Ա��У� ѧ�ţ�2017013569���༶����73'


;�����
.code
main:
invoke StdOut, addr szText
invoke ExitProcess,0
end main