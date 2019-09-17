#include "ExtendableArray.h"
#include <iostream>
using namespace std;

void stuff_20(ExtendableArray arr) {
	for (int i = 0; i < 20; i++) {
		arr[i] = i;
	}
	cout << arr; // 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19
	cout << endl;
}
int main() {
	ExtendableArray a1;
	for (int i = 0; i < 20; i++)
	{
		a1[i] = i;
	}
	cout << a1; //0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19
	cout << endl;
	if (1) {
		ExtendableArray a2;
		for (int i = 0; i<10; i++)
			a2[i + 5] = a1[i];
		cout << a2; //0 0 0 0 0 0 1 2 3 4 5 6 7 8 9
		cout << endl;
		a1 = a2;
		for (int i = 0; i<10; i++)
			a2[i] = i;
		cout << a1; //0 0 0 0 0 0 1 2 3 4 5 6 7 8 9
		cout << endl;
		cout << a2; //012345678956789
		cout << endl;
	}
	cout << a1; //0 0 0 0 0 0 1 2 3 4 5 6 7 8 9
	cout << endl;

	ExtendableArray a3;
	a3[0] = 1;
	cout << a3 << endl; // 1 0
	stuff_20(a3);
	cout << a3 << endl; // 1 0
	cout << a3[2147483647] << endl; // 0

	return 0;
}
