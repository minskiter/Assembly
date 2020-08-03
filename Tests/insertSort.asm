TITLE sort
include Irvine32.inc
.data
  array dd 5,6,7,8,91,-1,23,45
  n dd ($-array)/4
.code
main proc
  lea edx,array
  mov ecx,n
  call sort
  call print
  exit
main endp

sort proc
  pushad 
  mov ebx,ecx
again:
  push ecx
  mov eax,ebx
  sub eax,ecx
  mov ecx,eax
  call insert
  pop ecx
  loop again
final:
  popad
  ret
sort endp

; insert edx[ecx],count ecx
insert proc
  pushad
  mov eax,[edx+ecx*4] ;eax=>temp
  cmp ecx,0
  jle final
again:
  cmp eax,[edx+ecx*4-4]
  jge final
  mov ebx,[edx+ecx*4-4]
  mov [edx+ecx*4],ebx
  loop again
final:
  mov [edx+ecx*4],eax
  popad
  ret
insert endp

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

end main