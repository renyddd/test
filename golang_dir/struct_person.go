package main

import (
	"fmt"
	"strings"
)

type Person struct {
	firstName string
	lastName  string
}

func upPerson(p *Person) {
	p.firstName = strings.ToUpper(p.firstName)
}

func main() {
	var p1 Person
	p1.firstName = "Chris"
	p1.lastName = "Woodward"
	upPerson(&p1)
	fmt.Println(p1)

	p2 := new(Person)
	p2.firstName = "Barry"
	(*p2).lastName = "Allen"
	upPerson(p2)
	fmt.Println(*p2)
}
