# linkedarray

Doubly-Linked-List implementation using array. Why store addresses when you can store index ?

## Quickstart

```v
import linkedarray as la

fn main() {
	mut list := la.LinkedArray[int]{}

	println(list.is_empty())
	println(list.len())

	list.push_back(10)
	list.push_front(30)
	list.push_many([40, 50, 80], .front)
	list.push_many([60, 70, 90], .back)

	_ := list.pop_front()!

	list.insert(5, 101)!

	println('ITEM AT 1 ${list.at(1)!}')

	println('SEARCH 101 ${list.index(101)}')

	list.delete(5)

	for i, x in list {
		println('FOR i:${i} x:${x}')
	}

	list.pack()
	println('\nPACKED LIST ${list.debug_str()}\n')
}
```

## Is it any good? Let's look at some benchmarks!

[hyperfine](https://github.com/sharkdp/hyperfine) is used.
Check the `./bench/` folder for more info.

## LICENSE

MIT

## Thanks

Lot of code is taken to Vlangs official doubly-linked-list implemetation from its standard library. Thanks to them for making this project possible.