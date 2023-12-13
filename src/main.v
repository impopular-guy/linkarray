module linkedarray

const iter_nil = -2
pub const nil_idx = -1

pub enum Direction {
	front
	back
}

struct Node[T] {
mut:
	data T
	next int = linkedarray.nil_idx
	prev int = linkedarray.nil_idx
}

pub struct LinkedArray[T] {
mut:
	arr  []Node[T]
	head int = linkedarray.nil_idx
	tail int = linkedarray.nil_idx
	len  int
	iter int = linkedarray.iter_nil // internal
}

// is_empty checks if the linked list is empty
pub fn (list LinkedArray[T]) is_empty() bool {
	return list.len == 0
}

// len returns the length of the linked list
pub fn (list LinkedArray[T]) len() int {
	return list.len
}

// first returns the first element of the linked list
pub fn (list LinkedArray[T]) first() !T {
	if list.is_empty() {
		return error('Linked array is empty')
	}
	return list.arr[list.head].data
}

// last returns the last element of the linked list
pub fn (list LinkedArray[T]) last() !T {
	if list.is_empty() {
		return error('Linked array is empty')
	}
	return list.arr[list.tail].data
}

// push_back adds an element to the end of the linked list
pub fn (mut list LinkedArray[T]) push_back(item T) {
	mut new_node := Node[T]{
		data: item
	}
	if list.is_empty() {
		list.arr << new_node
		list.head = 0
		list.tail = 0
	} else {
		new_idx := list.arr.len
		list.arr[list.tail].next = new_idx
		new_node.prev = list.tail
		list.tail = new_idx
		list.arr << new_node
	}
	list.len += 1
}

// push_front adds an element to the beginning of the linked list
pub fn (mut list LinkedArray[T]) push_front(item T) {
	mut new_node := Node[T]{
		data: item
	}
	if list.is_empty() {
		list.arr << new_node
		list.head = 0
		list.tail = 0
	} else {
		new_idx := list.arr.len
		list.arr[list.head].prev = new_idx
		new_node.next = list.head
		list.head = new_idx
		list.arr << new_node
	}
	list.len += 1
}

// push_many adds array of elements to the beginning/end of the linked list
pub fn (mut list LinkedArray[T]) push_many(elements []T, direction Direction) {
	match direction {
		.front {
			for i := elements.len - 1; i >= 0; i-- {
				v := elements[i]
				list.push_front(v)
			}
		}
		.back {
			for v in elements {
				list.push_back(v)
			}
		}
	}
}

// pop_back removes the last element of the linked list
pub fn (mut list LinkedArray[T]) pop_back() !T {
	if list.is_empty() {
		return error('Linked array is empty')
	}
	defer {
		list.len -= 1
	}
	if list.len == 1 {
		value := list.arr[list.tail].data
		list.head = linkedarray.nil_idx
		list.tail = linkedarray.nil_idx
		list.arr.clear()
		return value
	}
	value := list.arr[list.tail].data
	list.tail = list.arr[list.tail].prev
	list.arr[list.tail].next = linkedarray.nil_idx
	return value
}

// pop_front removes the last element of the linked list
pub fn (mut list LinkedArray[T]) pop_front() !T {
	if list.is_empty() {
		return error('Linked array is empty')
	}
	defer {
		list.len -= 1
	}
	if list.len == 1 {
		value := list.arr[list.head].data
		list.head = linkedarray.nil_idx
		list.tail = linkedarray.nil_idx
		list.arr.clear()
		return value
	}
	value := list.arr[list.head].data
	list.head = list.arr[list.head].next
	list.arr[list.head].prev = linkedarray.nil_idx
	return value
}

