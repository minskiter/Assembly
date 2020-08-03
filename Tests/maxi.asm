TITLE max array
include Irvine32.inc
.data
  array dd 1,2,3,4,55,6,7,8,10
  len dd ($-array)/4
.code
main proc
  mov edx,offset array
  mov ecx,len
  call maxi
  mov eax,esi
  call writeint
main endp
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
end main