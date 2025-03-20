#include <stdio.h>
#include <stdlib.h>
#include <math.h>

float a(int k) {
    return  2.*(k+1.)*(k+2.)/(3.*k);
};
float na(int n) {
    float result=0;
    for (int i=1;i<=n;i++) result+=a(i);
    return result;
};
float pa(int n) {
    float result=0;
    for (int i=2;i<=n;i+=2) result+=a(i);
    return result;
};

int main() {
    printf("%f",pa(4));
    return EXIT_SUCCESS;
};
