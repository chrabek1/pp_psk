#include<stdio.h>
#include<stdlib.h>
#include<math.h>
long silnia(int n){
    if (n<2) return 1;
    else return n*silnia(n-1);
}

long komb(int n, int k) {
    return silnia(n)/silnia(k)/silnia(n-k);
};

int main() {
    printf("%li", komb(11,6));
    //printf("%li", silnia(30));
}