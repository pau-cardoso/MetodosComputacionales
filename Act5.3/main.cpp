/**
 * @readFile main.cpp
 * @author your name (you@domain.com)
 * @brief 
 * @version 0.1
 * @date 2021-06-06
 * 
 * @copyright Copyright (c) 2021
 * 
 */

#include <iostream>
#include <string>
#include <fstream>
#include <pthread.h>
#include <iostream>
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <time.h>
#include <sys/time.h>
#include <sys/types.h>


const int STATE_A = 0;
const int STATE_B = 1;
const int STATE_C = 2;
const int STATE_D = 3;
const int STATE_E = 4;
const int STATE_F = 5;
const int STATE_G = 6;
const int STATE_H = 7;
const int STATE_I = 8;

#include "Comentario.hpp"
#include "Entero.hpp"
#include "Reales.hpp"
#include "Variable.hpp"
#include "String.hpp"
#include "PalabraReservada.hpp"
#include "utils.h"

#define THREADS 8

using namespace std;

string writeTag(string type, string text) {
	return "<span class='" + type + "'>" +text+ "</span>";
}

void* lexerAritmetico(string archivo, int start, int limit) {
	string c, str, substring, textoHTML;
	Comentario comentario;
	String tipoString;
	Entero entero; 
	Reales real;
	Variable variable;
	PalabraReservada palabraReservada;

	ifstream readFile;
	ofstream writeFile;
	readFile.open(archivo);
	writeFile.open("index.html",ios_base::app);
	writeFile << "<!DOCTYPE html> <html lang='en'> <head> <meta charset='UTF-8'> <meta http-equiv='X-UA-Compatible' content='IE=edge'> <meta name='viewport' content='width=device-width, initial-scale=1.0'> <title>Actividad 3.4 Paulina</title> <link rel='stylesheet' href='styles.css'> </head> <body>" << endl;
	
	
	int cont = 0;
	while( getline(readFile, str) ){
		cout << "entre a la funcion" <<endl;
		cout << str << endl;
		if(cont >= start and cont <= limit){
			writeFile << "<br>";
			for (int i = 0; i < str.length(); i++)
			{
				c = str[i];
				substring = str.substr(i);
				if (c == " ") {
					writeFile << " ";
				}
				else if (c == "\t") {
					writeFile << "&nbsp;&nbsp;&nbsp;&nbsp";
				}
				else if (tipoString.processEntry(substring) != -1) {
					writeFile << writeTag("string", substring.substr(0, tipoString.processEntry(substring) + 1));
					i += tipoString.processEntry(substring);
				}
				else if (comentario.processEntry(substring) != -1) {
					writeFile << writeTag("comentario",substring);
					i += comentario.processEntry(substring);
				}
				else if (palabraReservada.processEntry(substring) != -1) {
					writeFile << writeTag("palabra-reservada", substring.substr(0, palabraReservada.processEntry(substring) + 1));
					i += palabraReservada.processEntry(substring);
				}
				else if (variable.processEntry(substring) != -1) {
					writeFile << writeTag("variable", substring.substr(0, variable.processEntry(substring)+1));
					i += variable.processEntry(substring);
				}
				else if (real.processEntry(substring) != -1) {
					writeFile << writeTag("real", substring.substr(0, real.processEntry(substring)+1));
					i += real.processEntry(substring);
				}
				else if (entero.processEntry(substring) != -1) {
					writeFile << writeTag("numero", substring.substr(0, entero.processEntry(substring) + 1));
				}
				else if (c == "=") {
					writeFile << writeTag("operadores",c);
				}
				else if (c == "+"){
					writeFile << writeTag("operadores",c);
				}
				else if (c == "*") {
					writeFile << writeTag("operadores",c);
				}
				else if (c == "/"){
					writeFile << writeTag("operadores",c);
				}
				else if (c == "^") {
					writeFile << writeTag("operadores",c);
				}
				else if ( c == "-" && str[i+1]==' ' ){
					writeFile << writeTag("operadores", c);
				}
				else if ( c == "(" ){
					writeFile << writeTag("operadores",c);
				}
				else if ( c == ")" ){
					writeFile << writeTag("operadores",c);
				}
				else if (c == "'")
				{
					writeFile << writeTag("operadores", c);
				}
				else if ( c == "," ){
					writeFile << writeTag("operadores",c);
				}
				else if ( c == "#" ){
					writeFile << writeTag("operadores",c);
				}
				else if ( c == ";" ){
					writeFile << writeTag("operadores",c);
				}
				else if (c == "{"){
					writeFile << writeTag("operadores", c);
				}
				else if ( c == "}" ){
					writeFile << writeTag("operadores",c);
				}
				else if (c == "["){
					writeFile << writeTag("operadores", c);
				}
				else if ( c == "]" ){
					writeFile << writeTag("operadores",c);
				}
				else if ( c == "<" ){
					writeFile << writeTag("operadores",c);
				}
				else if (c == ">"){
					writeFile << writeTag("operadores", c);
				}
				else continue;
			}
		}
		cont++;
	}
}

/*************************************************************
* Concurrent implementation
*************************************************************/
typedef struct{
  int start, limit;
  string file;
} Block;


// void* task(void* param){
//     Block *block;
//     block = (Block *) param;
//     return ((void*)lexerAritmetico(block->file, block->start, block->limit));
// }

// void* task(void* param){
//     Block *block;
//     block = (Block *) param;
// 	return ((void *)static_cast<std::string*>(&lexerAritmetico(block->file, block->start, block->limit)));
// }


// str task(void *param){
// 	Block *block;
// 	block = (Block *)param;
// 	return ((string)lexerAritmetico(block->file, block->start, block->limit));
// }


int main(int argc, char* argv[]) {
	string input, line, result = "<!DOCTYPE html> <html lang='en'> <head> <meta charset='UTF-8'> <meta http-equiv='X-UA-Compatible' content='IE=edge'> <meta name='viewport' content='width=device-width, initial-scale=1.0'> <title>Actividad 3.4 Paulina</title> <link rel='stylesheet' href='styles.css'> </head> <body>", text = "<!DOCTYPE html> <html lang='en'> <head> <meta charset='UTF-8'> <meta http-equiv='X-UA-Compatible' content='IE=edge'> <meta name='viewport' content='width=device-width, initial-scale=1.0'> <title>Actividad 3.4 Paulina</title> <link rel='stylesheet' href='styles.css'> </head> <body>";
	int numberLines;
	long int results[THREADS];
	double seq, parallel;
	
	cout << "Nombre del archivo: ";
	cin >> input;

	ifstream file;
	file.open(input);
	while (getline(file, line)){
		++numberLines;
	}


	// Block blocks[THREADS];
	// pthread_t threads[THREADS];
	// long jump = numberLines / THREADS;
	// for (int i = 0; i < THREADS; i++)
	// {
	// 	blocks[i].start = i * jump;
	// 	blocks[i].limit = (i + 1) * jump;
	// 	blocks[i].file = input;
	// }

	// for (int i = 0; i <= THREADS; i++)
	// {
	// 	pthread_create(&threads[i],NULL, task,(void*) &blocks[i]);
	// }
	// for (int i = 0; i < THREADS; i++){
	// 	pthread_join(threads[i], (void **)&results[i]);
	// 	text += results[i];
	// }

	/*************************************************************
	* Implementacion Secuencial
	*************************************************************/
	cout << "Running sequential code..." << endl;
	start_timer();
	lexerAritmetico(input,0,numberLines-1);
	seq = stop_timer();
	printf("\tTiempo en secuencial = %lf \n",seq);
}