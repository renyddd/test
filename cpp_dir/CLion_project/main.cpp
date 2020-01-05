#include <iostream>
#include "some_types.h"
#define LOG(x) std::cout << x << std::endl

void add_x(int& ref);

int main() {

    // if you want to call the function which is in another file,
    // you just need to declaration it.
    void test_name();
    test_name();


    /*
    int x = 5;
    LOG(x);

    add_x(x);
    LOG(x);

    Example value;
    value = C;
    LOG(value); */
    return 0;
}
