#include <iostream>
#include <string>

using namespace std;

class Entero {
	private:
		int state;
	
	public:
		void state0(char);
		void state1(char);
		void state2(char);
		void processEntry(string);
};

void Entero :: state0(char c) {
	if (c == '-') {
		state = 1;
	}
	else if ( isdigit(c) ) {
		state = 2;
	}
	else state = -1;
}

void Entero :: state1(char c) {
	if ( isdigit(c) ) {
		state = 2;
	}
	else state = -1;
}

void Entero :: state2(char c) {
	if ( isdigit(c) ) {
		state = 2;
	}
	else state = -1;
}

void Entero :: processEntry(string str) {
	char c;
	int i;

	i = 0;
	state = 0;

	while ( i < str.length() && state != -1 ) {
		c = str[i];
		if (c=='\n') break;
		cout << "state = " << state << " c = ." << c << " \n";
		switch (state) {
			case 0: state0(c); break;
			case 1: state1(c); break;
			case 2: state2(c); break;
		}
		i++;
	}

	switch(state) {
		case -1 : cout << "NOT ACCEPTED\n"; break;
		case 2  : cout << "ACCEPTED\n"; break;
	}
}

int main(int argc, char* argv[]) {
	Entero comment;
	string input;
	cout << "Input: ";
	getline(cin, input);
	comment.processEntry(input);
}