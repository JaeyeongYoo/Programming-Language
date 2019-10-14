%{
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
 extern FILE* yyin;
 typedef struct Node{
   double value;
   int var_name;
   struct Node * next;
 }Node;
 
 typedef struct List{
   Node* head;
   Node* cur;
   Node* tail;
   int num;
 }List;

 void Init(List * list)
 {
   list->head = NULL; list->cur = NULL; list->tail = NULL; list->num = 0;
 }
 
 void Insert(List * list, double data, int vari){

   if(list->head == NULL)
   {
      Node *newNode = (Node*)malloc(sizeof(Node));
      newNode->value = data; newNode->var_name = vari;
      list->head = newNode; list->tail = newNode;
   }
   else
   {
       list->cur = list->head;
       for(int i = 0; i<list->num; i++){
          if(list->cur->var_name == vari){
             list->cur->value = data;
             return;
          }
      }

      Node *newNode = (Node*)malloc(sizeof(Node));
      newNode->value = data; newNode->var_name = vari;
      list->tail->next = newNode;
      list->tail = newNode;
   }
   list->num++;
 }
 
 double Find(List * list, int vari){
   list->cur = list->head;
   double value;
   int i = 0;
   for(i = 0; i<list->num; i++)
   {
      if(list->cur->var_name == vari)
      {
         value = list->cur->value;
         list->cur=list->head;
         return value;
      }

      list->cur = list->cur->next;
   }
 
   if(i++ == list->num)
   {
      yyerror("no variable"); 
    
   }
 }
 List v;

%}

%start goal
%union{
    int INT;
    float FLOAT;
    double DOUBLE;
}
%token <DOUBLE> DIGIT 
%token <INT> VARI
%token EOL LP RP SP 
%right PLUS MINUS MULT DIV EQUAL
%left NEG
%type <DOUBLE> expr fact eval assg

%%
goal	: eval goal {}
	| eval {}
	;

eval 	: expr EOL { $$ = $1; printf("%lf\n", $1); }
	| assg EOL {}
	;

assg	: EQUAL VARI assg { Insert(&v, $3, $2); $$ = $3; }
	| expr { $$ = $1; }
	;

expr	: fact { $$ = $1; }
	| PLUS expr expr { $$ = $2 + $3; }
	| MINUS expr expr { $$ = $2 - $3; }
	| NEG expr { $$ = 0.0 - $2; }
	| MULT expr expr { $$ = $2 * $3; }
	| DIV expr expr { $$ = $2 / $3; } 
	;

fact	: DIGIT	{ $$ = $1; }
	| VARI { $$ = Find(&v, $1); }
	| LP expr RP { $$ = $2; }
	;
%%
 /* user code */
int yyerror(char *s)
{ return printf("%s\n", s); }

void parse(FILE* fileInput)
 {
    yyin= fileInput;
    while(feof(yyin)==0)
    {
       yyparse();
    }
 }


