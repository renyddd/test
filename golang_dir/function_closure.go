package main

import "fmt"

func main() {
	var f = Adder()

}

func Adder() func(int) int {
	var x int
	return func(delta int) int {
		x += delta
		return x
	}
}
