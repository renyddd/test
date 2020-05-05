package main

import (
	"fmt"
	"math/rand"
	"strings"
	"time"
)

func main() {
	var str = "This is an example of a string." // 可以不知名变量类型
	fmt.Printf("T/F? Dose the string \"%s\" hava prefix %s? ", str, "Th")
	fmt.Printf("%t\n", strings.HasPrefix(str, "Th"))
	fmt.Printf("%t\n", strings.Contains(str, "exda"))
	fmt.Printf("\n")
	fmt.Printf("%d\n", strings.Count(str, "i"))

	for i := 0; i < 10; i++ {
		a := rand.Int()
		fmt.Printf("%d, ", a)
	}
	fmt.Printf("\n")

	var ch byte = 65
	fmt.Printf("%c", ch)
	ch2 := '\U00101234'
	fmt.Printf("%U", ch2)
	fmt.Printf("\n")

	t := time.Now()
	fmt.Println(t)
	t = time.Now().UTC()
	fmt.Println(t)
}
