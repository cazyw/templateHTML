package main

import (
	"fmt"
	"strconv"
)

var i int = 42
var (
	actorName string = "Elisabeth Sladen"
	companion string = "Sarah Jane Smith"
	series    int    = 3
)

func main() {
	fmt.Println("Hi, let's Go!")
	fmt.Printf("Meaning of life is %v (%T)\n", i, i)
	fmt.Printf("%v played %v in series %v\n", actorName, companion, series)

	var j float32
	j = float32(i)
	fmt.Printf("%v is type %T\n", j, j)

	var s string
	s = strconv.Itoa(i)
	fmt.Printf("%v is type %T\n", s, s)

	a := 10             // 1010
	b := 3              // 0011
	fmt.Println(a & b)  // 0010
	fmt.Println(a | b)  // 1011
	fmt.Println(a ^ b)  // 1001
	fmt.Println(a &^ b) // 1000 (exists only in a and not b)

	c := 16             // 2^4
	fmt.Println(c << 3) // 2^4 * 2*3 = 2^7 = 128
	fmt.Println(c >> 3) // 2^4 / 2^3 = 2^1 = 2
}
