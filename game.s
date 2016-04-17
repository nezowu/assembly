.section .data
wellco: .ascii	"Wellcome to the GAME stone-scissors-paper\n" 
prompt:	.ascii	"Enter one of three sample digits\n1-stone\n2-scissors\n3-paper\n"
buff:	.quad	0x0
repr1:	.quad	0x55
repr2:	.quad	0xaa
flag_m:	.quad	0x0
flag_u:	.quad	0x0
game:	.ascii	"00000000 VS 00000000\n"
verdict: .ascii	"00000000\n"
win:	.ascii	"You won!!!\n"
lose:	.ascii	"You loose\n"
draw:	.ascii	"Tied score\n"
stone:	.ascii	"  stone "
scissors: .ascii "scissors"
paper:	.ascii	"  paper "

.section .text
.macro	write	arg,	arg_len
	mov	$1,	%rax
	mov	$1,	%rdi
	mov	\arg,	%rsi
	mov	\arg_len,%rdx
	syscall
.endm
.macro	ending
	mov	$60,	%rax
	mov	$0,	%rdi
	syscall
.endm

.globl _start
_start:
	mov	$318,	%rax
	mov	$buff,	%rdi
	mov	$1,	%rsi
	mov	$0,	%rdx
	syscall

#в rsi уже есть единица
	inc	%rax /* уже была единица и того 2 */
	mov	buff,	%r8
#в rbx уже есть ноль
	cmp	repr1,	%r8
	cmovg	%rsi,	%rbx
	cmp	repr2,	%r8
	cmovg	%rax,	%rbx
	mov	%rbx,	flag_m
scan:
	xor	%rax,	%rax
	xor	%rdi,	%rdi
	mov	$buff,	%rsi
	inc	%rdx
	syscall

	mov	buff,	%r9
	sub	$0x31,	%r9
	mov	%r9,	flag_u
_compare:
	mov	$game,	%rdx
	cmp	%rax,	%r9	/*rax имеет 1*/
	je	one_u
	jg	two_u
zero_u:
	mov	stone,	%rbx
	mov	%rbx,	(%rdx)
	jmp	next
one_u:
	mov	scissors,%rbx
	mov	%rbx,	(%rdx)
	jmp	next
two_u:
	mov	paper,	%rbx
	mov	%rbx,	(%rdx)
next:
	cmp	%rax,	flag_m
	je	one_m
	jg	two_m
zero_m:
	mov	stone,	%rbx
	mov	%rbx,	12(%rdx)
	jmp	forward
one_m:
	mov	scissors,%rbx
	mov	%rbx,	12(%rdx)
	jmp	forward
two_m:
	mov	paper,	%rbx
	mov	%rbx,	12(%rdx)
forward:
	mov	flag_m,	%r8
	inc	%rax
	cmp	%r8,	%r9
	je	drawing
	add	%r8,	%r9
	cmp	%r9,	%rax
	jne	vyhlop

	cmp	%r8,	flag_u
	jl	losing
	jg	wining
vyhlop:
	cmp	%r8,	flag_u
	jl	wining
	jg	losing
wining:
	write	$win,	$11
	jmp	_exit
losing:
	write	$lose,	$10
	jmp	_exit
drawing:
	write	$draw,	$11

_exit:
	write	$game,	$21
	ending
