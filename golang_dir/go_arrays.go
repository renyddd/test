package main

import "fmt"

func main() {
	var arr1 [10]int

	for i := 0; i < len(arr1); i++ {
		arr1[i] = i * 10
	}

	for i, v := range arr1 {
		fmt.Println(i, v)
	}
}
