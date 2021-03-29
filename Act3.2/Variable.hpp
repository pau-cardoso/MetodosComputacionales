#ifndef VARIABLE_H
#define VARIABLE_H

#include <iostream>
#include <string>

using namespace std;

class Variable {
	private:
		int state;
	
	public:
		void stateA(char);
		void stateB(char);
		int processEntry(string);
};

void Variable :: stateA(char c) {
	if ( isalpha(c) ) {
		state = STATE_B;
	}
	else state = -1;
}

void Variable :: stateB(char c) {
	if ( isalpha(c) ) {
		state = STATE_B;
	}
	else if ( isdigit(c) ) {
		state = STATE_B;
	}
    else if (c == '_') {
        state = STATE_B;
    }
	else state = -2;
}

int Variable :: processEntry(string str) {
	char c;
	int i;

	i = STATE_A;
	state = 0;

	while ( i < str.length() && state != -1 && state != -2 ) {
		c = str[i];
		if (c=='\n') break;
		//cout << "state = " << state << " c = ." << c << " \n";
		switch (state) {
			case STATE_A: stateA(c); break;
			case STATE_B: stateB(c); break;
		}
		i++;
	}

	switch(state) {
		case STATE_B  : return i-1; break;
		case -2 : return i-2; break;
		default: return -1; break;
	}
}

#endif

// int main(int argc, char* argv[]) {
// 	Variable comment;
// 	string input;
// 	cout << "Input: ";
// 	getline(cin, input);
// 	cout << comment.processEntry(input) << endl;
// }