%{
  #include "main.h"
  #include "main.tab.h"
  extern "C"{
    int yywrap(void);
    int yylex(void);
  }
  /*
idChain *idList = new idChain;
string result="";*/
%}

CONSTSTR   \"(\\.|[^"\\])*\"
SIGN               [-]?
NUMBER       {SIGN}[0-9]+
SCANF           scanf
PRINTF          printf
RETURN        return
WHILE            while
IF                      if
ELSE                else
SWITCH          switch
FOR                  for
BREAK             break
CONTINUE     continue
DO                     do
INT                    int
CHAR                char
FLOAT              float
DOUBLE          double
VOID                 void
CONST             const
TRUE                true
FALSE               false
LPAREN           \(
RPAREN           \)
LBRACE            \{
RBRACE           \}
SEMICOLON   [;]
EQ                      ==
NE                      !=
LE                       \<\=
GE                      \>\=
PLUSA               \+\=
MINUSA            \-\=
MULTA               \*\=
DIVA                    \/\=
MODA                 \%\=
AND                   &&
OR                      \|\|
NOT                    [!]
LT                        \<
GT                       \>
ASSIGN             [=]
PLUS                 [+]
MINUS              [-]
MULT                 [*]
DIV                     [/]
MOD                  [%]
INCRE               \+\+
DECRE              \-\-
SPACE              [ \n\t]+
ID                       {SIGN}[A-Za-z_][A-Za-z0-9_]*
OTHER            .

%%

{SPACE}                    {/*Do nothing*/}
{CONSTSTR}           {yylval = new Node(2,string(yytext));return String;}
{NUMBER}               {yylval = new Node(1,string(yytext));return Num;}
{SCANF}                   {yylval = new Node(0,string(yytext));return Scanf;}
{PRINTF}                  {yylval = new Node(0,string(yytext));return Printf;}
{RETURN}                {yylval = new Node(0,string(yytext));return Return;}
{WHILE}                    {yylval = new Node(0,string(yytext));return While;}
{IF}                              {yylval = new Node(0,string(yytext));return If;}
{ELSE}                       {yylval = new Node(0,string(yytext));return Else;}
{SWITCH}                 {yylval = new Node(0,string(yytext));return Switch;}
{FOR}                         {yylval = new Node(0,string(yytext));return For;}
{BREAK}                   {yylval = new Node(0,string(yytext));return Break;}
{CONTINUE}           {yylval = new Node(0,string(yytext));return Continue;}
{DO}                           {yylval = new Node(0,string(yytext));return Do;}
{INT}                          {yylval = new Node(0,string(yytext));return Type;}
{CHAR}                     {yylval = new Node(0,string(yytext));return Type;}
{FLOAT}                    {yylval = new Node(0,string(yytext));return Type;}
{DOUBLE}                {yylval = new Node(0,string(yytext));return Type;}
{VOID}                       {yylval = new Node(0,string(yytext));return Type;}
{CONST}                   {yylval = new Node(0,string(yytext));return Type;}
{TRUE}                      {yylval = new Node(0,string(yytext));return True;}
{FALSE}                     {yylval = new Node(0,string(yytext));return False;}
{LPAREN}                 {yylval = new Node(3,string(yytext));return Lp;}
{RPAREN}                {yylval = new Node(3,string(yytext));return Rp;}
{LBRACE}                 {yylval = new Node(3,string(yytext));return Lb;}
{RBRACE}                 {yylval = new Node(3,string(yytext));return Rb;}
{SEMICOLON}        {yylval = new Node(3,string(yytext));return Semicolon;}
{EQ}                           {yylval = new Node(4,string(yytext));return CompOp;}
{NE}                           {yylval = new Node(4,string(yytext));return CompOp;}
{LT}                            {yylval = new Node(4,string(yytext));return CompOp;}
{GT}                          {yylval = new Node(4,string(yytext));return CompOp;}
{LE}                           {yylval = new Node(4,string(yytext));return CompOp;}
{GE}                          {yylval = new Node(4,string(yytext));return CompOp;}
{AND}                         {yylval = new Node(4,string(yytext));return CompOp;}
{OR}                           {yylval = new Node(4,string(yytext));return CompOp;}
{NOT}                        {yylval = new Node(4,string(yytext));return Not;}
{ASSIGN}                  {yylval = new Node(4,string(yytext));return Assign;}
{PLUS}                      {yylval = new Node(4,string(yytext));return AriOp;}
{MINUS}                   {yylval = new Node(4,string(yytext));return AriOp;}
{MULT}                      {yylval = new Node(4,string(yytext));return AriOp;}
{DIV}                          {yylval = new Node(4,string(yytext));return AriOp;}
{MOD}                       {yylval = new Node(4,string(yytext));return AriOp;}
{INCRE}                    {yylval = new Node(4,string(yytext));return SelfOp;}
{DECRE}                   {yylval = new Node(4,string(yytext));return SelfOp;}
{PLUSA}                   {yylval = new Node(4,string(yytext));return AriAOp;}
{MINUSA}                {yylval = new Node(4,string(yytext));return AriAOp;}
{MULTA}                   {yylval = new Node(4,string(yytext));return AriAOp;}
{DIVA}                       {yylval = new Node(4,string(yytext));return AriAOp;}
{MODA}                    {yylval = new Node(4,string(yytext));return AriAOp;}
{ID}                            {yylval = new Node(5,string(yytext));return Variable;}
{OTHER}                  {}

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