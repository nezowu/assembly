#filename st.s with addition macros.inc
.include "macros.inc"
.section .text
.global _start
_start:
#	write	$wellc, $we_len
loop:
#	write	$prom,	$pr_len
	read	$user_dig, $8
	mov	user_dig, %rax
	sub	$0x31,	%rax
	mov	%rax,	user_dig
	xor	%rax,	%rax
#	write	$user_dig, $8

	mov	$318,	%rax
	mov	$buff,	%rdi
	xor	%rsi,	%rsi
	inc	%rsi
	mov	$0,	%rdx
	syscall
#	write	$bufx,	$8

	xor	%r10,	%r10
	inc	%r10
#	mov	$1,	%r10
#	mov	$2,	%r9
	xor	%r9,	%r9
.rept 2
	inc	%r9
.endr
	xor	%r8,	%r8
	mov	buff,	%r8
	mov	%r8,	bufx
	mov	bufx,	%r8
	xor	%rsi,	%rsi
	cmp	repr1,	%r8
	cmovg	%r10,	%rsi

	xor	%r8,	%r8
	mov	buff,	%r8
				
	cmp	repr2,	%r8
	cmovg	%r9,	%rsi
	mov	%rsi,	comp_dig /*флаг, выбор машины*/
#	push	%rsi		/*будет последним в стеке*/
#	cmp	user_dig, %rsi
#	jge	draw
	write	$comp_dig, $8
	write	$user_dig, $8
#	write	$bufx,	$8
	call ending
draw:
	xor	%rax,	%rax
	xor	%rdi,	%rdi
	xor	%r8,	%r8
	xor	%r9,	%r9
	mov	stone,	%rdi
	mov	scissors, %r8
	mov	paper,	%r9
	cmp	%rsi,	%r10
	cmove	%r8,	%rax
#	cmp	%r10,	%rsi
	cmovl	%rdi,	%rax
#	cmp	%r10,	%rsi
	cmovg	%r9,	%rax
	mov	%rax,	verd
	xor	%rsi,	%rsi
	xor	%rdx,	%rdx
	write	$verd,	$9
	call ending

#	xor	%rsi,	%rsi	

#	write	$comp_dig,	$9
ending:
	mov	$60,	%rax	
	mov	$0,	%rdi	
	syscall			
	ret
