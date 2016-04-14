.section .bss
	.lcomm buff, 1
.section .data
ptr:
	.ascii "0000\n" /* 9 байт, 8 байт нулей перезаписываются */
repr1:
	.quad	0x55
repr2:
	.quad	0xA9

.section .text
.global _start
_start:
	mov	$318,	%rax
	mov	$buff,	%rdi
	mov	$1,	%rsi
	mov	$0,	%rdx
	syscall

	mov	$1,	%r10
	mov	buff,	%r8
	mov	$2,	%r9
	xor	%rsi,	%rsi
	cmp	repr1,	%r8
	cmovg	%r10,	%rsi
	cmp	repr2,	%r8
	cmovg	%r9,	%rsi
	mov	%rsi,	ptr
	
	xor	%rsi,	%rsi

	xor	%rax,	%rax
	inc	%rax
	xor	%rdi,	%rdi
	inc	%rdi
	mov	$ptr,	%rsi
	mov	$9,	%rdx
	syscall

	mov	$60,	%rax
	mov	$0,	%rsi
	syscall
