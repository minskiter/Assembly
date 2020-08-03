TITLE swap num
include Irvine32.inc
.data
  array dd 3,4
.code
main proc
  mov edi,offset array
  mov esi,offset array+4
  call swap
  mov eax,array[0]
  call writeint
  mov eax,array[4]
  call writeint
  exit
main endp
; swap(*esi,*edi)
swap proc
  push eax
  mov eax,[esi]
  push eax
  mov eax,[edi]
  mov [esi],eax
  pop eax
  mov [edi],eax
  pop eax
  ret
swap endp
end main