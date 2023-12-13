module main

import linkarray as ls

fn main() {
	mut list := ls.LinkedArray[int]{}
	for i := 0; i < 10000; i++ {
		list.push_back(i)
	}

	mut d := 0
	for i := 9999; i >= 5000; i-- {
		list.delete(d)
		d = (d + 307) % i
	}
	list.pack()
	for i := 4999; i >= 10; i-- {
		list.delete(d)
		d = (d + 307) % i
	}
}
