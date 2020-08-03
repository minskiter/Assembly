include irvine32.inc
.data
	H dd 3,1,5,7,2,4,9,6,10,8
	cnt dd ($-H)/4
	tmp dd 0
	child dd 0
	msg1 db "初始值: ",0
	msg2 db "结果: ",0
.code
main proc
	lea edx,msg1
	call writestring
	call crlf
	lea edx,H 
	mov ecx,cnt
	call print
	call crlf

	; 初始值输出都对

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

; ebx 是当前调整子树的根节点
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
	mov eax,child ;eax=>child?? 重复操作???
again3:	cmp eax,ecx ;eax>length ret
	jge final3
	push eax 
	inc eax ;TODO: eax+1????为什么是加一，原本已经加过1了
	cmp eax,ecx ; eax>length ret
	jge L1
	pop eax ; 这里eax又还原为-1
	push ebx
	push eax
	mov ebx,eax ; ebx=>eax,eax此时指的是右儿子
	inc ebx ; TODO:ebx??? 这里应该错了,这里应该是想指向右儿子
	; 假设下面政策，ebx=>右儿子，eax=>左儿子
	mov ebx,[edx+4*ebx] ; ebx=>edx[ebx]
	mov eax,[edx+4*eax] ; eax=>eax[ebx] ；左右儿子比较
	cmp eax,ebx ; 如果左儿子大于右儿子 goto L1
	jge L1
	pop eax
	pop ebx
	inc eax
	mov child,eax

L1:	push ebx 
	mov ebx,[edx+4*esi] ; esi 是父亲节点
	push eax
	mov eax,[edx+4*eax]
	cmp ebx,eax ; 如果父亲比儿子大，则结束
	jge final3
	mov [edx+4*esi],eax ;TODO: 否则父亲等于儿子？？不是应该交换吗
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

buildingheap proc ;初始化堆
	push edx 
	mov eax,cnt 
	dec eax 
	mov ebx,2 ; TODO: 这里edx 应该 mov edx,0
	div ebx
	mov ebx,eax ; ebx=(cnt-1)>>1 >> shr 右移操作
	pop edx
again2:
	cmp ebx,0 ; ebx <0
	jl final2
	push esi ;保存esi
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
	mov eax,cnt ; cnt 数量
	dec eax ; eax=>cnt-1 ,最后一个元素
	mov esi,eax ; esi =>cnt-1,循环变量
again1:	
	cmp esi,1 ; esi<1 则结束
	jb final1
	mov eax,[edx+4*esi] ; 交换edx[0],edx[esi]
	mov ebx,[edx]
	mov [edx+4*esi],ebx
	mov [edx],eax
	push esi ; 临时保存esi
	push ecx
	mov ecx,esi ; ecx 最后一个元素
	mov esi,0  ; esi=>0
	call heapadjust	   ;heapadjust(H,0,i)
	pop ecx ; 还原现场
	pop esi
	dec esi ; loop
	jmp again1
final1:	ret
heapsort endp

end main