TITLE 4_1.asm
include Irvine32.inc
.data
  msg db "按任意键继续（q键退出）...",10,0
.code
main proc
again:
  call clrscr
  lea edx,msg
  call writestring
  call readchar
  cmp al,'q'
  jz final
  cmp al,'Q'
  jz final
  jmp again
final:
  exit
main endp
end main