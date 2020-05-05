package main

import "fmt"

func main() {
	m1 := map[int]string{1: "one", 2: "two"}

	if v, ok := m1[1]; ok {
		fmt.Println(m1[1])
		fmt.Println(v)
	}

	for key, value := range m1 {
		fmt.Println(key, value)
	}

}
