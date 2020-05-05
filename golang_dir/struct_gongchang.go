package main

import "fmt"

type File struct {
	fd   int
	name string
}

func NewFile(fd int, name string) *File {
	if fd < 0 {
		return nil
	}

	return &File{fd, name}
}

func main() {
	f := NewFile(1, "test.txt")
	fmt.Println(f)
}
