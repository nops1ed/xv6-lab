#include "user/user.h"

//remain old C style

int
main (int argc , char *argv[])
{
	if (argc != 1)
	{
		printf("Too Much arguments\n");
		exit(1);
	}
//Here we allocate arrays to hold pipe fd
	//pipe from parent to child
	int *p1 = (int *)malloc(sizeof(int) * 2);
	//pipe from child to parent
	int *p2 = (int *)malloc(sizeof(int) * 2);
	char c;
	pipe(p1);
	pipe(p2);
	if (fork() == 0)
	{
		//parent should bind its output stream to  pipe_1
		read (p1[0] , c , 1);
		printf ("%d: received ping\n" , getpid());
		write (p2[1] , 'a' , 1);
		exit(0);
	}
	else {
		write (p1[1] , 'a' , 1);
		read(p2[0] , c , 1);
		printf ("%d: recevied pong\n" , getpid());
	}
	return 0;
}
