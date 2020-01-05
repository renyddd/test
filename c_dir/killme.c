#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>

int main()
{
    int i = 1;
    while( i++ < 100)
    {
        sleep(1);
        printf("hello world\n");

        if ( i == 5)
            system("killall killme");
    }

    return 0;
}
