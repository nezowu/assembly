.section .data
wellco: .ascii	"Wellcome to the GAME stone-scissors-paper\n" 
	we_len = . - wellco
prompt:	.ascii	"Choose one of three sample digits\n1-stone\n2-scissors\n3-paper\n"
	pr_len = . - prompt
buff:	.quad	0x0
repr1:	.quad	0x55
repr2:	.quad	0xaa
flag_m:	.quad	0x0
flag_u:	.quad	0x0
game:	.ascii	"00000000 VS 00000000\n"
win:	.ascii	"You won!!!\n"
lose:	.ascii	"You loose!\n"
draw:	.ascii	"Tied score\n"
stone:	.ascii	"  stone "
scissors: .ascii "scissors"
paper:	.ascii	"  paper "

.section .text
.macro	write	arg,	arg_len	/*стандартный вывод*/
	mov	$1,	%rax
	mov	$1,	%rdi
	mov	\arg,	%rsi
	mov	\arg_len,%rdx
	syscall
.endm
.macro	ending			/*выход*/
	mov	$60,	%rax
	mov	$0,	%rdi
	syscall
.endm
.macro	scan			/*стандартный ввод*/
	xor	%rax,	%rax
	xor	%rdi,	%rdi
	mov	$buff,	%rsi
	inc	%rdx
	syscall
.endm

.globl _start
_start:
	write	$wellco,$we_len
	write	$prompt,$pr_len

	mov	$318,	%rax	/*системный вызов getrandom()*/
	mov	$buff,	%rdi
	mov	$1,	%rsi	/*первый байт буфера*/
	mov	$0,	%rdx	/*флаг 0 1 2 или 3*/
	syscall
				/*в rsi уже есть единица*/
	inc	%rax 		/* уже была единица и того 2*/
	mov	buff,	%r8	/*в rbx уже есть ноль*/
	cmp	repr1,	%r8	/*сравниваем рендомное число*/
	cmovg	%rsi,	%rbx	/*поочередно с двумя метками*/
	cmp	repr2,	%r8
	cmovg	%rax,	%rbx
	mov	%rbx,	flag_m	/*получаем выбор машины*/
	scan			/*выбираем предмет*/

	mov	buff,	%r9
	sub	$0x31,	%r9	/*декодируем из аски кода*/
	mov	%r9,	flag_u	/*получаем выбор игрока*/

	mov	$game,	%rdx	/*rax имеет 1*/
	cmp	%rax,	%r9	/*проводим сравнение по алгоритму*/
	je	one_u
	jg	two_u

	mov	stone,	%rbx
	mov	%rbx,	(%rdx)	/*перезапишим первых 8 байт game*/
	jmp	next
one_u:
	mov	scissors,%rbx
	mov	%rbx,	(%rdx)
	jmp	next
two_u:
	mov	paper,	%rbx
	mov	%rbx,	(%rdx)
next:
	cmp	%rax,	flag_m	/*сравним выбор машины с 1*/
	je	one_m
	jg	two_m

	mov	stone,	%rbx
	mov	%rbx,	12(%rdx) /*перезапишим 8б с 12 позиции в game*/
	jmp	forwar
one_m:
	mov	scissors,%rbx
	mov	%rbx,	12(%rdx)
	jmp	forwar
two_m:
	mov	paper,	%rbx
	mov	%rbx,	12(%rdx)
forwar:
	mov	flag_m,	%r8
	inc	%rax
	cmp	%r8,	%r9	/*сравним выбор машины и игрока*/
	je	drawg		/*если ровны - ничья*/
	add	%r8,	%r9	/*сложим значения по алгоритму*/
	cmp	%r9,	%rax	/*сравним полученное с 2*/
	jne	last

	cmp	%r8,	flag_u	/*выясняем кто выиграл*/
	jl	losg
	jg	wing
last:
	cmp	%r8,	flag_u
	jg	losg
wing:				/*выводим результат игры*/
	write	$win,	$11
	jmp	_exit
losg:
	write	$lose,	$11
	jmp	_exit
drawg:
	write	$draw,	$11

_exit:
	write	$game,	$21	/*выводим выбранные предметы*/
	ending			/*можно бы loop добавить?*/
