TITLE ex2_2 perfect number
include Irvine32.inc
.data
  count dd 4
.code
main proc
  mov eax,1
  mov ecx,count
lloop:
  push eax
  call perfectNum
  cmp eax,1
  jz output
  pop eax
  jmp next
output:
  dec ecx
  pop eax
  call writeint
  call crlf
  jmp next
next:
  cmp ecx,0
  jle final
  inc eax
  jmp lloop
final:
  exit
main endp

; receive eax;return eax 1:true 0:false
perfectNum proc
  push ecx
  push edx
  push ebx
  mov ebx,0
  mov ecx,1
  mov edx,0
lloop:
  cmp ecx,eax
  jge comp
  push eax
  mov edx,0
  div ecx
  cmp edx,0
  jz assign
next:
  pop eax
  inc ecx
  jmp lloop
assign:
  add ebx,ecx
  jmp next
comp:
  cmp ebx,eax
  jz atrue
  jmp afalse
atrue:
  mov eax,1
  jmp final
afalse:
  mov eax,0
  jmp final
final:
  pop ebx
  pop edx
  pop ecx
  ret
perfectNum endp

end main