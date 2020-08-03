TITLE gcd
include Irvine32.inc
.data
  num1 db 128 dup(0)
  num2 db 128 dup(0)
.code
main proc
  call read
  exit
main endp

read proc
.data
  buffer db 128 dup(0)
  len dd ?
.code
  lea edx,buffer
  mov ecx,128
  call readstring
  mov len,eax
  mov ecx,sizeof buffer
  mov al,' '
  lea edi,buffer
  repne scasb
  sub edi,offset buffer
  call writeint
  ret
read endp

; get greatest common divisor
; recevie eax,edx
; return eax
gcd proc


gcd endp

end main