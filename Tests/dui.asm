include irvine32.inc
.data
	H dd 3,1,5,7,2,4,9,6,10,8
	cnt dd ($-H)/4
	tmp dd 0
	child dd 0
	msg1 db "��ʼֵ: ",0
	msg2 db "���: ",0
.code
main proc
	lea edx,msg1
	call writestring
	call crlf
	lea edx,H 
	mov ecx,cnt
	call print
	call crlf

	; ��ʼֵ�������

	call heapsort

	lea edx,msg2
	call writestring
	call crlf
	lea edx,H
	mov ecx,cnt
	call print
	call crlf
	exit
main endp

print proc
	push ecx
	push eax
	push esi

	mov esi,0
again:	cmp esi,ecx
	jge final
	mov eax,[edx+4*esi]
	call writeint
	mov al,' '
	call writechar
	inc esi
	jmp again
final:
	pop esi
	pop eax
	pop ecx
	ret
print endp

; ebx �ǵ�ǰ���������ĸ��ڵ�
heapadjust proc	  ;heapadjust(H,s,length)  esi=s,ecx=length
	mov eax,[edx+4*esi] ; eax=>edx[esi]
	mov tmp,eax ;???tmp
	mov eax,esi ; eax=>esi
	push ebx
	mov ebx,2 
	push edx
	mul ebx
	inc eax ; eax=>eax<<1+1
	mov child,eax ; ?child
	pop edx
	pop ebx
	mov eax,child ;eax=>child?? �ظ�����???
again3:	cmp eax,ecx ;eax>length ret
	jge final3
	push eax 
	inc eax ;TODO: eax+1????Ϊʲô�Ǽ�һ��ԭ���Ѿ��ӹ�1��
	cmp eax,ecx ; eax>length ret
	jge L1
	pop eax ; ����eax�ֻ�ԭΪ-1
	push ebx
	push eax
	mov ebx,eax ; ebx=>eax,eax��ʱָ�����Ҷ���
	inc ebx ; TODO:ebx??? ����Ӧ�ô���,����Ӧ������ָ���Ҷ���
	; �����������ߣ�ebx=>�Ҷ��ӣ�eax=>�����
	mov ebx,[edx+4*ebx] ; ebx=>edx[ebx]
	mov eax,[edx+4*eax] ; eax=>eax[ebx] �����Ҷ��ӱȽ�
	cmp eax,ebx ; �������Ӵ����Ҷ��� goto L1
	jge L1
	pop eax
	pop ebx
	inc eax
	mov child,eax

L1:	push ebx 
	mov ebx,[edx+4*esi] ; esi �Ǹ��׽ڵ�
	push eax
	mov eax,[edx+4*eax]
	cmp ebx,eax ; ������ױȶ��Ӵ������
	jge final3
	mov [edx+4*esi],eax ;TODO: �����׵��ڶ��ӣ�������Ӧ�ý�����
	pop eax
	mov esi,eax
	push eax
	mov eax,esi 
	mov ebx,2
	push edx
	mul ebx
	inc eax
	mov child,eax
	pop edx
	pop eax
	pop ebx
	mov eax,child

	push eax
	mov eax,tmp
	mov [edx+4*esi],eax
	pop eax
	jmp again3

final3:	ret
heapadjust endp

buildingheap proc ;��ʼ����
	push edx 
	mov eax,cnt 
	dec eax 
	mov ebx,2 ; TODO: ����edx Ӧ�� mov edx,0
	div ebx
	mov ebx,eax ; ebx=(cnt-1)>>1 >> shr ���Ʋ���
	pop edx
again2:
	cmp ebx,0 ; ebx <0
	jl final2
	push esi ;����esi
	mov ecx,cnt
	mov esi,ebx
	call heapadjust
	pop esi
	dec ebx
	jmp again2
final2:	ret
buildingheap endp

heapsort proc
	call buildingheap  ;buildingheap(H,length)
	mov eax,cnt ; cnt ����
	dec eax ; eax=>cnt-1 ,���һ��Ԫ��
	mov esi,eax ; esi =>cnt-1,ѭ������
again1:	
	cmp esi,1 ; esi<1 �����
	jb final1
	mov eax,[edx+4*esi] ; ����edx[0],edx[esi]
	mov ebx,[edx]
	mov [edx+4*esi],ebx
	mov [edx],eax
	push esi ; ��ʱ����esi
	push ecx
	mov ecx,esi ; ecx ���һ��Ԫ��
	mov esi,0  ; esi=>0
	call heapadjust	   ;heapadjust(H,0,i)
	pop ecx ; ��ԭ�ֳ�
	pop esi
	dec esi ; loop
	jmp again1
final1:	ret
heapsort endp

end main