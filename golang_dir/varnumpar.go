package main

import "fmt"

func main() {
	x := min(1, 3, 2, 0)
	fmt.Printf("The minimum is: %d", x)
	slice := []int{3, 2, 5, 8, 4, 7}
	x = min(slice...)
	fmt.Printf("The minimum is: %d", x)
	fmt.Printf("\n")
	greet("hello,", " ", "world")
}

func greet(str ...string) {
	for _, s := range str {
		fmt.Println(s)
	}
}

func min(s ...int) int {
	if len(s) == 0 {
		return 0
	}
	min := s[0]
	for _, v := range s {
		if v < min {
			min = v
		}
	}
	return min
}
