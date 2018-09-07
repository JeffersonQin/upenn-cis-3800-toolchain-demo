#include <stdio.h>
#include <stdlib.h>
#include <sys/wait.h>
#include <unistd.h>

int myFunction(int b)
{
    int a = 200;
    return a + b;
}

void leak()
{
    char* arr = malloc(sizeof(char) * 100);
    arr[5] = 'a';
    printf("The character is %c\n", arr[5]);
}

void useAfterFree()
{
    char* ptr = (char*)malloc(sizeof(char) * 10);
    for (int i = 0; i < 9; i++)
        ptr[i] = '0' + i;
    ptr[9] = '\0';

    if (1)         // imagine an error occured here
        free(ptr); // handle error

    printf("the string is%s\n", ptr);
}

void fork_example()
{
    int pid = fork();
    if (pid == 0)
    { // child
        printf("I am in the child\n");
        exit(0);
    }
    // implicitly parent
    int return_status;
    wait(&return_status);
    printf("I am the parent\n");
}

void segf()
{
    int* p = NULL;
    int* pp = (int*)malloc(sizeof(int));
    int res = *pp + *p;
    free(pp);
    printf("Res is %d\n", res);
}

int main(int argc, char* argv[])
{
    if (argc != 2) exit(1);
    switch (argv[1][0])
    {
    case 'm':
        printf("The result of the fucntion is %d\n", myFunction(5));
        break;
    case 'l':
        leak();
        break;
    case 'u':
        useAfterFree();
        break;
    case 'f':
        fork_example();
        break;
    case 's':
        segf();
        break;
    }
    return 0;
}
