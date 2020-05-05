package main

import (
	"fmt"
)

func main() {
	i1 := 5
	fmt.Printf("An integer: %d, its location is: %p\n", i1, &i1)

	var p *int
	p = &i1
	fmt.Printf("%d, ", *p)
	fmt.Println(*p)

	if v1 := 5; v1 > 3 {
		fmt.Println(v1)
	}
}
