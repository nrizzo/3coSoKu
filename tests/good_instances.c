/* 
 * Little program to print all IcoSoKu instances such that:
 *  - capacity of vertex A is 1;
 *  - capacity of vertex B is less than the capacities of vertices C, D, E, and
 *    F;
 *  - the instance is lexicographically smaller than its mirrored counterpart.
 *
 *  ~ Nicola Rizzo and Agostino Dovier
 */

#include <stdio.h>

int temp[11]; /* capacities of vertices B to L */
int i = 0; /* backtracking depth */
char selected[11] = { 0 }; /* backtracking mask */

void rec()
{
    if (i == 11 && temp[0] < temp[1] && temp[0] < temp[2] && temp[0] < temp[3] && temp[0] < temp[4]) {
        if (temp[1] < temp[4]) { /* simmetry check */
            printf("1");
            for (int j = 0; j < 11; j++)
             printf(" %d", temp[j]);
            printf("\n");
        }
    } else {
        for (int j = 10; j >= 0; j--) {
            if (selected[j] == 0) {
                selected[j] = 1;
                temp[i] = j + 2;
                i = i + 1;
                rec();
                i = i - 1;
                selected[j] = 0;
            }
        }
    }
}

int main()
{
    rec();
}
