TITLE array 10 max
include Irvine32.inc
.data
a dd 10 dup(?)
max dd ?

.code
main proc
  mov ecx,0
  jmp L1
  
L1:
  call readint
  add ecx,1
  mov a[ecx],eax
  jmp compareMax

loopEnd:
  cmp ecx,10
  jz final
  jmp L1

final:
  mov eax,max
  call writeint
  exit

compareMax:
  mov eax,a[ecx]
  cmp ecx,1
  jz assign
  cmp eax,max
  jl loopEnd
  jmp assign

assign:
  mov max,eax
  jmp loopEnd


main endp
end main