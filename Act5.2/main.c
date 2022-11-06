/**
 * @file main.c
 * @author Paulina Cardoso Fuentes - A01701490
 * @author Paola Adriana Millares Forno - A01705674
 * @brief Programa que calcula la suma de todos los ńumeros primos menores a 5,000,000 
 * 			con implementacion secuencial y paralela
 * @version 0.1
 * @date 2021-05-30
 * 
 * @copyright Copyright (c) 2021
 * 
 */

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <pthread.h>
#include <unistd.h>
#include <stdbool.h>
#include <math.h>
#include "utils.h"

#define THREADS 8
#define LIMIT 5000000

/*************************************************************
* Sequential implementation
*************************************************************/
bool esPrimo(int n) {
	if (n < 2)
		return false;  
	for (int i = 2; i <= sqrt(n); i++) {
		if (n % i == 0)
			return false;
	}
	return true;
}

long int sumaPrimos(int start, int limit){
  long int acum = 0;
  for (int i = start; i <= limit; i++)
  {
    if (esPrimo(i))
      acum += i;
  }
  return acum;
}

/*************************************************************
* Concurrent implementation
*************************************************************/
typedef struct{
  int start, limit;
} Block;

void* task(void* param){
    Block *block;
    block = (Block *) param;
    return ((void*)sumaPrimos(block->start, block->limit));
}


/*************************************************************
* Main
*************************************************************/
int main(int argc, char *argv[]){
	double result, seq, parallel;
	Block blocks[THREADS];
	long int results[THREADS], acum = 0;
	pthread_t tids[THREADS];


	/*************************************************************
	* Implementacion Secuencial
	*************************************************************/
	printf("Running sequential code..\n");
	start_timer();
	result = sumaPrimos(1,LIMIT);
	seq = stop_timer();
	printf("\tSuma = %lf \n",result);
	printf("\tTiempo en secuencial = %lf \n",seq);


	/*************************************************************
	* Implementacion Paralela
	*************************************************************/
	printf("\nRunning parallel code..\n");
	int jump = LIMIT/THREADS;

	for (int i = 0; i < THREADS; i++){
		blocks[i].start = i * jump;
		blocks[i].limit = (i + 1) * jump;
	}
	
	start_timer();
	for (int i = 0; i <= THREADS; i++){
		pthread_create(&tids[i], NULL, task, (void *)&blocks[i]);
	}

	for (int i = 0; i < THREADS; i++){
		pthread_join(tids[i], (void **)&results[i]);
		acum += results[i];
	}
	parallel = stop_timer();
	printf("\tSuma = %ld \n",acum);
	printf("\tTiempo en paralelo = %lf \n",parallel);


	/*************************************************************
	* Comparacion
	*************************************************************/
	double speedup = (seq / parallel)*100;
	printf("\nSpeedup = %lf\n", speedup);

	return 0;
}