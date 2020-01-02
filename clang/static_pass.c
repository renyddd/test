#include <stdio.h>
#include <string.h>
#include <stdlib.h>

char *name;

char *setName()
{
    char *p = "hello world\n";
    name = p;
    return name;
}

void print_name()
{
    printf("%s\n", name);
}

int main()
{
    char *p = setName();

    print_name();
    printf("in main(): %s\n", name);

    return 0;
}
