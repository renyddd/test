package main

import "fmt"

func trace(s string) string {
	fmt.Println("entering: ", s)
	return s
}

func untrace(s string) {
	fmt.Println("leaving: ", s)
	// test
	fmt.Println("if this print before leaving??")
}

func f1() {
	defer untrace(trace("f1"))
	fmt.Println("this is in f1.")
}

func main() {
	f1()
}
