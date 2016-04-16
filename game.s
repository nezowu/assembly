.section .bss
	.comm buff, 1
.section .data
#buff:	.byte	1
repr1:	.quad	0x55
repr2:	.quad	0xAA
flag_m:	.byte	0
flag_u:	.byte	0
game:	.ascii	"00000000_VS_00000000\n"
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

	xor	%rax,	%rax
	xor	%rdi,	%rdi
	mov	$buff,	%rsi
	inc	%rdx
	syscall
	mov	buff,	%r9
	sub	$0x31,	%r9
	mov	%r9,	flag_u
_compare:
	mov	$game,	%r10
	cmp	%rdx,	%r9	/*rdx имеет 1*/
	je	one_u
	jg	two_u
zero_u:
	mov	stone,	%r11
	mov	%r11,	(%r10)
	jmp	next
one_u:
	mov	scissors,%r11
	mov	%r11,	(%r10)
	jmp	next
two_u:
	mov	paper,	%r11
	mov	%r11,	(%r10)
next:
	cmp	%rdx,	flag_m
	je	one_m
	jg	two_m
zero_m:
	mov	stone,	%r11
	mov	%r11,	12(%r10)
	jmp	forward
one_m:
	mov	scissors,%r11
	mov	%r11,	12(%r10)
	jmp	forward
two_m:
	mov	paper,	%r11
	mov	%r11,	12(%r10)
forward:
	mov	flag_m,	%r10
	mov	flag_u,	%r11
	mov	$2,	%r12
	cmp	%r10,	%r11
	je	drawing
	add	%r10,	%r11
	cmp	%r11,	%r12
	jl	wining
	jg	losing

	cmp	%r11,	%r12
	jl	losing
	jg	wining
wining:
	write	$win,	$10
	jmp	_exit
losing:
	write	$lose,	$10
	jmp	_exit
drawing:
	write	$draw,	$10

_exit:
	write	$game,	$21
	ending
