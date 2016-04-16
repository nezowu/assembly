.section .data
buff:	.byte 1

.section .text
.globl _start
_start:
	mov	$318,	%rax
	mov	$buff,	%rdi
	mov	$1,	%rsi
	mov	$0,	%rdx
	syscall

	mov	$1,	%rax
	mov	$1,	%rdi
	mov	$buff,	%rsi
	mov	$1,	%rdx
	syscall

	mov	$60,	%rax
	mov	$0,	%rdi
	syscall
