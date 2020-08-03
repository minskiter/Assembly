TITLE s
include Irvine32.inc
.data
  array dd 1,1
.code
main proc
  lea edx,array
  add edx,8
  call printLine
  exit
main endp

;outLine
printLine proc
  pushad
  mov ecx,8
again:
  cmp ecx,[edx-4]
  je outputO
outputZ:
  mov al,'0'
  jmp next;
outputO:
  mov al,'1'
next:
  call writechar
  mov al,' '
  call writechar
  loop again
final:
  call crlf
  popad
  ret
printLine endp

bit proc
  push ebx
  mov ebx,eax
  neg ebx
  and eax,ebx
  pop ebx
  ret
bit endp

bitnum proc
  call bit
  push ecx
  mov ecx,0
again:
  cmp eax,0
  jle final
  shr eax,1
  inc ecx
  jmp again
final:
  mov eax,ecx
  pop ecx
  ret
bitnum endp

; get binary 2=>10,3=>100..
getbit proc
  push ebx
  mov ebx,1
  dec eax
  push ecx
  mov cl,al
  shl ebx,cl
  pop ecx
  mov eax,ebx
  pop ebx
  ret
getbit endp

end main