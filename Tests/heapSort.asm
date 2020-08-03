; encoding UTF-8
TITLE heapSort
include Irvine32.inc
.data
  array dd 4,5,1,11,3,4,5,10
  len dd ($-array)/4
.code
main proc
  lea edx,array
  mov ecx,len
  mov eax,1
  call heapSort
  call print
  exit
main endp

heapSort proc
  pushad
  mov edi,ecx
firstLoop: ; 初始化堆
  mov eax,ecx
  push ecx
  mov ecx,edi
  call sifdown
  pop ecx
  loop firstLoop
sort:
  mov ecx,edi
  dec ecx
again:
  ;swap
  mov eax,1
  push edi
  mov esi,[edx+eax*4-4]
  mov edi,[edx+ecx*4]
  mov [edx+eax*4-4],edi
  mov [edx+ecx*4],esi
  pop edi
  call sifdown
  loop again
final:
  popad
  ret
heapSort endp

; root=>eax,length=>ecx,array=>edx[]
sifdown proc
  pushad
  mov ebx,eax
again:
  shl eax,1
  cmp eax,ecx
  jg final
  ; 预先选右儿子
  inc eax
  cmp eax,ecx
  jg L2
L1: ; 选较大的儿子节点
  mov esi,[edx+4*eax-4]
  cmp esi,[edx+4*eax-8]
  jg L3
L2: ; 选左儿子
  dec eax
L3: ; 儿子和父亲比较
  mov esi,[edx+ebx*4-4]
  cmp [edx+eax*4-4],esi
  jle final
L4: ;儿子比父亲大则交换
  mov edi,[edx+eax*4-4]
  mov [edx+ebx*4-4],edi
  mov [edx+eax*4-4],esi
next:
  mov ebx,eax
  jmp again
final:
  popad
  ret
sifdown endp

; print edx[ecx]
print proc
  pushad
  mov esi,ecx
again:
  push edi
  mov edi,esi
  sub edi,ecx
  mov eax,dword ptr [edx+edi*4]
  pop edi
  call writeint
  mov al,' '
  call writechar
  jmp next
next:
  sub ecx,1
  cmp ecx,0
  jz final
  jmp again
final:
  call crlf
  popad
  ret
print endp
end main