#include <stdio.h>

int main(int argc, char **argv) {
    for( int ind = 0; ind < argc; ind++ ) {
        printf("%s ", argv[ind]);
    }
    printf("\n");

    return 0;
}
