#include <iostream>
#include <string>

using namespace std;

const int STATE_A = 0;
const int STATE_B = 1;
const int STATE_C = 2;
const int STATE_D = 3;
const int STATE_E = 4;
const int STATE_F = 5;
const int STATE_G = 6;
const int STATE_H = 7;
const int STATE_I = 8;

class Reales {
	private:
		int state;
	
	public:
		void stateA(char);
		void stateB(char);
		void stateC(char);
		void stateD(char);
		void stateE(char);
		void stateF(char);
		void stateG(char);
		void stateH(char);
		void stateI(char);
		void processEntry(string);
};

void Reales :: stateA(char c) {
	if (c == '-') {
		state = STATE_C;
	} 
	else if (isdigit(c)) {
		state = STATE_B;
	}
	else if (c == '.') {
		state = STATE_D;
	}
	else state = -1;
}

void Reales :: stateB(char c) {
	if ( isdigit(c) ) {
		state = STATE_B;
	}
	else if (c == '.') {
		state = STATE_E;
	}
	else state = -1;
}

void Reales :: stateC(char c) {
	if ( isdigit(c) ) {
		state = STATE_B;
	}
	else if (c == '.') {
		state = STATE_D;
	}
	else state = -1;
}

void Reales :: stateD(char c) {
	if ( isdigit(c) ) {
		state = STATE_F;
	}
	else state = -1;
}

void Reales :: stateE(char c) {
	if ( isdigit(c) ) {
		state = STATE_F;
	}
	else state = -1;
}

void Reales :: stateF(char c) {
	if ( isdigit(c) ) {
		state = STATE_F;
	}
	else if (c == 'E') {
		state = STATE_G;
	}
	else if (c == 'e') {
		state = STATE_G;
	}
	else state = -1;
}

void Reales :: stateG(char c) {
	if (c == '-') {
		state = STATE_I;
	}
	else if ( isdigit(c) ) {
		state = STATE_H;
	} 
	else state = -1;
}

void Reales :: stateH(char c) {
	if ( isdigit(c) ) {
		state = STATE_H;
	}
	else state = -1;
}

void Reales :: stateI(char c) {
	if ( isdigit(c) ) {
		state = STATE_H;
	}
	else state = -1;
}

void Reales :: processEntry(string str) {
	char c;
	int i;

	i = 0;
	state = STATE_A;  

	while ( i < str.length() && state != -1 ) {
		c = str[i];
		if (c=='\n') break;
		cout << "state = " << state << " c = ." << c << " \n";
		switch (state) {
			case STATE_A: stateA(c); break;
			case STATE_B: stateB(c); break;
			case STATE_C: stateC(c); break;
			case STATE_D: stateD(c); break;
			case STATE_E: stateE(c); break;
			case STATE_F: stateF(c); break;
			case STATE_G: stateG(c); break;
			case STATE_H: stateH(c); break;
			case STATE_I: stateI(c); break;
		}
		i++;
	}

	switch(state) {
		case -1 : cout << "NOT ACCEPTED\n"; break;
		case STATE_E : cout << "ACCEPTED\n"; break;
		case STATE_F : cout << "ACCEPTED\n"; break;
		case STATE_H : cout << "ACCEPTED\n"; break;
	}
}

int main(int argc, char* argv[]) {
	Reales comment;
	string input;
	cout << "Input: ";
	getline(cin, input);
	comment.processEntry(input);
}