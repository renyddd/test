#include <iostream>
#include <string>

int main()
{
    using namespace std;
    string str;

    cout << "Before your typing, the length of the var is: " << str.size() << endl <<endl;
    cout << "Please type your name: ";
    cin >> str;
    cout << "Hello, " << str << endl << endl;

    int namelen = str.size();

    cout << "and the len of your name is: " << namelen << endl;

    return 0;
}
