%{#include <stdio.h>
#include <stdlib.h>

#include <string.h>
extern int yylex();
void yyerror(char *msg) ;
int temp_reg_num = 1;
char* explain_expr(char* text, char *oper, char* text1);
char* concatenate(char* text);

    %}
%union{
    char* translate;
    char* translate_op;
    struct { int flag; char * explain; } node;
}
%token<translate_op>    Min Mul Plu Div RP LP
%token<translate> NUM
%type<node> Stmt Expr Term Factor 


%%
Stmt  :Expr             {$$.flag=$1.flag;$$.explain = $1.explain;
                        if($1.flag){$$.explain = concatenate($1.explain);printf("Print %s",$$.explain);}else{ printf("Print %s",$1.explain);}}
      ;

Expr  :Expr Plu Term    {$$.flag=0;$$.explain =explain_expr($1.explain ,$2,$3.explain);}
      |Expr Min Term    {$$.flag=0;$$.explain =explain_expr( $1.explain , $2, $3.explain);}
      |Term             {$$.flag=$1.flag;strcpy( $$.explain ,$1.explain) ;}
      ;
    
Term  :Term Mul Factor  {$$.flag=0;$$.explain =explain_expr( $1.explain ,$2, $3.explain);}
      |Term Div Factor  {$$.flag=0;$$.explain =explain_expr( $1.explain ,$2 ,$3.explain);}
      |Factor           {$$.flag=$1.flag;strcpy( $$.explain ,$1.explain) ; }
      ;
     
Factor: LP Expr RP      {$$.flag=$2.flag;$$.explain =$2.explain;}
      |NUM              {$$.flag=1;$$.explain =malloc(100);strcpy( $$.explain ,$1) ;}
      ;



%%
void yyerror(char *msg)  {
    fprintf(stderr,"%s\n",msg);
    exit(1);
}
int main(){
    yyparse();
    return 0;
}
char* concatenate(char* text) {
        char* temp = malloc(8);
        snprintf(temp, 7, "t%d", temp_reg_num++);
        printf("Assign %s to %s\n", text,temp);
        
        return temp;
    }

char* explain_expr(char* text, char *oper, char* text1) {
        char* temp = malloc(8);
        snprintf(temp, 7, "t%d", temp_reg_num++);
        printf("Assign %s %s %s to %s\n", text, oper, text1,temp);
        
        return temp;
    }



