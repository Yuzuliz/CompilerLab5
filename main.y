%{
/*
yacc文件，用于语法分析，生成语法树，以表格形式保存在txt文件中，以图像形式输出
利用子节点得到父节点：利用$n得出$$
(Var) x ∈ ID
(Type) T ::= int | char
(Expr) E ::= x | n | E + E | . . .
(BExp) B ::= true | false | E == E | !B | . . .
(Instr) c ::= T x = E | x = E | printf(E) | printf(B) | scanf(x) (Stmt) C ::= ϵc
if (B) C else C
while (B) {S} 
(Stmts) S ::= C | C; C (Prog) W ::= S*/

  #include "main.h"
  extern "C"{
    void yyerror(const char *s);
    extern int yylex(void);
  }
%}

%token String
%token Num
%token Scanf
%token Printf
%token Return
%token While
%token If
%token Else
%token Switch
%token For
%token Break
%token Continue
%token Do
%token Type
%token True
%token False
%token Lp
%token Rp
%token Lb
%token Rb
%token Semicolon
%token CompOp
%token Not
%token Assign
%token AriOp
%token SelfOp
%token AriAOp
%token Variable

%%

x         : Variable                        {$$ = new Node;$$->add_child($1);printf("@%d  variable varname:%s\n",$1->No,$1->value);}
            ;

Expr  : x                                       {$$ = new Node;$$->add_child($1);printf("Expr:x\n");}
            | SelfOp x                       {$$ = new Node;$$->add_child($1);$$->add_child($2);printf("SelfOp x\n");}
            | x SelfOp                       {$$ = new Node;$$->add_child($1);$$->add_child($2);printf(" x SelfOp\n");}
            | Num                              {$$ = new Node;$$->add_child($1);printf("Num %s\n",$1->value);}
            | Expr AriOp Expr        {$$ =new Node;$$->add_child($1);$$->add_child($2);$$->add_child($3);printf("Expr AriOp Expr     \n");}
            ;

BExp : True                                {$$ = new Node;$$->add_child($1);printf("BExp : True \n");}
            | False                              {$$ = new Node;$$->add_child($1);printf("False\n");}
            | Expr CompOp Expr  {$$ = new Node;$$->add_child($1);$$->add_child($2);$$->add_child($3);printf("Expr CompOp Expr      \n");}
            | Not BExp                      {$$ = new Node;$$->add_child($1);$$->add_child($2);printf("Not BExp  \n");}
            ;

Instr  : Type x                             {$$ = new Node;$$->add_child($1);$$->add_child($2);printf("Type x  \n");}
            | Type x Assign Expr    {$$ = new Node;$$->add_child($1);$$->add_child($2);$$->add_child($3);$$->add_child($4);printf("Type x Assign Expr Semicolon   \n");}
            | x Assign Expr               {$$ = new Node;$$->add_child($1);$$->add_child($2);$$->add_child($3);printf("x Assign Expr Semicolon\n");}
            | x AriAOp Expr              {$$ = new Node;$$->add_child($1);$$->add_child($2);$$->add_child($3);printf("x AriAOp Expr Semicolon\n");}
            | Printf Lp Expr Rp        {$$ = new Node;$$->add_child($1);$$->add_child($3);printf("Printf Lp Expr Rp Semicolon \n");}
            | Printf Lp BExp Rp       {$$ = new Node;$$->add_child($1);$$->add_child($3);printf("Printf Lp BExp Rp Semicolon\n");}
            | Printf Lp String x Rp  {$$ = new Node;$$->add_child($1);$$->add_child($3);$$->add_child($4);printf("Printf ( String x )\n");}
            | Scanf Lp String x Rp  {$$ = new Node;$$->add_child($1);$$->add_child($3);$$->add_child($4);printf("Scanf ( String x )\n");}
            ;

Stmt  : Instr                                 {$$ = new Node;$$->add_child($1);printf("Stmt  : Instr\n");}
            | If Lp BExp Rp Stmt Else Stmt        {$$ = new Node;$$->add_child($1);$$->add_child($3);$$->add_child($5);$$->add_child($6);$$->add_child($7);printf("If Lp BExp Rp Stmt ELSE Stmt\n");}
            | While Lp BExp Rp Lb Stmts Rb       {$$ = new Node;$$->add_child($1);$$->add_child($3);$$->add_child($6);printf("While Lp BExp Rp Stmt Lb S Rb\n");}
            ;

Stmts : Stmt  Semicolon                             {$$ = new Node;$$->add_child($1);printf("Stmts : Stmt\n");}
              | Stmt Semicolon Stmts                {$$ = new Node;$$->add_child($1);$$->add_child($3);printf("Stmt Semicolon Stmt\n");}
              ;

Prog   : Stmts                                                    {$$ = new Node;$$->add_child($1);printf("Prog   : Stmts\n");}
            ;                 

%%
/*
lines : lines expr ';' { printf("%f\n", $2);}
      | lines ';'
      | 
      ;*/
int main(){
  const char* sFile="./test/0.c";//打开要读取的文本文件
	FILE* fp=fopen(sFile, "r");
	if(fp==NULL)
	{
		printf("cannot open %s\n", sFile);
		return -1;
	}
	extern FILE* yyin;	//yyin和yyout都是FILE*类型
	yyin=fp;//yacc会从yyin读取输入，yyin默认是标准输入，这里改为磁盘文件。yacc默认向yyout输出，可修改yyout改变输出目的
 
	printf(">>>begin parsing %s<<<\n", sFile);
	yyparse();//使yacc开始读取输入和解析，它会调用lex的yylex()读取记号
	puts(">>>end parsing<<<");

	fclose(fp);
	return 0;
}

void yyerror(const char* s) {
	fprintf (stderr , "Parse error : %s\n", s );
	exit (1);
}