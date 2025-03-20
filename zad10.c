#include<stdio.h>
#include<stdlib.h>
#include<math.h>

void pio(float r, float *p, float *v) {
    *p=4*r*r*M_PI;
    *v=4*r*r*r*M_PI/3;
    return;
}
int main(){
    float r=3,p=0,v=0;
    pio(r,&p,&v);
    printf("pole: %f\nobjetosc: %f",p,v);
}