package main

import (
	"fmt"
)

func main() {

	str := "hello, world"
	for pos, char := range str {
		fmt.Printf("%c is in the %d position\n", char, pos)
	}
}
