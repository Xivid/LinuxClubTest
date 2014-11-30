#include <stdio.h>
char* s = "hello world\n";
int n = 0;
int main(){
	if (n < 12) {
		putchar(s[n++]);
		main();
	}
	return 0;
}
