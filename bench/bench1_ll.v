module main

import datatypes as dt

fn main() {
	mut list := dt.DoublyLinkedList[int]{}
	for i := 0; i < 10000; i++ {
		list.push_back(i)
	}

	mut d := 0
	for i := 9999; i >= 5000; i-- {
		list.delete(d)
		d = (d + 307) % i
	}
	for i := 4999; i >= 10; i-- {
		list.delete(d)
		d = (d + 307) % i
	}
}
