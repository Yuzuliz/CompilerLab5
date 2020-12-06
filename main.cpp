#include "main.h"
Node::Node(string v="",int t = 6){
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
}

void Node::add_child(Node* c){
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
}