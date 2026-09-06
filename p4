#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <omp.h>

int is_prime(int n)
{
    if (n <= 1) return 0;
    if (n == 2) return 1;
    if (n % 2 == 0) return 0;

    for (int i = 3; i <= sqrt(n); i += 2)
        if (n % i == 0) return 0;

    return 1;
}

int main()
{
    int n;
    printf("Enter the value of n: ");
    scanf("%d", &n);

    int *a = malloc((n + 1) * sizeof(int));
    int *b = malloc((n + 1) * sizeof(int));

    double s = omp_get_wtime();

    for (int i = 1; i <= n; i++)
        a[i] = is_prime(i);

    double e = omp_get_wtime();

    double p = omp_get_wtime();

    #pragma omp parallel for schedule(static)
    for (int i = 1; i <= n; i++)
        b[i] = is_prime(i);

    double q = omp_get_wtime();

    printf("\nPrime numbers from 1 to %d are:\n", n);
    for (int i = 1; i <= n; i++)
        if (b[i]) printf("%d ", i);

    printf("\n\nExecution Time:\n");
    printf("Serial   : %.6f seconds\n", e - s);
    printf("Parallel : %.6f seconds\n", q - p);

    free(a);
    free(b);
    return 0;
}