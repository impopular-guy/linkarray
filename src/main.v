module linkedarray

pub enum Direction {
	front
	back
}

struct Node[T] {
mut:
	data T
	next int = -1
	prev int = -1
}

pub struct LinkedArray[T] {
mut:
	arr  []Node[T]
	head int = -1
	tail int = -1
	len  int
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
		// head == tail
		value := list.arr[list.tail].data
		list.head = -1
		list.tail = -1
		list.arr.clear()
		return value
	}
	value := list.arr[list.tail].data
	list.tail = list.arr[list.tail].prev
	list.arr[list.tail].next = -1
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
		// head == tail
		value := list.arr[list.head].data
		list.head = -1
		list.tail = -1
		list.arr.clear()
		return value
	}
	value := list.arr[list.head].data
	list.head = list.arr[list.head].next
	list.arr[list.head].prev = -1
	return value
}

/*
fn (mut list DoublyLinkedList[T]) insert(idx int, item T) !
insert adds an element to the linked list at the given index


fn (list &DoublyLinkedList[T]) index(item T) !int
index searches the linked list for item and returns the forward index or none if not found.


fn (mut list DoublyLinkedList[T]) delete(idx int)
delete removes index idx from the linked list and is safe to call for any idx.


fn (mut list DoublyLinkedList[T]) next() ?T
next implements the iter interface to use DoublyLinkedList with V's for x in list { loop syntax.


fn (mut list DoublyLinkedList[T]) iterator() DoublyListIter[T]
iterator returns a new iterator instance for the list.


fn (mut list DoublyLinkedList[T]) back_iterator() DoublyListIterBack[T]
back_iterator returns a new backwards iterator instance for the list.
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
