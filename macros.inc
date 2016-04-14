#filename macros.inc the add for st.s
.section .data

.section .text
.macro	write	print,	p_len
	xor	%rax,	%rax
	inc	%rax
	xor	%rdi,	%rdi
	inc	%rdi
	mov	\print,	%rsi
	mov	\p_len,	%rdx
	syscall
.endm
.macro	read	scan,	s_len
	xor	%rax,	%rax
	xor	%rdi,	%rdi
	mov	\scan,	%rsi
	mov	\s_len,	%rdx
	syscall
.endm
