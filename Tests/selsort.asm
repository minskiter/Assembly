TITLE select sort
include Irvine32.inc
.data
  array dd 60,30,40,50,1,60,30,40,30,40,50,1,70,100,80,20,5
  num dd ($-array)/4
.code
main proc
  mov edx,offset array
  mov ecx,num
  call print
  call sort
  call print
  exit
main endp

; print edx[ecx]
print proc
  pushad
  mov esi,ecx
again:
  push edi
  mov edi,esi
  sub edi,ecx
  mov eax,dword ptr [edx+edi*4]
  pop edi
  call writeint
  mov al,' '
  call writechar
  jmp next
next:
  sub ecx,1
  cmp ecx,0
  jz final
  jmp again
final:
  call crlf
  popad
  ret
print endp

; select sort edx[ecx]
sort proc
  pushad
  dec ecx
again:
  
  call maxi

;   get *edi
  mov eax,esi
  mov ebx,edx
  call address
  mov edi,ebx

  ; get *esi
  mov eax,ecx
  mov ebx,edx
  call address
  mov esi,ebx

; call print 
;   pushad
;   mov eax,[edx+4*esi]
;   mov ebx,[edx+4*ecx-4]
;   mov [edx+4*esi],ebx
;   mov [edx+4*ecx-4],eax
;   popad
  call swap
;   call print 
;   exit
  jmp next
  
next:
  sub ecx,1
  
  cmp ecx,1
  jz final
  jmp again
final:
  popad
  ret
sort endp

; get offset address return ebx+eax*4=>ebx 
address proc
  push edx
  push ebx
  mov ebx,4
  mul ebx
  pop ebx
  add ebx,eax
  pop edx
  ret
address endp

; get edx[ecx] max ,return esi(index)
maxi proc
  push ecx
  push eax
  sub ecx,1
  jmp assign
again:
  cmp eax,dword ptr [edx+4*ecx]
  jl assign
  jmp next
assign:
  mov eax,dword ptr [edx+4*ecx]
  mov esi,ecx
  jmp next;
next:
  sub ecx,1
  cmp ecx,-1
  jz final
  jmp again
final:
  pop eax
  pop ecx
  ret
maxi endp

; swap(*esi,*edi)
swap proc
  cmp esi,edi
  jz final
  push eax
  mov eax,[esi]
  push eax
  mov eax,[edi]
  mov [esi],eax
  pop eax
  mov [edi],eax
  pop eax
final:
  ret
swap endp

end main