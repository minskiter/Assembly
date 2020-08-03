TITLE ex2_3 Prime factorization
include Irvine32.inc
.data
  primes dd 10000 dup(0)
  len dd 0 ;primes length
  max_prime dd 65535 
.code
main proc
  call prime
  call readint

  ;init
  mov ecx,0
  mov ebx,eax ;ebx=>input number
  mov esi,0 ;esi=>curren prime count
  mov edi,1 ;edi=>first output? 0:true;1:false
 
  call writedec
  mov al,'='
  call writechar
lloop:
  cmp ecx,len
  jge last
  mov edx,0
  mov eax,ebx
  div primes[ecx]
  cmp edx,0 ; remainer==0?
  jz assign
  cmp esi,0
  jg output
  jmp next
assign:
  inc esi
  mov ebx,eax
  jmp lloop
output:
  cmp edi,1
  mov edi,0
  jz outputBase
  jmp outputMul
outputMul:
  mov al,'*'
  call writechar
outputBase:
  mov eax,primes[ecx]
  call writedec
  cmp esi,1
  jz next
  jmp outputEx
outputEx:
  mov al,'^'
  call writechar
  mov eax,esi
  call writedec
next:
  mov esi,0 ;clear esi
  inc ecx ; next prime
  jmp lloop ; goto loop
last:
  cmp ebx,max_prime
  jle final
outputLast: ;assume number which is greater max_primes; output number directly
  mov eax,ebx
  call writedec
final:
  exit
main endp

;Euler ; Get Primes Array
prime proc
.data
  isPrime db 65536 dup(1)
.code
  pushad
  mov ecx,2
  lea edx,primes
  mov esi,0
lloop:
  cmp isPrime[ecx],1
  mov eax,0
  jz assign
  jmp loopMultiple
assign:
  mov [edx+4*esi],ecx
  inc esi
loopMultiple:
  cmp eax,ecx
  jge next

  push eax
  push edx

  mov ebx,eax
  mov eax,ecx
  mov ebx,[edx+4*ebx]
  mul ebx; ecx*edx[eax]
  ; get 32bits eax

  mov ebx,eax

  pop edx
  pop eax

  cmp ebx,max_prime ;ecx*edx[eax]>=max_prime?
 
  jge next

  mov isPrime[ebx],0

  ; ecx % edx[eax]==0?
  mov ebx,[edx+4*eax]

  push edx
  push eax

  mov edx,0
  mov eax,ecx
  div ebx
  cmp edx,0 ; remainer==0?

  pop eax
  pop edx

  jz next 

  inc eax
  jmp loopMultiple
next:
  inc ecx
  cmp ecx,max_prime
  jge final
  jmp lloop
final:
  mov len,esi
  popad
  ret
prime endp

end main