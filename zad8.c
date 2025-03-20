#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int czy3cw(int x, int y) {
    if(x<0 && y<0) return 1;
    else return 0;
}
int main() {
    int n=0,x=0,y=0,result=0;
    printf("Podaj liczbe punktow do sprawdzenia ");
    scanf("%i",&n);
    for(int i=0;i<n;i++)
    {
        printf("podaj x: ");
        scanf("%i",&x);
        printf("podaj y: ");
        scanf("%i",&y);
        result+=czy3cw(x,y);
    }
    printf("\n%i punktow z %i nalezy do 3 cwiartki", result, n);
    return EXIT_SUCCESS;
}
