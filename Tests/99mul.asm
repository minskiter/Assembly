TITLE 99mul
include Irvine32.inc
.data

.code
main proc
  mov ecx,9
  mov esi,1
again:
  push ecx
  mov ecx,esi
  call outputLine
  inc esi
  pop ecx
  loop again
final:
  exit
main endp

; eax = esi*ecx
outputLine proc
  pushad
  mov ebx,ecx
  inc ebx
again:
  push ebx
  sub ebx,ecx
  mov eax,esi
  mov edx,0
  mul ebx
output:
  push eax 
  mov eax,ebx
  call writedec
  mov al,'x'
  call writechar
  mov eax,esi
  call writedec
  mov al,'='
  call writechar
  pop eax
  call writedec
  mov al,' '
  call writechar
next:
  pop ebx
  loop again
final:
  call crlf
  popad
  ret
outputLine endp
end main