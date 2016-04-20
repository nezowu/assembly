#filename true_or_false.s
.section .data
buff:
	.quad	0x0	
.section .text
.globl _start
_start:
	mov	$318,	%rax	/*системный вызов getrandom */
	mov	$buff,	%rdi	/*echo $? или 0 или 1 */
	mov	$1,	%rsi
	mov	$0,	%rdx
	syscall

	mov	buff,	%rdi
	and	$0x1,	%rdi

	mov	$60,	%rax
	syscall
