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
%token <DOUBLE> NUMBER 
%token <INT> ID
%token EOL LP RP LM RM SET to PRINT THEN ENDIF ELSE WHILE DO ENDWHILE FUNC
%right PLUS MINUS MULT DIV
%left NEG
%type <DOUBLE> expr fact eval assg

%%
program	: func_decl stmt_list {}
	;

stmt_list 	: stmt_list stmt { $$ = $2; }
		| stmt { $$ = $1; }
		;

stmt	: assign_stmt { $$ = $1; }
	| print_stmt { $$ = $1; }
	| if_stmt { $$ = $1; }
	| while_stmt { $$ = $1; }
	| func_call { $$ = $1; }	
	;

assign_stmt	: SET ID to expr EOL { $2 = $4; $$ = $2;  }
		| SET ID to func_call EOL { $2 = $3; $$ = $2; }
		;

print_stmt	: PRINT expr EOL { $$ = $2; printf(""); }
		;
if_stmt	: IF expr THEN stmt_list ENDIF { $$ = $4; }
	| IF expr THEN stmt_list ELSE stmt_list ENDIF { $$ =$4 };
	;
while_stmt	: WHILE expr DO stmt_list ENDWHILE { $$ = $2; }
		;
func_decl	: FUNC ID LP param_list RP LM fstmt_list RETURN expr EOL RM func_decl { $$ = $9; }
		| FUNC ID LP param_list RP LM fstmt_list RETURN func_call EOL RM func_decl { $$ = $9; }
		| epsilon { $$ = $1; }
		;
fstmt_list	: fstmt_list fstmt { $$ = $2; }
		| fstmt { $$ = $1; }
		;
fstmt	: assign_stmt { $$ = $1; }
	| print_stmt { $$ = $1; }
	| if_stmt { $$ = $1; }
	| while_stmt { $$ = $1; }
	;
param_list	: ID ID_list { $$ = $1; }
ID_list	: COMMA ID ID_list { $$ = $2; }
	| epsilon { $$ = $1; }
	;
func_call	: ID LP arg_list RP { $$ = $3; }
		;
arg_list	: expr expr_list { $$ = $1; }
		;
expr_list	: COMMA expr expr_list { $$ = $2; }
		| epsilon
		;
expr	: LP expr RP { $$ = $2; }
	| PLUS expr expr { $$ = $2 + $3; }
	| MINUS expr expr { $$ = $2 - $3; }
	| MULT expr expr { $$ = $2 * $3; }
	| DIV expr expr { $$ = $2 / $3; }
	| RBIG expr expr { $$ = 1; }
	| LBIG expr expr { $$ = 1; }
	| REB expr expr { $$ = 1; }
	| LEB expr expr { $$ = 1; }
	| EQUAL expr expr { $$ = 1; }
	| NEQUAL expr expr { $$ = 1; }
	| NEG expr { $$ = 0.0 - $2; }
	| NUMBER { $$ = $1; }
	| ID { $$ = $1; }
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


