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

/*
fn (mut list DoublyLinkedList[T]) pop_back() !T
pop_back removes the last element of the linked list


fn (mut list DoublyLinkedList[T]) pop_front() !T
pop_front removes the last element of the linked list


fn (mut list DoublyLinkedList[T]) insert(idx int, item T) !
insert adds an element to the linked list at the given index


fn (list &DoublyLinkedList[T]) index(item T) !int
index searches the linked list for item and returns the forward index or none if not found.


fn (mut list DoublyLinkedList[T]) delete(idx int)
delete removes index idx from the linked list and is safe to call for any idx.


fn (list DoublyLinkedList[T]) str() string
str returns a string representation of the linked list


fn (list DoublyLinkedList[T]) array() []T
array returns a array representation of the linked list


fn (mut list DoublyLinkedList[T]) next() ?T
next implements the iter interface to use DoublyLinkedList with V's for x in list { loop syntax.


fn (mut list DoublyLinkedList[T]) iterator() DoublyListIter[T]
iterator returns a new iterator instance for the list.


fn (mut list DoublyLinkedList[T]) back_iterator() DoublyListIterBack[T]
back_iterator returns a new backwards iterator instance for the list.
*/
