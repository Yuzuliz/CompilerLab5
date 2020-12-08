%{
  #include "main.h"
  extern "C"{
    void yyerror(const char *s);
    extern int yylex(void);
  };
  Node* root;

  void printTree(Node *root){
    if(root == NULL){
      printf("it's an empty tree!\n");
      return;
    }
    else{
      cout << "@" << setw(3) << left << root->No  << "|" << setw(15) << left << root->value  << "|[";
      //printf(s);
      for(Node *temp = root->child; temp ; temp = temp->bro){
        cout << "@" << temp->No << " ";
      }
      cout <<"]" <<  endl;
      for(Node *temp = root->child; temp ; temp = temp->bro){
        printTree(temp);
      }
    }
  };

  void clearTree(Node *root){
    Node *temp,*cur;
    for(temp = root->child ; temp ; temp = temp->bro){
      if(temp->No != -1){
        continue;
      }
      else{
        for(cur = temp->child ; cur && cur->bro ; cur);
        if(cur && !cur->bro){
          cur->bro = temp->bro;
          temp->bro = cur;
        }
        for(temp = root->child ; temp ; temp = temp->bro){
          clearTree(temp);
        }
      }
    }
  };

  void printTree2(int i,Node *root){
    int num = 0,j;
    Node *temp;
    for(temp = root->child ; temp ; temp = temp->bro){
      num++;
    }
    if(num == 0){
      return;
    }
    temp = root->child;
    for(j = 0 ; j < num/2 ; j++){
      printTree2(i+1,temp);
      temp = temp->bro;
    }
    for(int k = 0 ; k < i ; k++){
      cout << "-";
    }
    cout  << root->value  << "|"<< endl;
    for(j ; j < num ; j++){
      printTree2(i+1,temp);
      temp = temp->bro;
    }
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
%token And
%token Or
%token Not
%token Assign
%token Plus
%token Minus
%token Mult
%token Div
%token Mod
%token SelfOp
%token AriAOp
%token Variable

%left CompOp

%right AriAOp

%left Plus Minus
%left Mult Div Mod

%left Or
%left And
%right Not


%%
Prog 
: Stmts                          {printf("Prog:Stmts --> ");::root = new Node;::root->set_value("program");::root->add_child($1);::root->No = 0;printf("over\n");}
;         

Stmts 
: Stmt                             {printf("Stmt --> ");$$ = $1;$1->set_value("statements");printf("over\n");}
| Stmts Stmt                {printf("Stmts Stmt --> ");Node *node = new Node;node->set_value("statements");node->add_child($1);node->add_child($2);$$ = node;printf("over\n");}
;


Stmt 
: Instr                                 {printf("Instr --> ");Node *node = new Node;node->set_value("statement");node->add_child($1);printf("Stmt  : Instr\n");$$ = node;printf("over\n");}
| If Lp BExp Rp Block                             {printf("if --> ");Node *node = new Node;node->set_value("statement");node->add_child($1);node->add_child($3);node->add_child($5);$$ = node;printf("over\n");}
| If Lp BExp Rp Block Else Block       {printf("if else --> ");Node *node = new Node;node->set_value("statement");node->add_child($1);node->add_child($3);node->add_child($5);node->add_child($6);node->add_child($7);$$ = node;printf("over\n");}
| While Lp BExp Rp Block       {printf("while --> ");Node *node = new Node;node->set_value("statement");node->add_child($1);node->add_child($3);node->add_child($5);printf("While Lp BExp Rp Stmt Lb S Rb\n");$$ = node;printf("over\n");}
;

Block 
:Stmt                                 {printf("Stmt --> ");$$=$1;printf("over\n");}
|Lb Stmts Rb                  {printf("{...} --> ");$$=$2;printf("over\n");}
|Lb Stmt   Rb                  {printf("{...\\n...} --> ");$$=$2;printf("over\n");}
;

Instr 
: Type x Semicolon                              {printf("int a --> ");Node *node = new Node;node->set_value("instruction");node->add_child($1);node->add_child($2);$$ = node;printf("over\n");}
| Type x Assign Expr Semicolon     {printf("int a=1 --> ");Node *node = new Node;node->set_value("instruction");node->add_child($1);node->add_child($2);node->add_child($3);node->add_child($4);$$ = node;printf("over\n");}
| x Assign Expr Semicolon                {printf("a=1 --> ");Node *node = new Node;node->set_value("instruction");node->add_child($1);node->add_child($2);node->add_child($3);$$ = node;printf("over\n");}
| x AriAOp Expr Semicolon               {printf("a+=1 --> ");Node *node = new Node;node->set_value("instruction");node->add_child($1);node->add_child($2);node->add_child($3);$$ = node;printf("over\n");}
|SelfOp x Semicolon                          {printf("++a --> ");Node *node = new Node;node->set_value("instruction");node->add_child($1);node->add_child($2);$$ = node;printf("over\n");}
| x SelfOp Semicolon                         {printf("a++ --> ");Node *node = new Node;node->set_value("instruction");node->add_child($1);node->add_child($2);$$ = node;printf("over\n");}
| Printf Lp Expr Rp Semicolon       {printf("printf(expr) --> ");Node *node = new Node;node->set_value("instruction");node->add_child($1);node->add_child($3);$$ = node;printf("over\n");}
| Printf Lp BExp Rp Semicolon      {printf("printf(bexp) --> ");Node *node = new Node;node->set_value("instruction");node->add_child($1);node->add_child($3);$$ = node;printf("over\n");}
| Printf Lp String x Rp Semicolon {printf("printf(s,x) --> ");Node *node = new Node;node->set_value("instruction");node->add_child($1);node->add_child($3);node->add_child($4);$$ = node;printf("over\n");}
| Scanf Lp String x Rp Semicolon {printf("scanf(s,x) --> ");Node *node = new Node;node->set_value("instruction");node->add_child($1);node->add_child($3);node->add_child($4);$$ = node;printf("over\n");}
;

BExp 
: True                                {printf("True --> ");Node *node = new Node;node->set_value("boolExpression");node->add_child($1);printf("BExp : True \n");$$ = node;printf("over\n");}
| False                              {printf("False --> ");Node *node = new Node;node->set_value("boolExpression");node->add_child($1);printf("False\n");$$ = node;printf("over\n");}
| Expr CompOp Expr  {printf("expr comp expr --> ");Node *node = new Node();node->set_value("boolExpression");node->add_child($1);node->add_child($2);node->add_child($3);$$ = node;printf("over\n");}
| Not BExp                      {printf("!x\n");Node *node = new Node;node->set_value("boolExpression");node->add_child($1);node->add_child($2);printf("Not BExp  \n");$$ = node;printf("over\n");}
;

Expr  
: x                                       {printf("x --> ");$$=$1;printf("over\n");}
| Num                               {printf("1 --> ");$$=$1;printf("over\n");}
| String                            {printf("'2' --> ");$$=$1;printf("over\n");}
| Expr Plus Expr           {printf("1+1 --> ");Node *node = new Node;node->set_value("expression");node->add_child($1);node->add_child($2);node->add_child($3);$$ = node;printf("over\n");}
| Expr Minus Expr        {printf("1-1 --> ");Node *node = new Node;node->set_value("expression");node->add_child($1);node->add_child($2);node->add_child($3);$$ = node;printf("over\n");}
| Expr Mult Expr           {printf("1*1 --> ");Node *node = new Node;node->set_value("expression");node->add_child($1);node->add_child($2);node->add_child($3);$$ = node;printf("over\n");}
| Expr Div Expr             {printf("1/1 --> ");Node *node = new Node;node->set_value("expression");node->add_child($1);node->add_child($2);node->add_child($3);$$ = node;printf("over\n");}
| Expr Mod Expr          {printf("1 mod 1 --> ");Node *node = new Node;node->set_value("expression");node->add_child($1);node->add_child($2);node->add_child($3);$$ = node;printf("over\n");}
;

x 
: Variable                        {printf("variable --> ");$$ = $1;printf("over\n");}
;
        

%%
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
 
	printf("\n\n>>>begin parsing %s<<<\n\n", sFile);
	yyparse();//使yacc开始读取输入和解析，它会调用lex的yylex()读取记号
	puts(">>>end parsing<<<\n----------------------------------------------\n");
  printf("tree:\n");
  cout << " No |" << setw(15) << left << "yacc type" << "|Child" << endl;
  printTree(root);
  printf("End tree\n");

  printTree2(0,root);
	fclose(fp);
	return 0;
}

void yyerror(const char* s) {
	fprintf (stderr , "Parse error : %s\n", s );
	exit (1);
}

