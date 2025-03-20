#include<stdio.h>
#include<stdlib.h>
#include<math.h>

long silnia(int n){
    if (!n) return 1;
    long result=1;
    for(int i=n;i>1;i--)
    {
        result=result*i;
    }
    return result;
}

float myExp(double x, float eps) {
    int i=0;
    float temp=x;
    float result=0;
    while(temp > eps) {
        //i++;
        temp=pow(x,i)/(float)silnia(i);
        //i?(temp=temp*x/(float)i):(temp=temp*x);
        //temp=temp*x/(float)silnia(i);
        result+=temp;
        //printf("%ld\n",silnia(i));
        i++;
    }
    return result;
}

int main()
{
    printf("%f",myExp(8,0.00001));
    //printf("%i",silnia(3));
    return 1;
};
