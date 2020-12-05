%option noyywrap
%{
#include "tree.h"
idChain *idList = new idChain;
string result="";
%}


NUMBER          [0-9]+
SCANF           scanf
PRINTF          printf
RETURN          return
WHILE           while
IF              if
ELSE            else
SWITCH          switch
FOR             for
BREAK           break
CONTINUE        continue
DO              do
INT             int
CHAR            char
FLOAT           float
DOUBLE          double
VOID            void
CONST           const
LPAREN          \(
RPAREN          \)
LBRACE          \{
RBRACE          \}
SEMICOLON       [;]
EQ              ==
NE              !=
LE              <=
AND             &&
OR              \|\|
NOT             [!]
LT              [<]
ASSIGN          [=]
PLUS            [+]
MINUS           [-]
MULT            [*]
DIV             [/]
MOD             [%]
SPACE           [ \n\t]+
ID              [A-Za-z_][A-Za-z0-9_]*
OTHER           .

%%

{SPACE}                 {/*Do nothing*/}
{NUMBER}                {result = result + "NUMBER                " + string(yytext) + "     " + string(yytext) + '\n';}
{SCANF}                 {result = result + "SCANF                    scanf\n";}
{PRINTF}                {result = result + "PRINTF                  printf\n";}
{RETURN}                {result = result + "RETURN                return\n";}
{WHILE}                 {result = result + "WHILE                 while\n";}
{IF}                    {result = result + "IF                    if\n";}
{ELSE}                  {result = result + "ELSE                         else\n";}
{SWITCH}                {result = result + "SWITCH                  switch\n";}
{FOR}                   {result = result + "FOR                          for\n";}
{BREAK}                 {result = result + "BREAK                    break\n";}
{CONTINUE}              {result = result + "CONTINUE            continue\n";}
{DO}                    {result = result + "DO                            do\n";}
{INT}                   {result = result + "INT                   int\n";}
{CHAR}                  {result = result + "CHAR                       char\n";}
{FLOAT}                 {result = result + "FLOAT                     float\n";}
{DOUBLE}                {result = result + "DOUBLE                double\n";}
{VOID}                  {result = result + "VOID                       void\n";}
{CONST}                 {result = result + "CONST                  const\n";}
{LPAREN}                {result = result + "LPAREN                (\n";}
{RPAREN}                {result = result + "RPAREN                )\n";}
{LBRACE}                {result = result + "LBRACE                {\n";}
{RBRACE}                {result = result + "RBRACE                }\n";}
{SEMICOLON}             {result = result + "SEMICOLON             ;\n";}
{EQ}                    {result = result + "EQ                    ==\n";}
{NE}                    {result = result + "NE                    !=\n";}
{LT}                    {result = result + "LT                      <\n";}
{LE}                    {result = result + "LE                     <=\n";}
{AND}                   {result = result + "AND                 &&\n";}
{OR}                    {result = result + "OR                    ||\n";}
{NOT}                   {result = result + "NOT                !\n";}
{ASSIGN}                {result = result + "ASSIGN                =\n";}
{PLUS}                  {result = result + "PLUS                  +\n";}
{MINUS}                 {result = result + "MINUS               -\n";}
{MULT}                  {result = result + "MULT                  *\n";}
{DIV}                   {result = result + "DIV                   /\n";}
{MOD}                   {result = result + "MOD                   %\n";}
{ID}                    {string newId = string(yytext),index;result = result + "ID                    " + newId;int i = idList->searchId(newId);index = to_string(i);result = result + "        " + index + '\n';}

%%

int main(){
  ifstream input("./test/0.c");
  ofstream output("./test/0_out_cPlusPlus.txt");
  yyFlexLexer lexer(&input);
  lexer.yylex();
  output << result << endl;
  return 0;
}
