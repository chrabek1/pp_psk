#include <stdlib.h>
#include <stdio.h>
#include <math.h>
float root(float a, float eps) {
    float temp=1,temp2=0;
    while (1) {
        temp2=(temp+a/temp)/2.0;
        //printf("%f\n",temp2);
        if (fabs(temp2-temp)<eps) break;
        temp=temp2;
    }
    return temp2;
};
int main() {
    printf("%f",root(9999,0.001));
    return EXIT_SUCCESS;
}