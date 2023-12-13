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

	list.push_many([40, 50, 80], .front)
	list.push_many([60, 70, 90], .back)
	println('\nPUSH_MANY ${list}\n')

	a1 := list.pop_front() or { 0 }
	println('${a1}\nPOP_FRONT ${list}\n')

	list.insert(1, 100)!
	println('\nINSERT 1 ${list}\n')
	list.insert(5, 101)!
	println('\nINSERT 5 ${list}\n')
	list.insert(3, 102)!
	println('\nINSERT 3 ${list}\n')

	println('AT 1 ${list.at(1)!}')
	println('AT 3 ${list.at(3)!}')
	println('AT 5 ${list.at(5)!}')

	println('INDEX 100 ${list.index(100)}')
	println('INDEX 101 ${list.index(101)}')
	println('INDEX 102 ${list.index(102)}')
	println('INDEX 999 ${list.index(999)}')

	list.delete(5)
	println('\nDELETE 5 ${list}\n')

	for x in list {
		println('FOR x:${x}')
	}
	for i, x in list {
		println('FOR i:${i} x:${x}')
	}

	println('\nLIST ${list.debug_str()}\n')
	list.pack()
	println('\nPACKED LIST ${list.debug_str()}\n')
}
