#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <string.h>
#include <errno.h>
#include <stdlib.h>
#include <stdio.h>
#include <fcntl.h>

void set_fl(int fd, int flag)
{
    int val;

    //获得原来的文件状态标志
    val = fcntl(fd, F_GETFL);
    if(val < 0) {
        perror("fcntl error");
    }

    //增加新的文件状态标志
    val |= flag;

    //重新设置文件状态标志(val 为新的文件状态标志)
    if(fcntl(fd, F_SETFL, val) < 0) {
        perror("fcntl error");
    }
}

int main(int argc, char *argv[])
{
    if(argc < 3) {
        fprintf(stderr, "usage: %s content destfile\n", argv[0]);
        exit(1);
    }

    int fd;
    int ret;
    size_t size;

    fd = open(argv[2], O_CREAT|O_WRONLY);

    //设置追加的文件状态标志
    set_fl(fd, O_APPEND);

    //定位到文件尾部
    ret = lseek(fd, 0L, SEEK_END);
    if(ret == -1) {
        perror("lseek error");
        close(fd);
        exit(1);
    }
   
    sleep(5); //睡眠 10s

    //往文件中追加内容
    size = strlen(argv[1]) * sizeof(char);
    write(fd, "\n", sizeof("\n"));
    if(write(fd, argv[1], size) != size) {
        perror("write error");
        close(fd);
        exit(1);
    }
     
    //读取文件内容
    if( (fd = open(argv[2], O_RDONLY|O_CREAT, 0644)) >= 0 )
       printf("Open success\n");
   else
   {
       printf("Open failed!\n");
       exit(1);
   }

   char s[100];
   printf("file context:\n\n\n\n");
   
   read(fd, s, sizeof(s));

   printf("%s", s);

   if(! close(fd) )
       printf("\nClosed the file.\n");
   else
   {
       printf("Closed failed!\n");
       exit(1);
   }

    return 0;
    
}
