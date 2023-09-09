//Prototype in system calls
//int sleep(int)

#include "user/ulib.c"
#include "user/user.h"

//remain old C style
void
main(int argc , char *argv[])
{
	if (argc < 2)
	{
		printf("NO Arguemnts Given\n");
		exit(1);
	}
	sleep(atoi(argv[1]);
	exit(0);
}

