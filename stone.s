.section .bss
	.lcomm buff, 8
.section .data
stone:
	.ascii "stone\n"
	len_s = . - stone
scissor:
	.ascii "scissor\n"
	len_c = . - scissor
paper:
	.ascii "paper\n"
	len_p = . - paper
repr0:
	.quad	0x0000000000000000
repr1:
	.quad	0x2999999999999999
repr2:
	.quad	0xD555555555555555
.section .text
.global _start
.macro ending str, str_len
	xor	%rsi,	%rsi
	xor	%rdi,	%rdi
	mov	$1,	%rax
	mov	$1,	%rdi
	mov	\str,	%rsi
	mov	\str_len,	%rdx
	syscall

	mov	$60,	%rax
	mov	$0,	%rsi
	syscall
.endm
_start:
	mov	$318,	%rax
	mov	$buff,	%rdi
	mov	$8,	%rsi
	mov	$0,	%rdx
	syscall
	mov	buff,	%rdi
	cmp	%rdi,	repr1
	jg	first
	ending	$stone,	$len_s

first:
	cmp	%rdi,	repr2
	jg	second
	ending	$scissor,	$len_c

second:
	ending	$paper,	$len_p
