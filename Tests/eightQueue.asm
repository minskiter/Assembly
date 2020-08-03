; encoding UTF-8
TITLE queues
include Irvine32.inc
.data
  col dd 0ffh ;列 二进制11111111
  forward dd 0ffffh ;正对角线 row+col-1
  backward dd 0ffffh ;反对角线 row-col+8
  box dd 16 dup(0) ; 存放位置
  count dd 1
.code
main proc
  ; 按照行来循环
  mov ecx,8 ; ecx =>当前第几个皇后
  push backward ;[ebp+8]
  push forward ;[ebp+4]
  push col ;[ebp]
  lea edx,box
  lea edi,count
  call queues
final:
  exit
main endp

queues proc
  push ebp
  mov ebp,esp
  add ebp,8
  pushad
  call putQueue
final:
  popad
  pop ebp
  ret 12
queues endp

putQueue proc
  pushad
  cmp ecx,0
  jle output
  mov eax,[ebp] ; eax暂存列

again:
  cmp eax,0
  jle final

  mov esi,eax

  ; 判断正对角线
  call bitnum
  add eax,ecx
  dec eax ; 正对角线
  call getbit
  and eax,[ebp+4]
  cmp eax,0
  jle next

  ; 判断反对角线
  mov eax,esi

  call bitnum
  add eax,8
  sub eax,ecx ;反对角线
  call getbit
  and eax,[ebp+8]
  cmp eax,0
  jle next
  ; 都符合进入下层

  mov eax,esi ; 更新现场
  call bit
  push [ebp]
  sub [ebp],eax

  mov eax,esi
  call bitnum
  ;--- 
  mov [edx],ecx
  mov [edx+4],eax
  add edx,8
  ;---
  add eax,ecx
  sub eax,1
  call getbit
  push [ebp+4]
  sub [ebp+4],eax

  mov eax,esi
  call bitnum
  add eax,8
  sub eax,ecx
  call getbit
  push [ebp+8]
  sub [ebp+8],eax

  dec ecx

  call putQueue

  inc ecx ; 还原现场
  pop [ebp+8]
  pop [ebp+4]
  pop [ebp] 
  sub edx,8

next:
  mov eax,esi
  call bit
  sub esi,eax
  mov eax,esi ; eax=eax-(eax & -eax);
  jmp again
output:
  push eax
  mov eax,[edi]
  call writeint
  inc eax
  mov [edi],eax
  call crlf
  call print
  pop eax
final:
  popad
  ret 
putQueue endp

; output
print proc
  pushad
  mov ecx,8
again:
  call printLine
  sub edx,8
  loop again
final:
  popad
  ret
print endp

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

; k&(-k) return:eax;  receive:eax
bit proc
  push ebx
  mov ebx,eax
  neg ebx
  and eax,ebx
  pop ebx
  ret
bit endp

; 11000=>4 10=>2 get the position of left 1
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

end main

