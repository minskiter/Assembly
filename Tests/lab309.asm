;选择排序。
include irvine32.inc
.data
	array  dd 1,2,3,40,5,6,100,-40,5,6,87,99
	num    dd ($-array)/4
.code
main proc	
	mov  edx,offset array
	mov  edi,num
	call output
	call crlf
	mov  ecx,num

next:	cmp ecx,2 ;if num<2 then goto final
	jb  final
   	call maxi
    call writeint
    call crlf
		;swap( eax,num-1)
	mov ebx,[edx+4*eax]
    mov esi,[edx+4*ecx-4]
	mov [edx+4*eax],esi
	mov [edx+4*ecx-4],ebx
    call output
	call crlf
	dec ecx
    dec edi
	jmp next;
final:
	mov edx,offset array
	mov edi,num
	call output
	call crlf

	exit
main endp

maxi proc;
;edx存放数组首地址;edi存放数组元素个数
	push edi
	push edx
	push ebx
	push ecx
	mov eax,dword ptr[edx];eax存放最大值
	mov ebx,0  ;ebx存放最大值的下标
	mov ecx,0
again:	cmp ecx,edi
	jae final
	cmp eax,[edx+4*ecx]
	jge next
	mov eax,[edx+4*ecx]
	mov ebx,ecx
next:	inc ecx;add ecx,1
	jmp again
final:
	mov eax,ebx
	pop ecx
	pop ebx
	pop edx
	pop edi
	ret
maxi endp

output proc
;edx存放数组首地址
;edi存放数组元素个数
    pusha
	mov ebx,0
again:  cmp ebx,edi
	jae final
	mov eax,[edx+4*ebx]
	call writeint
	mov al,','
	call writechar
	inc ebx
	jmp again
final:
    popa
	ret
output endp
end  main
