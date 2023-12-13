module main

import linkedarray as la

fn main() {
	println(la.version())

	mut list := la.LinkedArray[int]{}
	println('\nXXXX ${list}\n')

	println(list.is_empty())
	println(list.len())

	_ := list.first() or {
		println(err)
		-1
	}
	_ := list.last() or {
		println(err)
		-1
	}

	list.push_back(10)
	println('\nXXXX ${list}\n')
	list.push_back(20)
	println('\nXXXX ${list}\n')
}
