TITLE ex1_1
include Irvine32.inc
.data
  array dd 60,30,40,50,1,60,30,40,30,40,50,1,70,100,80,20,5
  num dd ($-array)/4
.code
main proc
  mov edx,offset array
  mov ecx,num
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
  cmp eax,[edx+4*ecx]
  jl assign
  jmp next
assign:
  mov eax,[edx+4*ecx]
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