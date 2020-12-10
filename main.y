%{
  #include "main.h"
  extern "C"{
    void yyerror(const char *s);
    extern int yylex(void);
  };
  Node* root;
  int index=1;

  void printTree(Node *root,ofstream& outfile){
    if(root == NULL){
      printf("it's an empty tree!\n");
      return;
    }
    else{
      cout << "@" << setw(3) << left << root->No  << "|" << setw(10) << left << root->type  << "|" << setw(30) << left << root->value  << "|[";
      //printf(s);
      for(Node *temp = root->child; temp ; temp = temp->bro){
        cout << "@" << temp->No << " ";
      }
      cout <<"]" << endl;
      outfile << "@" << setw(3) << left << root->No  << "|" << setw(10) << left << root->type  << "|" << setw(30) << left << root->value  << "|[";
      //printf(s);
      for(Node *temp = root->child; temp ; temp = temp->bro){
        outfile << "@" << temp->No << " ";
      }
      outfile <<"]" << endl;
      
      for(Node *temp = root->child; temp ; temp = temp->bro){
        printTree(temp,outfile);
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
  };

  void setNo(Node *node,int i){
    node->No = i;
  }
  void order(Node *root){
    for(Node *temp = root->child ; temp ; temp = temp->bro){
      temp->No = ::index;
      ::index++;
    }
    for(Node *temp = root->child ; temp ; temp = temp->bro){
      order(temp);
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
: Stmts                                                        {::root = $1;::root->set_type("program");::root->No=0;}
//Node *node = new Node;node->set_type("program");node->No = 0;node->add_child($1);::root = node;}
//[@2 @3 @5 @8 @14 @18 @22 @26 @46 @48 @50 ]
;         

Stmts 
: Stmt                                                           {$$ = $1;$$->combined = 0;}
| Stmts Stmt                                              {
  if($1->combined){
    $$ = $1;
    $$->add_child($2);
  }
  else{
    Node *node = new Node;
    node->add_child($1);
    node->add_child($2);
    node->set_type("statements");
    node->combined = 1;
    $$ = node;
  }
}
;


Stmt 
: Instr                                                           {$$ = $1;$$->set_type("statement");}
| Type x Lp Rp Block                              {
  Node *node = new Node;
  node->set_type("statement-function");
  node->add_child($1);
  node->add_child($2);
  node->add_child($5);
  $$=node;}
| If Lp BExp Rp Block                             {
  Node *node = new Node;
  node->set_type("statement-if");
  node->add_child($1);
  node->add_child($3);
  node->add_child($5);
  $$=node;}
| If Lp BExp Rp Block Else Block       {
  Node *node = new Node;
  node->set_type("statement-if");
  node->add_child($1);
  node->add_child($3);
  node->add_child($5);
  node->add_child($6);
  node->add_child($7);
  $$=node;}
| For Lp Instr BExp Instr Rp Block     {
  Node *node = new Node;
  node->set_type("statement-for");
  node->add_child($1);
  node->add_child($3);
  node->add_child($4);
  node->add_child($5);
  node->add_child($7);
  $$=node;}
| While Lp BExp Rp Block                    {
  Node *node = new Node;
  node->set_type("statement-while");
  node->add_child($1);
  node->add_child($3);
  node->add_child($5);
  $$=node;}
;

Block 
:Stmt                                                           {$$=$1;}
| Lb Stmts Rb                                            {$$=$2;}
;

Instr 
: Type idList Semicolon                      {
  Node *node = new Node;
  node->add_child($1);
  node->add_child($2);
  node->set_type("declaration");
  $$ = node;
}
| x Assign Expr Semicolon                {
  Node *node = new Node;
  node->add_child($1);
  node->add_child($2);
  node->add_child($3);
  node->set_type("calculation");
  $$ = node;
}
| x AriAOp Expr Semicolon               {
  Node *node = new Node;
  node->add_child($1);
  node->add_child($2);
  node->add_child($3);
  node->set_type("calculation");
  $$ = node;
}
|SelfOp x Semicolon                          {
  Node *node = new Node;
  node->add_child($1);
  node->add_child($2);
  node->set_type("calculation");
  $$ = node;
}
| x SelfOp Semicolon                         {
  Node *node = new Node;
  node->add_child($1);
  node->add_child($2);
  node->set_type("calculation");
  $$ = node;
}
| Printf Lp Expr Rp Semicolon        {
  Node *node = new Node;
  node->add_child($1);
  node->add_child($3);
  node->set_type("instruction-printf");
  $$ = node;
}
| Printf Lp BExp Rp Semicolon       {
  Node *node = new Node;
  node->add_child($1);
  node->add_child($3);
  node->set_type("instruction-printf");
  $$ = node;
}
| Printf Lp String x Rp Semicolon  {
  Node *node = new Node;
  node->add_child($1);
  node->add_child($3);
  node->add_child($4);
  node->set_type("instruction-printf");
  $$ = node;
}
| Scanf Lp String x Rp Semicolon  {
  Node *node = new Node;
  node->add_child($1);
  node->add_child($3);
  node->add_child($4);
  node->set_type("instruction-scanf");
  $$ = node;
}
;

idList 
: id                                                              {$$=$1;}
| idList id                                                  {
  if($1->combined){
    $$ = $1;
    $$->add_child($2);
  }
  else{
    Node *node = new Node;
    node->add_child($1);
    node->add_child($2);
    node->set_type("idList");
    node->combined = 1;
    $$ = node;
  }
}
;

id 
: x                                                               {$$=$1;}
| x Assign Expr                                      {
  Node *node = new Node;
  node->add_child($1);
  node->add_child($2);
  node->add_child($3);
  node->set_type("Variable");
  $$ = node;}
;

BExp 
: True                                                         {$$ = $1;$$->set_type("BExp");}
| False                                                        {$$ = $1;$$->set_type("BExp");}
| Expr CompOp Expr                            {
  Node *node = new Node;
  node->add_child($1);
  node->add_child($2);
  node->add_child($3);
  node->set_type("BExp");
  $$ = node;}
| Not BExp                                                {
  Node *node = new Node;
  node->add_child($1);
  node->add_child($2);
  node->set_type("BExp");
  $$ = node;}
;

Expr  
: x                                                                 {$$ = $1;$$->set_type("Expr");}
| Num                                                          {$$ = $1;$$->set_type("Expr");}
| String                                                       {$$ = $1;$$->set_type("Expr");}
| Expr Plus Expr                                      {
  Node *node = new Node;
  node->add_child($1);
  node->add_child($2);
  node->add_child($3);
  node->set_type("expression");
  $$ = node;}
| Expr Minus Expr                                   {
  Node *node = new Node;
  node->add_child($1);
  node->add_child($2);
  node->add_child($3);
  node->set_type("expression");
  $$ = node;}
| Expr Mult Expr                                      {
  Node *node = new Node;
  node->add_child($1);
  node->add_child($2);
  node->add_child($3);
  node->set_type("expression");
  $$ = node;}
| Expr Div Expr                                        {
  Node *node = new Node;
  node->add_child($1);
  node->add_child($2);
  node->add_child($3);
  node->set_type("expression");
  $$ = node;}
| Expr Mod Expr                                     {
  Node *node = new Node;
  node->add_child($1);
  node->add_child($2);
  node->add_child($3);
  node->set_type("expression");
  $$ = node;}
;

x 
: Variable                                                   {$$ = $1;}
;
        

%%
int main(){
  const char* sFile="./test/1.c";//打开要读取的文本文件
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
  order(root);
  printf("tree:\n");
  cout << " No |" << setw(10) << left << "yacc type" << "|" << setw(30) << left << "value" << "|" << setw(50) << left << "Child" << endl;
  ofstream outfile("./test/1_result.txt",ios::app);
  printTree(root,outfile);
  outfile.close();
  printf("End tree\n");
	fclose(fp);
	return 0;
}

void yyerror(const char* s) {
	fprintf (stderr , "Parse error : %s\n", s );
	exit (1);
}