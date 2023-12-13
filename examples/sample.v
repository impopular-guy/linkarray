module main

import linkedarray as la

fn main() {
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
	println('\nPUSH_BACK ${list}\n')
	a := list.pop_back() or { 0 }
	println('${a}\nPOP_BACK ${list}\n')
	list.push_back(20)
	println('\nPUSH_BACK ${list}\n')
	list.push_front(30)
	println('\nPUSH_FRONT ${list}\n')
	b := list.pop_back() or { 0 }
	println('${b}\nPOP_BACK ${list}\n')

	list.push_many([40, 50], .front)
	list.push_many([60, 70], .back)
	println('\nPUSH_MANY ${list}\n')

	a1 := list.pop_front() or { 0 }
	println('${a1}\nPOP_FRONT ${list}\n')
}
