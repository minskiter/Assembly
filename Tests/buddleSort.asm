TITLE s
include Irvine32.inc
.data
  array dd 100 dup(0)
  n dd ?
.code
main proc
  call readint
  mov n,eax
  mov ecx,n
  lea edx,array
  call readArray
  call sort
  call print
final:
  exit
main endp

; input array;array=>edx,ecx
readArray  proc
  pushad
  mov ebx,ecx
again:
  call readint
  push ebx
  sub ebx,ecx
  mov [edx+ebx*4],eax
  pop ebx
  loop again
final:
  popad
  ret
readArray endp

; buddle sort array=>edx,length=>ecx
sort proc
  pushad
  mov ebx,ecx
again:
  call buddle
  loop again
final:
  popad
  ret
sort endp

; buddle max array=>edx,length=>ecx
buddle proc
  pushad
  mov ebx,ecx
  dec ecx
  cmp ecx,0
  jle final
again:
  push ebx
  sub ebx,ecx
  mov eax,[edx+ebx*4-4]
  cmp eax,[edx+ebx*4]
  jle next
  mov edi,[edx+ebx*4-4]
  mov esi,[edx+ebx*4]
  mov [edx+ebx*4-4],esi
  mov [edx+ebx*4],edi
next:
  pop ebx
  loop again
final:
  popad
  ret
buddle endp

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

