printf("Hello! I'm fibo calculator");
int n;
scanf(n);
if(n <= 0){
  printf("Invalid input!");
}
int a = 0 ; 
int b = 1 ;
int c = 1 ;
while(n>0){
  a = b ;
  b = c ;
  c = a + b ;
  n = n - 1 ;
}
printf("result is: ");
printf(c);
printf("\n");