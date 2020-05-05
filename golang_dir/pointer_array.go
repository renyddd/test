package main

import "fmt"

func f(a [3]int) {
	a[2] = 10
	fmt.Println(a)
}

func fp(a *[3]int) {
	fmt.Println(a)
	a[0] = 99
}

func main() {
	var ar = [3]int{1, 2, 3}
	f(ar)
	fp(&ar)
	f(ar)
}
