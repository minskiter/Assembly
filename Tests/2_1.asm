TITLE compare a,b,c
Include Irvine32.inc
.data
  a dd ?
  b dd ?
  d dd ?
.code
main PROC
  call readint
  mov a,eax
  call readint
  mov b,eax
  call readint
  mov d,eax

  cmp a,eax
  jl L1
  mov eax,b
  cmp a,eax
  jl L2
  mov eax,a
  jmp L2

final:
  exit

L2:
  call writeint
  jmp final

L1:
  cmp b,eax
  jl L2


main ENDP
END main