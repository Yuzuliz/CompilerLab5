LEX=flex
YACC=bison
CC=g++
OBJECT=main #生成的目标文件
 
$(OBJECT): lex.yy.o  yacc.tab.o
	$(CC) lex.yy.o yacc.tab.o -o $(OBJECT)
	@./$(OBJECT) #编译后立刻运行
 
lex.yy.o: lex.yy.c  main.tab.h  main.h
	$(CC) -c lex.yy.c
 
yacc.tab.o: main.tab.c  main.h
	$(CC) -c main.tab.c
 
main.tab.c  main.tab.h: main.y
# bison使用-d参数编译.y文件
	$(YACC) -d main.y
 
lex.yy.c: main.l
	$(LEX) main.l
 
clean:
	@rm -f $(OBJECT)  *.o