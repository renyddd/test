package main

import "fmt"

func main() {
	var arr1 [6]int
	var slice1 []int = arr1[2:5]

	for i := 0; i < len(arr1); i++ {
		arr1[i] = i
	}

	for i := 0; i < len(slice1); i++ {
		fmt.Println(slice1[i])
	}

	fmt.Println(len(slice1))
	fmt.Println(cap(slice1))

	slice1 = arr1[:]
	fmt.Println(len(slice1))
	fmt.Println(cap(slice1))
	fmt.Println(sum(slice1))
	fmt.Println(sum(arr1[:]))

	var s []int = make([]int, 6)
	fmt.Println(s)
	s1 := make([]int, 6)
	fmt.Println(s1)

}

func sum(a []int) int {
	s := 0
	for i := 0; i < len(a); i++ {
		s += a[i]
	}
	return s
}
