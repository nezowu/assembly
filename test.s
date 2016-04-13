.section .data
var1:
	.quad	0x0000000000000003
var2:
	.quad	0x0000000000000002
ptr1:
	.ascii	"Второй аргумент меньше первого\n"
	ptr1_len = . - ptr1
ptr2:
	.ascii	"Первый аргумент больше второго\n"
	ptr2_len = . - ptr2

.section .text
.globl _start
_start:
	mov var1, %rdi
	mov	var2,	%rdx
	cmp	$3,	%rdi
	cmove	%rdx,	%rdi
	dec	%rdi
	cmp	var2,	%rdi
	
	jl	first

	xor	%rdx,	%rdx
	xor	%rax,	%rax
	inc	%rax
	xor	%rdi,	%rdi
	inc	%rdi
	mov	$ptr2,	%rsi
	mov	$ptr2_len,	%rdx
	syscall

	mov	$60,	%rax
	mov	$0,	%rsi
	syscall
first:

	xor	%rdx,	%rdx
	xor	%rax,	%rax
	inc	%rax
	xor	%rdi,	%rdi
	inc	%rdi
	mov	$ptr1,	%rsi
	mov	$ptr1_len,	%rdx
	syscall

	mov	$60,	%rax
	mov	$0,	%rsi
	syscall
