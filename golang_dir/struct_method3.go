package main

import "fmt"

type employee struct {
	salary int
}

func (this *employee) giveSalary(n int) {
	this.salary += n
}

func (this employee) notGiveSalary(n int) {
	this.salary += n
}

func main() {
	// p1 := new(employee)
	var p1 employee
	p1.salary = 10
	p1.giveSalary(10)
	p1.giveSalary(10)
	p1.giveSalary(10)
	p1.giveSalary(10)
	fmt.Println(p1)

	p2 := new(employee)
	p2.salary = 5
	p2.notGiveSalary(95)
	fmt.Println(p2)
}
