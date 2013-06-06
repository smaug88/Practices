//============================================================================
// Name        : Practica2.cpp
// Author      :
// Version     :
// Copyright   : Your copyright notice
// Description : Hello World in C++, Ansi-style
//============================================================================

#include <signal.h>
#include <iostream>
#include <stdio.h>
#include <sys/wait.h>
#include <semaphore.h>

using namespace std;
bool alarma = false;
sem_t semaforo;

void setAlarm(int)
{
	alarma = true;
	alarm(0);
	alarm(4);
}

int main()
{
	sem_init(&semaforo, 0, 1);
	alarm(4);
	signal(14, setAlarm);
	while(true)
	{
		sem_wait(&semaforo);
		printf(" ");
		sem_post(&semaforo);
		if(alarma)
		{
			alarma = false;
			if(fork()!=0)
			{
				waitpid(0, NULL, WNOHANG);
				sleep(1);
			}
			else
			{
				char* args[] = {""};
				sem_wait(&semaforo);
				printf("\n");
				sem_post(&semaforo);
				execv("/bin/date", args);
			}
		}
	}
	return 0;
}
