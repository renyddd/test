cmake_minimum_required(VERSION 3.15)
project(CLion_project)

set(CMAKE_CXX_STANDARD 14)

add_executable(CLion_project main.cpp ref_test.cpp some_types.h Singleton.cpp Singleton.h)