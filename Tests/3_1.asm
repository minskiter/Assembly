TITLE s
include Irvine32.inc
.data
  a dd ?
  b dd ?
  o dd ?
  menu db "1)加法",0ah,"2)减法",0ah,"3)乘法",0ah,"4)除法",0ah,"请选择运算类型(1-4)",0ah,0
  numOne db "请输入第一个整数:",0ah,0
  numTwo db "请输入第二个整数:",0ah,0
  answer db "请输出运算结果:",0ah,0
.code
main proc
  mov edx,offset menu
  call writestring
  call readint
  mov o,eax
  mov edx,offset numOne
  call writestring
  call readint
  mov a,eax
  mov edx,offset numTwo
  call writestring
  call readint
  mov b,eax
  cmp o,1
  jz Ladd
  cmp o,2
  jz Lsub
  cmp o,3
  jz Lmul
  cmp o,4
  jz Ldiv
  jmp final
Ladd:
  mov eax,b
  add eax,a
  jmp final
Lmul:
  mov eax,b
  mul a
  jmp final
Ldiv:
  mov eax,a
  mov edx,0
  div b
  jmp final
Lsub:
  mov eax,b
  sub eax,a
  jmp final
final:
  mov edx,offset answer
  call writestring
  call writeint
  exit
main endp
showMenu proc
  ret
showMenu endp
end main