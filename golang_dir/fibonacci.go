package main

import "fmt"

func main() {
	result := 0
	for i := 0; i < 21; i++ {
		result = fibonacci(i)
		fmt.Println(result)
	}

	// nump(10)
}

func fibonacci(n int) (res int) {
	if n <= 1 {
		res = 1
	} else {
		res = fibonacci(n-1) + fibonacci(n-2)
	}
	return
}

func nump(n int) int {
	if n < 1 {
		return 0
	} else {
		fmt.Println(n)
		return nump(n - 1)
	}
}
