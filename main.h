#include <iostream>
#include <fstream>
#include <iomanip>
#include <stdio.h>//printf和FILE要用的
using namespace std;
//#ifndef _GLBCXX_USE_CXX11_ABI
#define _D_GLBCXX_USE_CXX11_ABI 0
//#endif
 
/*当lex每识别出一个记号后，是通过变量yylval向yacc传递数据的。默认情况下yylval是int类型，也就是只能传递整型数据。
yylval是用YYSTYPE宏定义的，只要重定义YYSTYPE宏，就能重新指定yylval的类型(可参见yacc自动生成的头文件yacc.tab.h)。
在我们的例子里，当识别出标识符后要向yacc传递这个标识符串，yylval定义成整型不太方便(要先强制转换成整型，yacc里再转换回char*)。
这里把YYSTYPE重定义为struct Type，可存放多种信息*/

enum NodeType{
  KEYWORDS,
  INT_DATA,
  STRING_DATA,
  SIGN,
  OPERATOR,
  ID,
  UNREADABLE
};

class Node{
public:
  int No;
  //NodeType typeEnum;
  string type;
  string value;
  Node* child;
  Node* bro;
  int combined;
  Node(int t = 6, string v=""):No(-1),value(v),child(NULL),bro(NULL),combined(0){
    switch (t)
    {
    case 0:
      type = "keywords";
      break;
    case 1:
    case 2:
      type = "const";
      break;
    case 3:
      type = "sign";
      break;
    case 4:
      type = "operator";
      break;
    case 5:
      type = "Variable";
      break;    
    default:
      type = "UNREADABLE";
      break;
    };
  };
  void add_child(Node* c){
    if(child == NULL){
      child = c;
      /*if(type == UNREADABLE){
        No = c->No;
      }*/
    }
    else{
      Node* temp;
      for(temp = child ; temp->bro != NULL && temp ; temp = temp->bro);
      if(temp && !temp->bro){
        temp->bro = c;
      }
    }
  };
  void set_value(string s){
    value = s;
  };
  void set_type(string t){
    type = t;
  };
};

#define YYSTYPE Node*
//把YYSTYPE(即yylval变量)重定义为Node*类型，这样lex就能向yacc返回更多的数据了