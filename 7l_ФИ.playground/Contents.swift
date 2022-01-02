import UIKit

enum QueueError: Error {
    case InvalidIndex(index: Int)
    case EmptyQueue
    case IndexOutOfRange(index: Int)
}

class Queue<T> {
    private var items = [T]()

    func put(_ item: T) {
        items.append(item)
    }

    func putAll(_ items: [T]) {
        self.items.append(contentsOf: items)
    }

    func get(_ index: Int = 0) throws -> T {
        if (index < 0) {
            throw QueueError.InvalidIndex(index: index)
        }
        if (items.count == 0) {
            throw QueueError.EmptyQueue
        }
        if (items.count <= index) {
            items.removeAll()
            throw QueueError.IndexOutOfRange(index: index)
        }
        if (index != 0) {
            items.removeFirst(index)
        }
        return items.removeFirst()
    }
    
    func sort(by: (T, T) -> Bool ) throws {
        if (items.count == 0) {
            throw QueueError.EmptyQueue
        }
        items.sort(by: by)
    }
}

var queue = Queue<Int>()
queue.put(1)
queue.put(4)
queue.put(3)
queue.put(2)
queue.put(5)
while true {
    if let item = try? queue.get(1) {
        print(item)
    } else {
        print("Нет такого элемента")
        break
    }
}

queue.putAll([1, 4, 3, 2, 5])
do {
    try queue.sort { $0 > $1}
} catch QueueError.EmptyQueue {
    print("Очередь пустая")
}

queue.putAll([1, 4, 3, 2, 5])
while let item = try? queue.get() {
    print(item)
}
print("Очередь очишена")

do {
    try queue.sort { $0 > $1}
} catch QueueError.EmptyQueue {
    print("Очередь пустая")
}
