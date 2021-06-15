%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "parser.tab.h"
%}


%option noyywrap
    char* ListNum[10] = {"Zer","One","Two","Thr","Fou","Fiv","Six","Sev","Eig","Nin"};

    char* get_translation() {
        char* tostring = malloc(100) ;
        strcpy(tostring,"");
        int len = 0;
        if(yyleng == 1){
            strcat(tostring,ListNum[yytext[0]-'0']);
            tostring[3]=0;
        }
        else if(yyleng == 2){
            strcat(tostring,ListNum[yytext[0]-'0']);
            strcat(tostring,"Ten_");
            strcat(tostring,ListNum[yytext[1]-'0']);         
            tostring[10]=0;
        }
        else if(yyleng == 3){
            strcat(tostring,ListNum[yytext[0]-'0']);
            strcat(tostring,"Hun_");
            strcat(tostring,ListNum[yytext[1]-'0']);     
            strcat(tostring,"Ten_");
            strcat(tostring,ListNum[yytext[2]-'0']);        
            tostring[17]=0;
        }
        else if(yyleng == 4){
            strcat(tostring,"(");  
            strcat(tostring,ListNum[yytext[0]-'0']);
            strcat(tostring,")Tou_");
            strcat(tostring,ListNum[yytext[1]-'0']);
            strcat(tostring,"Hun_");
            strcat(tostring,ListNum[yytext[2]-'0']);
            strcat(tostring,"Ten_");
            strcat(tostring,ListNum[yytext[3]-'0']);    
            tostring[26]=0;
        }
        else if(yyleng == 5){
            strcat(tostring,"(");  
            strcat(tostring,ListNum[yytext[0]-'0']);
            strcat(tostring,"Ten_");
            strcat(tostring,ListNum[yytext[1]-'0']);
            strcat(tostring,")Tou_");
            strcat(tostring,ListNum[yytext[2]-'0']);
            strcat(tostring,"Hun_");
            strcat(tostring,ListNum[yytext[3]-'0']);
            strcat(tostring,"Ten_");
            strcat(tostring,ListNum[yytext[4]-'0']);    
            tostring[33]=0;
        }
        else if(yyleng == 6){
            strcat(tostring,"(");  
            strcat(tostring,ListNum[yytext[0]-'0']);
            strcat(tostring,"Hun_");
            strcat(tostring,ListNum[yytext[1]-'0']);
            strcat(tostring,"Ten_");
            strcat(tostring,ListNum[yytext[2]-'0']);
            strcat(tostring,")Tou_");
            strcat(tostring,ListNum[yytext[3]-'0']);
            strcat(tostring,"Hun_");
            strcat(tostring,ListNum[yytext[4]-'0']);
            strcat(tostring,"Ten_");
            strcat(tostring,ListNum[yytext[5]-'0']);    
            tostring[40]=0;
        }
        return tostring;
        
    }
%%
[0-9]+    {yylval.translate=get_translation();return NUM; }

"*"      {yylval.translate_op="Mul";
            return Mul;}
"-"       {yylval.translate_op="Min";
            return Min;}
"/"      {yylval.translate_op="Div";
            return Div;}
"+"      {yylval.translate_op="Plu";
            return Plu;}
"("       {yylval.translate_op="LP";
            return LP;}
")"       {yylval.translate_op="RP";
            return RP;}        

[\n]            {return 0;}
[\t ]           ;

            
%%