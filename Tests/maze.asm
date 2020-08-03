; 2020/3/30 UTF-8
TITLE maze
include Irvine32.inc
.data
  ; 初始化迷宫
    map db 1,1,1,1,1, 1,1,1,1,1, 1,1,1,1,1,1
        db 1,2,0,0,0, 0,1,0,0,0, 1,0,0,0,1,1
        db 1,1,1,1,1, 0,1,1,1,0, 1,0,1,0,1,1
        db 1,0,0,0,1, 0,0,0,1,0, 0,0,1,0,1,1
        db 1,0,1,1,1, 0,1,1,1,1, 1,0,1,1,1,1
        db 1,0,0,0,1, 0,0,0,0,0, 0,0,0,0,1,1
        db 1,1,1,0,1, 1,1,1,1,1, 1,0,1,0,1,1
        db 1,0,0,0,0, 0,0,0,1,0, 0,0,1,0,1,1
        db 1,1,1,0,1, 1,1,0,1,1, 1,0,1,0,1,1
        db 1,0,1,0,0, 0,1,0,0,0, 0,0,1,0,1,1
        db 1,0,1,0,1, 0,1,1,1,1, 1,1,1,0,1,1
        db 1,0,0,0,1, 0,1,0,1,0, 0,0,0,0,1,1
        db 1,0,1,0,1, 0,1,0,1,0, 1,0,1,1,1,1
        db 1,0,1,0,1, 0,0,0,0,0, 1,0,0,3,1,1
        db 1,1,1,1,1, 1,1,1,1,1, 1,1,1,1,1,1
        db 1,1,1,1,1, 1,1,1,1,1, 1,1,1,1,1,1
    ans dd 16*16*2 dup(0) ;位置坐标数组
    visited db 16*16 dup(0)
    dir dd 1,0,0,1,-1,0,0,-1 ; 方向数组
    num dd 256 ;总大小
    w dd 16;
    h dd 16;
.code
main proc
  lea edx,map
  lea edi,ans
  mov ecx,num
  push h
  push w
  call findBegin
  lea esi,visited
  push offset ans
  push h
  push w
  push offset dir
  call dfs
final:
  exit
main endp

findBegin proc
  push ebp
  mov ebp,esp
  add ebp,8
  pushad
  mov eax,0
again:
  mov al,[edx+ecx]
  cmp al,2
  je final
  loop again
final:
  mov edx,0
  mov eax,ecx
  div dword ptr[ebp]
  mov [edi],eax
  mov [edi+4],edx
  popad
  add edi,8
  pop ebp
  ret 8
findBegin endp


dfs proc
  push ebp
  mov ebp,esp
  add ebp,8
  pushad

  push edx
  mov eax,[edi-8]
  mul dword ptr[ebp+4]
  pop edx
  add eax,[edi-4]


  mov ecx,4
  mov eax,[edi-8]
  mov ebx,[edi-4]

  
 

again:
  ; eax=>x;ebx=>y
  push eax
  push ebx

  push edx
  mov edx,[ebp]
  add eax,[edx+ecx*8-8]
  add ebx,[edx+ecx*8-4]
  pop edx

  
  cmp eax,0
  jl final
  cmp ebx,0
  jl final
  cmp eax,[ebp+4]
  jge final
  cmp ebx,[ebp+8]
  jge final

  mov [edi],eax
  mov [edi+4],ebx
  add edi,8

  push edx
  mul dword ptr[ebp+4]
  pop edx
  add eax,ebx

  mov bl,[esi+eax]
  cmp bl,1
  je backTrace

  mov bl,[edx+eax]
  cmp bl,1
  je backTrace

  cmp bl,3
  je output


  ;设置为走过
  mov bl,1
  mov [esi+eax],bl 

  push [ebp+12]
  push [ebp+8]
  push [ebp+4]
  push [ebp]

  call dfs
  ;回溯
  
  mov bl,0
  mov [esi+eax],bl
backTrace:
  sub edi,8 
next:
  pop ebx
  pop eax
  loop again
  jmp final
output:
  push [ebp+12]
  push edi
  call print
  exit
final:
  popad
  pop ebp
  ret 16
dfs endp

print proc
  push ebp
  mov ebp,esp
  add ebp,8
  pushad
  mov ecx,[ebp]
  sub ecx,[ebp+4]
  shr ecx,3
  mov edx,[ebp+4]
again:
  mov al,'('
  call writechar
  mov eax,[edx]
  call writedec
  mov al,','
  call writechar
  mov eax,[edx+4]
  call writedec
  mov al,')'
  call writechar
  cmp ecx,1
  je final
  mov al,'-'
  call writechar
  mov al,'>'
  call writechar
  add edx,8
  loop again
final:
  popad
  pop ebp
  ret 8
print endp

end main