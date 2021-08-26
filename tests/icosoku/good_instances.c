/* 
 * little program to print all IcoSoKu instances such that:
 *  - capacity of vertex A is 1;
 *  - capacity of vertex B is less than the capacities of vertices C, D, E, and
 *	F;
 *  - the instance is lexicographically smaller than its mirrored counterpart
 *  ~ Nicola Rizzo and Agostino Dovier
 */

#include <stdio.h>
#define UNUSED 0
#define USED 1

int capacity[11]; /* capacities of vertices B to L */
int i = 0; /* backtracking depth */
char selected[11] = { UNUSED }; /* bitmask tracking the integers used */

void rec()
{
	// if all capacities have been filled
	if (i == 11) {
		// vertex B check
		if (capacity[0] < capacity[1] && capacity[0] < capacity[2] &&
		    capacity[0] < capacity[3] && capacity[0] < capacity[4]) {
			// symmetry check
			if (capacity[1] < capacity[4]) {
				// print the capacities
				printf("1");
				for (int j = 0; j < 11; j++)
					printf(" %d", capacity[j]);
				printf("\n");
			}
		}
		return;
	}
	// otherwise recursively fill all empty spots with unused capacities
	for (int j = 0; j <= 10; j++) {
		if (selected[j] == UNUSED) {
			selected[j] = USED;
			capacity[i] = j + 2;

			i = i + 1;
			rec();
			i = i - 1;

			selected[j] = UNUSED;
		}
	}
}

int main()
{
	rec();
}
