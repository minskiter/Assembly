TITLE max array
include Irvine32.inc
.data
  array dd 1,2,3,4,55,6,7,8,10
  len dd ($-array)/4
.code
main proc
  mov edx,offset array
  mov ecx,len
  call max
  call writeint
main endp
; get edx[ecx] max ,return eax
max proc
  push ecx
  sub ecx,1
  mov eax,dword ptr [edx+4*ecx]
  jmp next
again:
  cmp eax,dword ptr [edx+4*ecx]
  jl assign
  jmp next
assign:
  mov eax,dword ptr [edx+4*ecx]
  jmp next;
next:
  sub ecx,1
  cmp ecx,0
  jz final
  jmp again
final:
  pop ecx
  ret
max endp
end main