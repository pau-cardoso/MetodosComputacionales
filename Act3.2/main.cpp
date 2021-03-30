#include <iostream>
#include <string>
#include <fstream>

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

using namespace std;

void lexerAritmetico(string archivo) {
	char c;
	string str;
	string substring;
	Comentario comentario;
	Entero entero; 
	Reales real;
	Variable variable;

	ifstream file;
	file.open(archivo);
	cout << "\nToken\t\t\t\t\t\tTipo" << endl;
	cout << "------------------------------------------------------------------------" << endl;

	while (getline(file, str, '\n')) {
		for (int i = 0; i < str.length(); i++) {
			c = str[i];
			substring = str.substr(i);
			if (c == ' ') {
				continue;
			}
			else if (comentario.processEntry(substring) != -1) {
				cout << substring << "\t\t\tComentario" << endl;
				i += comentario.processEntry(substring);
			}
			else if (variable.processEntry(substring) != -1) {
				cout << substring.substr(0, variable.processEntry(substring)+1) << "\t\t\t\t\t\tVariable" << endl;
				i += variable.processEntry(substring);
			}
			else if (real.processEntry(substring) != -1) {
				cout << substring.substr(0, real.processEntry(substring)+1) << "\t\t\t\t\t\tReal" << endl;
				i += real.processEntry(substring);
			}
			else if (entero.processEntry(substring) != -1) {
				cout << substring.substr(0, entero.processEntry(substring)+1) << "\t\t\t\t\t\tEntero" << endl;
				i += entero.processEntry(substring);
			}
			else if (c == '=') {
				cout << c << "\t\t\t\t\t\tAsignacion" << endl;
			}
			else if (c == '+') {
				cout << c << "\t\t\t\t\t\tSuma" << endl;
			}
			else if (c == '*') {
				cout << c << "\t\t\t\t\t\tMultiplicacion" << endl;
			}
			else if (c == '/') {
				cout << c << "\t\t\t\t\t\tDivision" << endl;
			}
			else if (c == '^') {
				cout << c << "\t\t\t\t\t\tPotencia" << endl;
			}
			else if ( c == '-' && str[i+1]==' ' ) {
				cout << c << "\t\t\t\t\t\tResta" << endl;
			}
			else if ( c == '(' ) {
				cout << c << "\t\t\t\t\t\tParéntesis que abre" << endl;
			}
			else if ( c == ')' ) {
				cout << c << "\t\t\t\t\t\tParéntesis que cierra" << endl;
			}
			else continue;
			
			cout << "------------------------------------------------------------------------" << endl;
		}
		
	}	
}

int main(int argc, char* argv[]) {
	string input;
	cout << "Nombre del archivo: ";
	cin >> input;
	lexerAritmetico(input);
}