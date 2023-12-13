module main

import linkedarray as la

fn main() {
	println(la.version())

	list := la.LinkedArray[int]{}
	println(list)

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
}
