Для большего понимания работы компьютера
пишим простенькую игру "камень_ножницы_бумага"
на gnu ассемблере в ОС linux x86_64 архитектурых.
Что бы скомпилировать программу выполните две команды
as -o stone.o stone.s
ld -s -o stone stone.o
И запустите
./stone
Для по строчного просмотра в gdb выполните:
as --gstabs -o stone.o stone.s
ld -o stone stone.o #без опции -s
gdb -q stone
break *_start+1
run
next
next...
Для дезасемлирования:
objdump -D stone #скомпилировнной без опции --gstabs
