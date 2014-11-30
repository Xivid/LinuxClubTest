#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <unistd.h>
#include <signal.h>
#include <sys/param.h>
#include <sys/types.h>
#include <sys/stat.h>

void init_daemon()
{
    int pid;
    int i;
    if(pid = fork())
        exit(0);        //是父进程，结束父进程
    else if(pid < 0)
        exit(1);        //fork失败，退出
    //是第一子进程，后台继续执行
    setsid();           //第一子进程成为新的会话组长和进程组长
    //并与控制终端分离
    if(pid = fork())
        exit(0);        //是第一子进程，结束第一子进程
    else if(pid < 0)
        exit(1);        //fork失败，退出
    //是第二子进程，继续
    //第二子进程不再是会话组长
    for(i=0; i < NOFILE; ++i)  //关闭打开的文件描述符
        close(i);

    chdir("~/");      //改变工作目录到/tmp
    umask(0);           //重设文件创建掩模
}

int main()
{
    FILE *fp, *fin;
    time_t t;
    char c;
    init_daemon();//初始化为Daemon
    while(1)//每隔15s向~/daemon_log.txt报告状态
    {
        sleep(2);
        if((fp=fopen("daemon_log.txt","a")) >= 0 && (fin=fopen("/proc/stat", "r")) >= 0){
            time(&t);
            fprintf(fp,"Now: %s", ctime(&t));
            while((c = fgetc(fin)) != EOF) fputc(c, fp);
            fputc('\n', fp);
            fclose(fin);
            fclose(fp);
        }
    }
    return 0;
}
