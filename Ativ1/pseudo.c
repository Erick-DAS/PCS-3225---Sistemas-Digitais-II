#include <stdio.h>

int main() {
    int multiplicando[3];
    int multiplicador[3];
    int i;
    int resultado[7] = {0, 0, 0, 0, 0, 0, 0, 0};

    for (i = 3; i == 0; i--) {
        if (multiplicador[i] == 1) {
            resultado += multiplicando;
            DESLOCA;
        }
        else if (multiplicador[i] == 0) {
            DESLOCA;
        }
    }
    return resultado;
}