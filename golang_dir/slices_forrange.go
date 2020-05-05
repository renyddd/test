package main

import "fmt"

func main() {
	var s []int = make([]int, 4)

	for i, v := range s {
		fmt.Println(i, v)
	}

	seasons := []string{"Spring", "Summer", "Autumn", "Winter"}
	for _, v := range seasons {
		fmt.Println(v)
	}

	items := [...]int{10, 20, 30, 40, 50}
	for _, item := range items {
		item *= 2
		fmt.Println(item)
	}

	sa := "\u00ff\u754c"
	for i, c := range sa {
		fmt.Printf("%d: %c", i, c)
	}
}
