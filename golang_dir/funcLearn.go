package main

import "fmt"

func main() {
	fmt.Println(MultiPly3Num(1, 2, 3))
	fmt.Println(return2vals(6))
	fmt.Println(return2namedvals(6))
	x := 10
	tenTimes(&x)
	fmt.Println(x)
}

func MultiPly3Num(a, b, c int) int {
	return a * b * c
}

func return2vals(a int) (int, int) {
	return a + 1, a - 1
}

func return2namedvals(a int) (v1, v2 int) {
	v1 = a + 1
	v2 = a - 1
	return
}

func tenTimes(a *int) {
	*a = *a * 10
}
