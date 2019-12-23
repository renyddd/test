#include <iostream>
int main()
{
    using namespace std;

    int sum = 8.6 + 1.8;
    
    cout << 8.6 + 1.3 << endl;
    cout << sum << endl;
    cout << int (8.6) + int (1.3) << endl;
    cout << sizeof(sum) << endl;

    
//  _____                    ____          _   
// |_   _|   _ _ __   ___   / ___|__ _ ___| |_ 
//   | || | | | '_ \ / _ \ | |   / _` / __| __|
//   | || |_| | |_) |  __/ | |__| (_| \__ \ |_ 
//   |_| \__, | .__/ \___|  \____\__,_|___/\__|
//       |___/|_|                              
//
    // This form is pure C++.
    cout << sizeof( double(sum) ) << endl;

    // Do not use this, straight C form.
    cout << sizeof( (double) sum) << endl;


    const int Arsize = 20;
    char name[Arsize];
    cout <<" enter your name: "<< endl;
    cin.get(name, Arsize).get();
    cin.get();
    cout << "Hello "<< name << endl;
    cout << "Bye." << endl;


    return 0;
}
