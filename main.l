%{
  #include "main.h"
  #include "main.tab.h"
  extern "C"{
    int yywrap(void);
    int yylex(void);
  }

%}

BLOCKCOMMENT     \/\*([^\*^\/]*|[\*^\/*]*|[^\**\/]*)*\*\/
LINECOMMENT         \/\/[^\n]*
CONSTSTR                  \"(\\.|[^"\\])*\"
SIGN                              [-]?
NUMBER                      {SIGN}[0-9]+
SCANF                          scanf
PRINTF                         printf
RETURN                       return
WHILE                           while
IF                                     if
ELSE                               else
SWITCH                         switch
FOR                                 for
BREAK                            break
CONTINUE                    continue
DO                                    do
INT                                   int
CHAR                               char
FLOAT                             float
DOUBLE                         double
VOID                                void
CONST                            const
TRUE                               true
FALSE                              false
LPAREN                          \(
RPAREN                          \)
LBRACE                           \{
RBRACE                          \}
SEMICOLON                  [;]
EQ                                     ==
NE                                     !=
LE                                      \<\=
GE                                     \>\=
PLUSA                              \+\=
MINUSA                           \-\=
MULTA                              \*\=
DIVA                                   \/\=
MODA                                \%\=
AND                                  &&
OR                                     \|\|
NOT                                   [!]
LT                                       \<
GT                                      \>
ASSIGN                            [=]
PLUS                                [+]
MINUS                             [-]
MULT                                [*]
DIV                                    [/]
MOD                                 [%]
INCRE                              \+\+
DECRE                             \-\-
SPACE                             [ \n\t]+
ID                                      {SIGN}[A-Za-z_][A-Za-z0-9_]*
OTHER                           .

%%

{BLOCKCOMMENT}    {/*Do nothing*/}
{LINECOMMENT}         {/*Do nothing*/}
{SPACE}                           {/*Do nothing*/}
{CONSTSTR}                  {Node *node = new Node(2,string(yytext));printf("CONSTSTR\n");yylval = node;return String;}
{NUMBER}                      {Node *node = new Node(1,string(yytext));printf("NUMBER\n");yylval = node;return Num;}
{SCANF}                          {Node *node = new Node(0,string(yytext));printf("SCANF\n");yylval = node;return Scanf;}
{PRINTF}                         {Node *node = new Node(0,string(yytext));printf("PRINTF\n");yylval = node;return Printf;}
{RETURN}                       {Node *node = new Node(0,string(yytext));printf("RETURN\n");yylval = node;return Return;}
{WHILE}                           {Node *node = new Node(0,string(yytext));printf("WHILE\n");yylval = node;return While;}
{IF}                                     {Node *node = new Node(0,string(yytext));printf("IF\n");yylval = node;return If;}
{ELSE}                              {Node *node = new Node(0,string(yytext));printf("ELSE\n");yylval = node;return Else;}
{SWITCH}                        {Node *node = new Node(0,string(yytext));printf("SWITCH\n");yylval = node;return Switch;}
{FOR}                                {Node *node = new Node(0,string(yytext));printf("FOR\n");yylval = node;return For;}
{BREAK}                          {Node *node = new Node(0,string(yytext));printf("BREAK\n");yylval = node;return Break;}
{CONTINUE}                  {Node *node = new Node(0,string(yytext));printf("CONTINUE\n");yylval = node;return Continue;}
{DO}                                  {Node *node = new Node(0,string(yytext));printf("DO\n");yylval = node;return Do;}
{INT}                                 {Node *node = new Node(0,string(yytext));printf("INT\n");yylval = node;return Type;}
{CHAR}                            {Node *node = new Node(0,string(yytext));printf("CHAR\n");yylval = node;return Type;}
{FLOAT}                           {Node *node = new Node(0,string(yytext));printf("FLOAT\n");yylval = node;return Type;}
{DOUBLE}                       {Node *node = new Node(0,string(yytext));printf("DOUBLE\n");yylval = node;return Type;}
{VOID}                              {Node *node = new Node(0,string(yytext));printf("VOID\n");yylval = node;return Type;}
{CONST}                          {Node *node = new Node(0,string(yytext));printf("CONST\n");yylval = node;return Type;}
{TRUE}                             {Node *node = new Node(0,string(yytext));printf("TRUE\n");yylval = node;return True;}
{FALSE}                            {Node *node = new Node(0,string(yytext));printf("FALSE\n");yylval = node;return False;}
{LPAREN}                        {Node *node = new Node(3,string(yytext));printf("LPAREN\n");yylval = node;return Lp;}
{RPAREN}                       {Node *node = new Node(3,string(yytext));printf("RPAREN\n");yylval = node;return Rp;}
{LBRACE}                        {Node *node = new Node(3,string(yytext));printf("LBRACE\n");yylval = node;return Lb;}
{RBRACE}                        {Node *node = new Node(3,string(yytext));printf("RBRACE\n");yylval = node;return Rb;}
{SEMICOLON}               {Node *node = new Node(3,string(yytext));printf("SEMICOLON\n");yylval = node;return Semicolon;}
{EQ}                                  {Node *node = new Node(4,string(yytext));printf("EQ\n");yylval = node;return CompOp;}
{NE}                                  {Node *node = new Node(4,string(yytext));printf("NE\n");yylval = node;return CompOp;}
{LT}                                   {Node *node = new Node(4,string(yytext));printf("LT\n");yylval = node;return CompOp;}
{GT}                                  {Node *node = new Node(4,string(yytext));printf("GT\n");yylval = node;return CompOp;}
{LE}                                   {Node *node = new Node(4,string(yytext));printf("LE\n");yylval = node;return CompOp;}
{GE}                                  {Node *node = new Node(4,string(yytext));printf("GE\n");yylval = node;return CompOp;}
{AND}                               {Node *node = new Node(4,string(yytext));printf("AND\n");yylval = node;return And;}
{OR}                                  {Node *node = new Node(4,string(yytext));printf("OR\n");yylval = node;return Or;}
{NOT}                               {Node *node = new Node(4,string(yytext));printf("NOT\n");yylval = node;return Not;}
{ASSIGN}                         {Node *node = new Node(4,string(yytext));printf("ASSIGN\n");yylval = node;return Assign;}
{PLUS}                             {Node *node = new Node(4,string(yytext));printf("PLUS\n");yylval = node;return Plus;}
{MINUS}                          {Node *node = new Node(4,string(yytext));printf("MINUS\n");yylval = node;return Minus;}
{MULT}                             {Node *node = new Node(4,string(yytext));printf("MULT\n");yylval = node;return Mult;}
{DIV}                                 {Node *node = new Node(4,string(yytext));printf("DIV\n");yylval = node;return Div;}
{MOD}                              {Node *node = new Node(4,string(yytext));printf("MOD\n");yylval = node;return Mod;}
{INCRE}                           {Node *node = new Node(4,string(yytext));printf("INCRE\n");yylval = node;return SelfOp;}
{DECRE}                          {Node *node = new Node(4,string(yytext));printf("DECRE\n");yylval = node;return SelfOp;}
{PLUSA}                          {Node *node = new Node(4,string(yytext));printf("PLUSA\n");yylval = node;return AriAOp;}
{MINUSA}                       {Node *node = new Node(4,string(yytext));printf("MINUSA\n");yylval = node;return AriAOp;}
{MULTA}                          {Node *node = new Node(4,string(yytext));printf("MULTA\n");yylval = node;return AriAOp;}
{DIVA}                              {Node *node = new Node(4,string(yytext));printf("DIVA\n");yylval = node;return AriAOp;}
{MODA}                           {Node *node = new Node(4,string(yytext));printf("MODA\n");yylval = node;return AriAOp;}
{ID}                                   {Node *node = new Node(5,string(yytext));printf("ID\n");yylval = node;return Variable;}
{OTHER}                         {}

%%
// idList
/*string newId = string(yytext),index;if(newId[0]=='-')newId = newId.erase(0,1);result = result + "ID                    " + string(yytext);int i = idList->searchId(newId);index = to_string(i);result = result + "        " + index + '\n';*/
/*
int main(){
  ifstream input("./test/0.c");
  ofstream output("./test/0_out_cPlusPlus.txt");
  yyFlexLexer lexer(&input);
  lexer.yylex();
  output << result << endl;
  return 0;
}*/

int yywrap(void){
  puts(">>>end of the file<<<");
  return 1;
}