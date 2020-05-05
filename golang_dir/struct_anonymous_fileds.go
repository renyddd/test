package main

import "fmt"

type innerS struct {
	in1 int
	in2 int
}

type outerS struct {
	b      int
	c      float32
	int    // anonymous field
	innerS // anonymous field
}

func main() {
	outer := new(outerS)
	outer.b = 6
	outer.c = 3.14
	outer.int = 60
	outer.in1 = 6
	outer.in2 = 7

	fmt.Println(outer)
}
