TITLE ex1_4
include Irvine32.inc
.data
  num dd -1
.code
main proc
  mov eax,num
  mov ebx,10
  call writeUnDec
  exit
main endp

; unsign base(ebx) output
; receive: eax(num),ebx(base)
writeUnDec proc 
  push ebx
  push ecx
  push edx

  mov ecx,1
  jmp again

again:
  add ecx,1
  mov edx,0
  div ebx
  push edx
  cmp eax,0
  jz output
  jmp again

output:
  sub ecx,1
  cmp ecx,0
  jz final
  pop eax
  cmp eax,10
  jge outputChar
  jmp outputDigit

outputDigit:
  add eax,48
  call writechar
  jmp output

outputChar:
  add eax,55
  call writechar
  jmp output
  
final:
  pop edx
  pop ecx
  pop ebx
  ret
writeUnDec endp
end main