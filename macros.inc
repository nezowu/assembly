#filename macros.inc the add for st.s
.section .data
buff:	.byte	1
bufx:	.byte	8
user_dig: .byte	8
comp_dig: .byte	8

stone:	.ascii "stone   "
scissors: .ascii "scissors"
paper:	.ascii "paper   "
zero:	.ascii "draw    "
win:	.ascii "You won"
lose:	.ascii "You loose"
verd:	.ascii "00000000\n"

wellc:  .ascii "Wellcome to the GAME stone-scissors-paper\n"
 we_len = . - wellc
prom:   .ascii "Enter one of three sample digits\n1-stone\n2-scissors\n3-paper\n"
 pr_len = . - prom
comp:    .ascii "00000000" 
user:	.ascii "00000000"

repr1:  .quad   0x55
repr2:  .quad   0xAA

#buff:	.byte 1
#bufx:	.quad 8
.section .text
.macro	write	print,	pr_len
	xor	%rax,	%rax
	inc	%rax
	xor	%rdi,	%rdi
	inc	%rdi
	mov	\print,	%rsi
	mov	\pr_len, %rdx
	syscall
.endm
.macro	read	scan,	sc_len
	xor	%rax,	%rax
	xor	%rdi,	%rdi
	mov	\scan,	%rsi
	mov	\sc_len, %rdx
	syscall
.endm
