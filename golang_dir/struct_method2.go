package main

import "fmt"

type IntVector []int

func (v IntVector) Sum() int {
	s := 0
	for _, x := range v {
		s += x
	}
	return s
}

func main() {
	fmt.Println(IntVector{1, 2, 3, 4, 5}.Sum())
}
