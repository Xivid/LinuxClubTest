#include <stdio.h>
int main(){
	FILE* fp = fopen("/proc/meminfo", "r");
	char c;
	while((c = fgetc(fp)) != EOF) putchar(c);
	return 0;
}