// insert adds an element to the linked list at the given index
pub fn (mut list LinkedArray[T]) insert(idx int, item T) ! {
	if idx < 0 || idx > list.len {
		return error('Index ${idx} out of bounds [0..${list.len}]')
	} else if idx == 0 {
		list.push_front(item)
	} else if idx == list.len {
		list.push_back(item)
	} else {
		before_idx := list.node_index_at(idx - 1)
		new_idx := list.arr.len
		next := list.arr[before_idx].next
		list.arr[before_idx].next = new_idx
		list.arr[next].prev = new_idx

		new_node := Node[T]{
			data: item
			next: next
			prev: before_idx
		}
		list.arr << new_node
		list.len += 1
	}
}

fn (list LinkedArray[T]) node_index_at(idx int) int {
	if idx <= list.len / 2 {
		mut node_idx := list.head
		for h := 0; h < idx; h += 1 {
			node_idx = list.arr[node_idx].next
		}
		return node_idx
	}

	mut node_idx := list.tail
	for t := list.len - 1; t > idx; t -= 1 {
		node_idx = list.arr[node_idx].prev
	}
	return node_idx
}

// at returns the element at the given index
pub fn (list LinkedArray[T]) at(idx int) !T {
	if idx < 0 || idx > list.len {
		return error('Index ${idx} out of bounds [0..${list.len}]')
	}
	arr_idx := list.node_index_at(idx)
	return list.arr[arr_idx].data
}

// index searches the linked list for item and returns the forward index or none if not found.
pub fn (list LinkedArray[T]) index(item T) ?int {
	mut hn := list.head
	mut tn := list.tail
	for h, t := 0, list.len - 1; h <= t; {
		if list.arr[hn].data == item {
			return h
		} else if list.arr[tn].data == item {
			return t
		}
		h += 1
		hn = list.arr[hn].next
		t -= 1
		tn = list.arr[tn].prev
	}
	return none
}

// delete removes index idx from the linked list and is safe to call for any idx.
pub fn (mut list LinkedArray[T]) delete(idx int) {
	if idx < 0 || idx >= list.len {
		return
	} else if idx == 0 {
		list.pop_front() or {}
		return
	} else if idx == list.len - 1 {
		list.pop_back() or {}
		return
	}
	node_idx := list.node_index_at(idx)
	prev, next := list.arr[node_idx].prev, list.arr[node_idx].next
	list.arr[prev].next = next
	list.arr[next].prev = prev
	list.len -= 1
}

// next implements the iter interface to use DoublyLinkedList with V's for x in list { loop syntax.
fn (mut list LinkedArray[T]) next() ?T {
	if list.iter == linkedarray.iter_nil {
		list.iter = list.head
		return list.next()
	}
	if list.iter == linkedarray.nil_idx {
		list.iter = linkedarray.iter_nil
		return none
	}
	defer {
		list.iter = list.arr[list.iter].next
	}
	return list.arr[list.iter].data
}

/*
fn compact(shink = false) {
	reorgnize
	shrink size if len very less than cap and shrink == true

	or maybe just make a new array
}

fn sort(cmp fn(a,b) bool) {
	compact()
	sort normally
	reconnect all nodex serially
}
*/

fn (n Node[T]) str() string {
	return 'Node{prev: ${n.prev}, next: ${n.next}, data: ${n.data}}'
}

// array returns a array representation of the linked list
pub fn (list LinkedArray[T]) array() []T {
	mut result_array := []T{cap: list.len}
	mut node_idx := list.head
	for node_idx != -1 {
		result_array << list.arr[node_idx].data
		node_idx = list.arr[node_idx].next
	}
	return result_array
}

// str returns a string representation of the linked list
pub fn (list LinkedArray[T]) str() string {
	arr_str := list.arr.map(it.str()).join(',\n    ')
	arr1_str := list.array().str()
	rest := '\n  arr1: ${arr1_str}\n  head: ${list.head}\n  tail: ${list.tail}\n  len: ${list.len}'
	return 'LinkedArray{\n  arr: [\n    ${arr_str}\n  ]${rest}\n}'
}
