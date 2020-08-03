TITLE ex1_5
include Irvine32.inc
.data
  num dd ?
  base dd ?
  bin db "二进制：",0
  oct db "八进制：",0
  deci db "十进制：",0
  hex  db "十六进制：",0
.code
main proc
  call readBase

  mov ebx,2
  mov edx,offset bin
  call writestring
  call writeBase
  call crlf

  mov ebx,8
  mov edx,offset oct
  call writestring
  call writeBase
  call crlf

  mov ebx,10
  mov edx,offset deci
  call writestring
  call writeBase
  call crlf

  mov ebx,16
  mov edx,offset hex
  call writestring
  call writeBase
  call crlf

  exit
main endp

; unsign base(ebx) input
; return: eax(10)
readBase proc
.data
  len = 80
  buffer db len dup(0),0
  a dd 0
  msg1 db "请输入任意进制整数：",0
  msg2 db "请输入进制（2，8，10，16）：",0
.code
  push edx
  push ecx
  ; assume input normal
  ; no character
  mov edx,offset msg1
  call writestring
  mov edx,offset buffer
  mov ecx,len
  call readstring
  push edx
  mov edx,offset msg2
  call writestring
  pop edx
  call readint
  mov ebx,eax
  mov esi,0

again:
  mov eax,0
  mov al,buffer[esi]
  cmp eax,0
  jz final
  add esi,1
  cmp al,58
  jl digit
  jmp char

digit:
  sub eax,48  
  cmp eax,0
  jle final
  cmp eax,ebx
  jge final
  jmp assign
  
char:
  sub eax,55
  cmp eax,16
  jge final
  cmp ebx,16
  jz assign
  jmp final

assign:
  mov edi,eax
  mov eax,a
  push edx
  mul ebx
  pop edx
  add eax,edi
  mov a,eax
  jmp again

final:
  mov eax,a
  pop ecx
  pop edx
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