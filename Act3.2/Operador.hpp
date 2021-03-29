#ifndef OPERADOR_H
#define OPERADOR_H
#include <string>
#include <iostream>

using namespace std;

class Operador {
	public:
		int processEntry(char);
};

int Operador :: processEntry(char c) {
	switch (c) {
		case '=': 
			cout << c << "\t\t\t\t\t\tAsignacion" << endl;
			return 0; 
			break;
		case '+': 
			cout << c << "\t\t\t\t\t\tSuma" << endl;
			return 0; 
			break;
		case '*': 
			cout << c << "\t\t\t\t\t\tMultiplicacion" << endl;
			return 0; 
			break;
		case '/': 
			cout << c << "\t\t\t\t\t\tDivision" << endl;
			return 0; 
			break;
		case '^': 
			cout << c << "\t\t\t\t\t\tPotencia" << endl;
			return 0; 
			break;
		case '-': 
			cout << c << "\t\t\t\t\t\tResta" << endl;
			return 0; 
			break;
		default : 
			return -1;
			break;
	}
}

#endif