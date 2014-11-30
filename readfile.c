#include <stdio.h>
#include <unistd.h>
int main()
{
        int pid;
	FILE *fp;
	char c;
        pid=fork();
        if(pid==0) 
	{
		fp = fopen("date.c", "r");
		printf("date.c:\n");
		while((c = fgetc(fp)) != EOF) putchar(c);
		putchar('\n');	
        } 
        else
        {
                printf("Subprocess1 PID: %d\n",pid);
                pid=fork();
                if(pid==0)
		{
			printf("mem.c:\n");
			fp = fopen("mem.c", "r");
			while((c = fgetc(fp)) != EOF) putchar(c);
			putchar('\n');
		}
                else
                	printf("Subprocess2 PID: %d\n",pid);
        }
	return 0;
}
