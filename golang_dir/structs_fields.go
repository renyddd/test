package main

import "fmt"

type struct1 struct {
	i1  int
	f1  float32
	str string
}

func main() {
	ms := new(struct1)
	// var ms struct1
	ms.i1 = 10
	ms.f1 = 3.14
	ms.str = "Hello, world"

	fmt.Println(ms.i1)

	s1 := &struct1{1, 1.1, "Hi"}
	fmt.Printf("%v", s1)
}
