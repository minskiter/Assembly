TITLE ex1_2
include Irvine32.inc
.data
  array dd 11,2,3,4,5,6,-7,8,9,13,17,19,20
  num dd ($-array)/4
  array1 dd 11,2,3,4,5,6,24,8,9,13,17,19,20
  num1 dd ($-array1)/4
  array2 dd 11,2,3,4,5,6,50,100,9,13,17,19,20
  num2 dd ($-array2)/4
.code
main proc
  mov edx,offset array
  mov ecx,num
  call maxi
  mov eax,esi
  call writeint
  call crlf

  mov edx,offset array1
  mov ecx,num1
  call maxi
  mov eax,esi
  call writeint
  call crlf

  mov edx,offset array2
  mov ecx,num2
  call maxi
  mov eax,esi
  call writeint
  call crlf
  exit
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