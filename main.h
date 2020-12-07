#include <iostream>//使用C++库
#include <stdio.h>//printf和FILE要用的
using namespace std;
//#ifndef _GLBCXX_USE_CXX11_ABI
#define _D_GLBCXX_USE_CXX11_ABI 0
//#endif
 
/*当lex每识别出一个记号后，是通过变量yylval向yacc传递数据的。默认情况下yylval是int类型，也就是只能传递整型数据。
yylval是用YYSTYPE宏定义的，只要重定义YYSTYPE宏，就能重新指定yylval的类型(可参见yacc自动生成的头文件yacc.tab.h)。
在我们的例子里，当识别出标识符后要向yacc传递这个标识符串，yylval定义成整型不太方便(要先强制转换成整型，yacc里再转换回char*)。
这里把YYSTYPE重定义为struct Type，可存放多种信息*/
struct Type//通常这里面每个成员，每次只会使用其中一个，一般是定义成union以节省空间(但这里用了string等复杂类型造成不可以)
{
	string m_sId;
	int m_nInt;
	char m_cOp;
};

enum NodeType{
  KEYWORDS,
  INT_DATA,
  STRING_DATA,
  SIGN,
  OPERATOR,
  ID,
  UNREADABLE
};

extern int next = 0;

class Node{
public:
  int No;
  NodeType type;
  string value;
  Node* child;
  Node* bro;
  Node(int t = 6, string v=""){
    No = -1;
    switch (t)
    {
    case 0:
      type = KEYWORDS;
      break;
    case 1:
      type = INT_DATA;
      break;
    case 2:
      type = STRING_DATA;
      break;
    case 3:
      type = SIGN;
      break;
    case 4:
      type = OPERATOR;
      break;
    case 5:
      type = ID;
      break;    
    default:
      type = UNREADABLE;
      break;
    };
    if(type == KEYWORDS || type == INT_DATA || type == STRING_DATA || type == ID){
      No = ::next;
      ::next++;
    }
    value = v;
    child = NULL;
    bro = NULL;
  };
  void add_child(Node* c){
    if(child == NULL){
      child = c;
      if(type == UNREADABLE){
        No = c->No;
      }
    }
    Node* temp;
    for(temp = child ; temp->bro != NULL && temp ; temp = temp->bro);
    if(temp && !temp->bro){
      temp->bro = c;
    }
  };
};

#define YYSTYPE Node*
//把YYSTYPE(即yylval变量)重定义为Node*类型，这样lex就能向yacc返回更多的数据了