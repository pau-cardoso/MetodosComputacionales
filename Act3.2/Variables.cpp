#include <iostream>
#include <string>

using namespace std;

class Variable {
	private:
		int state;
	
	public:
		void state0(char);
		void state1(char);
		void processEntry(string);
};

void Variable :: state0(char c) {
	if ( isalpha(c) ) {
		state = 1;
	}
	else state = -1;
}

void Variable :: state1(char c) {
	if ( isalpha(c) ) {
		state = 1;
	}
	else if ( isdigit(c) ) {
		state = 1;
	}
    else if (c == '_') {
        state = 1;
    }
	else state = -1;
}

void Variable :: processEntry(string str) {
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
		}
		i++;
	}

	switch(state) {
		case -1 : cout << "NOT ACCEPTED\n"; break;
		case 1  : cout << "ACCEPTED\n"; break;
	}
}

int main(int argc, char* argv[]) {
	Variable comment;
	string input;
	cout << "Input: ";
	getline(cin, input);
	comment.processEntry(input);
}