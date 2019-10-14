#include <stdio.h>
extern struct List v;
extern void Init(struct List * list);
int main(int argc, char *argv[])
{ 
   Init(&v);
   
   FILE* fileInput;
   char inputBuffer[36];
   char lineData[36];
   if((fileInput=fopen(argv[1],"r"))==NULL)
   {
      printf("Error reading files, the program terminates immediately\n");
      exit(0);
   }
   
   parse(fileInput);
   

   return 0;
}
