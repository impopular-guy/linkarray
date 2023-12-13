# module linkarray

# linkarray

Doubly-Linked-List implementation using array. Why store addresses when you can store index ?

## Quickstart


```v
import linkarray as la

fn main() {
mut list := la.linkarray[int]{}

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


## Contents
- [Constants](#Constants)
- [LinkedArrayIter[T]](#LinkedArrayIter[T])
  - [next](#next)
- [LinkedArray[T]](#LinkedArray[T])
  - [is_empty](#is_empty)
  - [len](#len)
  - [first](#first)
  - [last](#last)
  - [push_back](#push_back)
  - [push_front](#push_front)
  - [push_many](#push_many)
  - [pop_back](#pop_back)
  - [pop_front](#pop_front)
  - [insert](#insert)
  - [at](#at)
  - [index](#index)
  - [delete](#delete)
  - [array](#array)
  - [str](#str)
  - [debug_str](#debug_str)
  - [iterator](#iterator)
  - [pack](#pack)
- [Direction](#Direction)
- [LinkedArrayIter](#LinkedArrayIter)
- [LinkedArray](#LinkedArray)

## Constants
```v
const nil_idx = -1
```


[[Return to contents]](#Contents)

## LinkedArrayIter[T]
## next
```v
fn (mut iter LinkedArrayIter[T]) next() ?T
```
next returns *the next* element of the list, or `none` when the end of the list is reached. It is called by V's `for x in iter{` on each iteration.

[[Return to contents]](#Contents)

## LinkedArray[T]
## is_empty
```v
fn (list LinkedArray[T]) is_empty() bool
```
is_empty checks if the linked list is empty

[[Return to contents]](#Contents)

## len
```v
fn (list LinkedArray[T]) len() int
```
len returns the length of the linked list

[[Return to contents]](#Contents)

## first
```v
fn (list LinkedArray[T]) first() !T
```
first returns the first element of the linked list

[[Return to contents]](#Contents)

## last
```v
fn (list LinkedArray[T]) last() !T
```
last returns the last element of the linked list

[[Return to contents]](#Contents)

## push_back
```v
fn (mut list LinkedArray[T]) push_back(item T)
```
push_back adds an element to the end of the linked list

[[Return to contents]](#Contents)

## push_front
```v
fn (mut list LinkedArray[T]) push_front(item T)
```
push_front adds an element to the beginning of the linked list

[[Return to contents]](#Contents)

## push_many
```v
fn (mut list LinkedArray[T]) push_many(elements []T, direction Direction)
```
push_many adds array of elements to the beginning/end of the linked list

[[Return to contents]](#Contents)

## pop_back
```v
fn (mut list LinkedArray[T]) pop_back() !T
```
pop_back removes the last element of the linked list

[[Return to contents]](#Contents)

## pop_front
```v
fn (mut list LinkedArray[T]) pop_front() !T
```
pop_front removes the last element of the linked list

[[Return to contents]](#Contents)

## insert
```v
fn (mut list LinkedArray[T]) insert(idx int, item T) !
```
insert adds an element to the linked list at the given index

[[Return to contents]](#Contents)

## at
```v
fn (list LinkedArray[T]) at(idx int) !T
```
at returns the element at the given index

[[Return to contents]](#Contents)

## index
```v
fn (list LinkedArray[T]) index(item T) ?int
```
index searches the linked list for item and returns the forward index or none if not found.

[[Return to contents]](#Contents)

## delete
```v
fn (mut list LinkedArray[T]) delete(idx int)
```
delete removes index idx from the linked list and is safe to call for any idx.

[[Return to contents]](#Contents)

## array
```v
fn (list LinkedArray[T]) array() []T
```
array returns a array representation of the linked list

[[Return to contents]](#Contents)

## str
```v
fn (list LinkedArray[T]) str() string
```
str returns a string representation of the linked list

[[Return to contents]](#Contents)

## debug_str
```v
fn (list LinkedArray[T]) debug_str() string
```
debug_str returns a string for debugging

[[Return to contents]](#Contents)

## iterator
```v
fn (list LinkedArray[T]) iterator(dir Direction) LinkedArrayIter[T]
```
iterator returns a new iterator instance for both directions

[[Return to contents]](#Contents)

## pack
```v
fn (mut list LinkedArray[T]) pack()
```
pack reorganises the linked-list back into a serial manner. It creates a new array and populates it.

[[Return to contents]](#Contents)

## Direction
```v
enum Direction {
	front
	back
}
```


[[Return to contents]](#Contents)

## LinkedArrayIter
```v
struct LinkedArrayIter[T] {
	list      &LinkedArray[T] = unsafe { nil }
	direction Direction       = .front
mut:
	node_idx int = linkarray.iter_nil
}
```


[[Return to contents]](#Contents)

## LinkedArray
```v
struct LinkedArray[T] {
mut:
	arr  []Node[T]
	head int = linkarray.nil_idx
	tail int = linkarray.nil_idx
	len  int
	iter int = linkarray.iter_nil // internal
}
```


[[Return to contents]](#Contents)

#### Powered by vdoc.
