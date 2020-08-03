include irvine32.inc
.data
	chess dd 64 dup(0)
	a     dd 8  dup(1)
	b     dd 15 dup(1)
	d     dd 15 dup(1)
	msg1 db "第",0
	msg2 db "种可能的摆法: ",0
	msg3 db "按回车键继续...",0
	msg4 db "        ",0
	msg5 db "八皇后摆法总数: ",0
.code	
main proc
	mov ecx,0		;ecx=n
	mov esi,0		;esi=sum   
	call putqueen		;putqueen(0)
	lea edx,msg5
	call writestring
	mov eax,esi
	call writedec
	call crlf

	exit
main endp

putqueen proc
	pushad 
	mov ebx,0   ;ebx=col
again:	
	cmp ebx,8   ;for循环
	jge final

	cmp a[4*ebx],1
	jne L4

	mov eax,ebx
	add eax,ecx
	cmp b[4*eax],1
	jne L4

	mov eax,ecx
	sub eax,ebx
	add eax,7
	cmp d[4*eax],1
	jne L4			;以上，判断安全位置,if(a[col]&&b[n+col]&&c[n-col+7])

	mov eax,ecx
	mov edi,8
	mul edi
	add eax,ebx
	mov chess[4*eax],1	;以上放置皇后,chess[n][col]=1
	
	mov a[4*ebx],0

	mov eax,ebx
	add eax,ecx
	mov b[4*eax],0
	
	mov eax,ecx
	sub eax,ebx
	add eax,7
	mov d[4*eax],0
				;以上,a[col]=0,b[n+col]=0,d[n-col+7]=0
	cmp ecx,7		;if(n==7)
	jne L1			
	inc esi			;sum++

	lea edx,msg1		;输出皇后摆法
	call writestring      
	mov eax,esi
	call writedec
	lea edx,msg2
	call writestring
	call crlf

	push ecx
	push esi		
	mov esi,0		;esi=i,ecx=j
	mov ecx,0
again1: cmp esi,8		;for(i=0;i<8;i++)
	jge L3
	lea edx,msg4
	call writestring	;printf /t/t
again2:	cmp ecx,8		;for(j=0;j<8;j++)
	jge L2
	mov eax,esi
	mov edi,8
	mul edi
	add eax,ecx
	mov eax,chess[4*eax]
	call writedec		;输出chess[i][j]
	mov al,' '
	call writechar
	call crlf
	inc ecx			;j++
	jmp again2
L2:	inc esi			;i++
	mov ecx,0		;j=0
	jmp again1
L3:	pop esi
	pop ecx
	call crlf

	mov eax,esi		;每输入十种暂停
	mov edx,0
	push ebx
	mov ebx,10
	div ebx
	pop ebx
	cmp edx,0
	jne L5
	lea edx,msg3
	call writestring
	call readchar
	jmp L5
L1:	
	push ecx
	inc ecx
	call putqueen		;递归   putqueen(n+1)
	pop ecx

L5:	mov eax,ecx
	mov edi,8
	mul edi
	add eax,ebx
	mov chess[4*eax],0	;以上，取消皇后，chess[n][col]=0

			
	mov eax,ecx		
	add eax,ebx		
	mov b[4*eax],1

	mov eax,ecx
	sub eax,ebx
	add eax,7
	mov d[4*eax],1
	
	mov a[4*ebx],1
				;以上，b[n+col]=1,d[n-col+7]=1,a[col]=1
L4:	inc ebx
	jmp again
final:	
popad
ret

putqueen endp

end  main