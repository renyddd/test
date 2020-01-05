//
// Created by renyddd on 2020/1/5.
//

#include "Singleton.h"
#include <cstdio>
#include <iostream>

Singleton* Singleton::Instance = NULL;

void test_name()
{
    Singleton *p;
    p = Singleton::Create();

    std::cout << "Hello world" << std::endl;
}
