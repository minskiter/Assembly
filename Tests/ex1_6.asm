TITLE ex1_6
include Irvine32.inc
.data
  menu db "1)二进制",10,"2)八进制",10,"3)十进制",10,"4)十六进制",10,"请输入选项:",10,0
  menu2 db "请输入无符号整数:",10,0
.code
main proc
  mov edx,offset menu
  call writestring
  call readBase
  mov edx,offset menu2
  call writestring
  call readint
  call writeBase
main endp

; read ebx(base) return ebx
readBase proc 
  push eax
  call readint
  cmp eax,1
  jz bin
  cmp eax,2
  jz oct
  cmp eax,3
  jz deci
  cmp eax,4
  jz hex
  jmp final
bin:
  mov ebx,2
  jmp final
oct:
  mov ebx,8
  jmp final
deci:
  mov ebx,10
  jmp final
hex:
  mov ebx,16
  jmp final
final:
  pop eax
  ret
readBase endp


; unsign base(ebx) output
; receive: eax(num),ebx(base)
writeBase proc 
  push eax
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
  pop eax
  ret
writeBase endp
end main