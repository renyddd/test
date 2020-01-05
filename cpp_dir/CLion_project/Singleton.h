//
// Created by renyddd on 2020/1/5.
//

#ifndef CLION_PROJECT_SINGLETON_H
#define CLION_PROJECT_SINGLETON_H


#include <iostream>

class Singleton {
private:
    static Singleton* Instance;
    Singleton() {}

public:
    static Singleton* Create()
    {
        if ( !Instance )
            Instance = new Singleton();

        std::cout << "Hello world" << std::endl;
        return Instance;
    }
};

#endif //CLION_PROJECT_SINGLETON_H
