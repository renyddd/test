#include <stdio.h>
#include <string.h>
#include <stdlib.h>
char *reset()
{
    char *name;
    name = (char *)malloc(100);
    strcpy(name, "hello world\n");

    return name;
}

void accessm(char *name)
{
    printf("%s\n", name);
}

int main()
{
    char * name2;
    name2 = reset();

    accessm(name2);
    free(name2);
    return 0;
}
