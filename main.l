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
{CONSTSTR}           {yyval = new Node(2,string(yytext));return String;}
{NUMBER}               {yyval = new Node(1,string(yytext));return Num;}
{SCANF}                   {yyval = new Node(0,string(yytext));return Scanf;}
{PRINTF}                  {yyval = new Node(0,string(yytext));return Printf;}
{RETURN}                {yyval = new Node(0,string(yytext));return Return;}
{WHILE}                    {yyval = new Node(0,string(yytext));return While;}
{IF}                              {yyval = new Node(0,string(yytext));return If;}
{ELSE}                       {yyval = new Node(0,string(yytext));return Else;}
{SWITCH}                 {yyval = new Node(0,string(yytext));return Switch;}
{FOR}                         {yyval = new Node(0,string(yytext));return For;}
{BREAK}                   {yyval = new Node(0,string(yytext));return Break;}
{CONTINUE}           {yyval = new Node(0,string(yytext));return Continue;}
{DO}                           {yyval = new Node(0,string(yytext));return Do;}
{INT}                          {yyval = new Node(0,string(yytext));return Type;}
{CHAR}                     {yyval = new Node(0,string(yytext));return Type;}
{FLOAT}                    {yyval = new Node(0,string(yytext));return Type;}
{DOUBLE}                {yyval = new Node(0,string(yytext));return Type;}
{VOID}                       {yyval = new Node(0,string(yytext));return Type;}
{CONST}                   {yyval = new Node(0,string(yytext));return Type;}
{TRUE}                      {yyval = new Node(0,string(yytext));return True;}
{FALSE}                     {yyval = new Node(0,string(yytext));return False;}
{LPAREN}                 {yyval = new Node(3,string(yytext));return Lp;}
{RPAREN}                {yyval = new Node(3,string(yytext));return Rp;}
{LBRACE}                 {yyval = new Node(3,string(yytext));return Lb;}
{RBRACE}                 {yyval = new Node(3,string(yytext));return Rb;}
{SEMICOLON}        {yyval = new Node(3,string(yytext));return Semicolon;}
{EQ}                           {yyval = new Node(4,string(yytext));return CompOp;}
{NE}                           {yyval = new Node(4,string(yytext));return CompOp;}
{LT}                            {yyval = new Node(4,string(yytext));return CompOp;}
{GT}                          {yyval = new Node(4,string(yytext));return CompOp;}
{LE}                           {yyval = new Node(4,string(yytext));return CompOp;}
{GE}                          {yyval = new Node(4,string(yytext));return CompOp;}
{AND}                         {yyval = new Node(4,string(yytext));return CompOp;}
{OR}                           {yyval = new Node(4,string(yytext));return CompOp;}
{NOT}                        {yyval = new Node(4,string(yytext));return Not;}
{ASSIGN}                  {yyval = new Node(4,string(yytext));return Assign;}
{PLUS}                      {yyval = new Node(4,string(yytext));return AriOp;}
{MINUS}                   {yyval = new Node(4,string(yytext));return AriOp;}
{MULT}                      {yyval = new Node(4,string(yytext));return AriOp;}
{DIV}                          {yyval = new Node(4,string(yytext));return AriOp;}
{MOD}                       {yyval = new Node(4,string(yytext));return AriOp;}
{INCRE}                    {yyval = new Node(4,string(yytext));return SelfOp;}
{DECRE}                   {yyval = new Node(4,string(yytext));return SelfOp;}
{PLUSA}                   {yyval = new Node(4,string(yytext));return AriAOp;}
{MINUSA}                {yyval = new Node(4,string(yytext));return AriAOp;}
{MULTA}                   {yyval = new Node(4,string(yytext));return AriAOp;}
{DIVA}                       {yyval = new Node(4,string(yytext));return AriAOp;}
{MODA}                    {yyval = new Node(4,string(yytext));return AriAOp;}
{ID}                            {yyval = new Node(5,string(yytext));return Variable;}
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