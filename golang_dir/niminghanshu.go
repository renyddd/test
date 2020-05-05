package main

import "fmt"

func main() {

	func() {
		sum := 0
		for i := 1; i < 1e6; i++ {
			sum += i
		}
		fmt.Println(sum)
	}() // this is calling.

	f()

	func(s string) {
		fmt.Println(s)
	}("hello, world")
}

func f() {
	for i := 0; i < 5; i++ {
		g := func(i int) { fmt.Printf("%d ", i) }
		g(i)
		fmt.Printf(" - g is of type %T and has value %v\n", g, g)
	}
}
