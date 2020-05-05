package main

import "fmt"

func main() {
	function1()
	f()
}

func f() {
	for i := 0; i < 5; i++ {
		defer fmt.Printf("%d, ", i)
		// like a stack:q
	}
}

func function1() {
	fmt.Printf("In function at the top\n")
	defer function2()
	fmt.Printf("In function at the bottom\n")
}

func function2() {
	fmt.Printf("Function2: deferred untill the end of function1")
}
