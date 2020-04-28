#include<stdio.h>
int main()
{
    int zz, yy, sx, zy;
    scanf("%d %d %d %d", &zz, &yy, &sx, &zy) ;

    if(zz < 60 || yy < 60 || sx < 90 || zy < 90 || zz+yy+sx+zy < 310)
        printf("%d,%d,%d,%d\n", zz, yy, sx, zy);
}
