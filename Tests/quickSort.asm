TITLE sort
include Irvine32.inc
.data
  ; array dd 100 dup(0)
  ; n dd ?
  array dd 10,5,6,7,-1,10
  n dd ($-array)/4
.code
main proc
  ; call readint
  ; mov n,eax
  ; mov ecx,eax
  ; lea edx,array
  ; call readArray
  lea edx,array
  mov ecx,n

  push edx
  shl ecx,2
  add ecx,edx
  sub ecx,4
  push ecx
  
  call sort
  

  add esp,8

  lea edx,array
  mov ecx,n
  call print
final:
  exit
main endp

; quickSort;l=>stack[0],r=>stack[1]
sort proc

  push ebp
  mov ebp,esp
  add ebp,4
  pushad
  mov esi,[ebp+8]
  mov edi,[ebp+4]
  cmp esi,edi ;esi>=edi?goto final
  jge final
  
  mov ebx,edi ; ebx = (esi+edi)>>1
  sub ebx,esi
  shr ebx,3
  shl ebx,2
  add ebx,esi
  ; 
  ; shr ebx,1  ; ebx = (esi+edi)>>1
  mov eax,[ebx] ; get middle number
 
again:

;   pushad
;   lea edx,array
;   mov ecx,n
;   call print
;   popad

right: ; while (a[i]<mid) ++i
  cmp esi,[ebp+4]
  jge left
  cmp [esi],eax
  jge left
  add esi,4
  jmp right

left: ; while (a[j]>mid) --j
 
  cmp edi,[ebp+8]
  jle assign
  cmp [edi],eax
  jle assign
  sub edi,4
  jmp left

assign: ; if (i<=j) swap(i++,j--);
  ; push eax
  ; ; mov eax,[esi]
  ; call writeint
  ; call crlf
  ; pop eax

  cmp esi,edi
  jg next

  push [edi]
  push [esi]
  pop [edi]
  pop [esi]
  add esi,4
  sub edi,4

  

next:


  ; #region [debug infomation]
  ; push edx
  ; push ecx
  ; lea edx,array
  ; mov ecx,n
  ; call print
  ; pop ecx
  ; pop edx
  ; #endregion

  

  cmp esi,edi
  jle again

  

  cmp [ebp+8],edi
  jge nextRight

  push [ebp+8]
  ; sub edi,4
  push edi

   
  call sort
  add esp,8
 
 
  

nextRight:

  cmp esi,[ebp+4]
  jge final
  ; add esi,4
  push esi
  push [ebp+4]
  call sort
  add esp,8

final: 
  popad
  pop ebp
  ret
sort endp

; input array;array=>edx,ecx
readArray  proc
  pushad
  mov ebx,ecx
again:
  call readint
  push ebx
  sub ebx,ecx
  mov [edx+ebx*4],eax
  pop ebx
  loop again
final:
  popad
  ret
readArray endp

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