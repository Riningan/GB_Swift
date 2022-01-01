import UIKit

struct Queue<T> {
    private var items = [T]()
    
    mutating func put(_ item: T) {
        items.append(item)
    }
    
    mutating func putAll(_ items: [T]) {
        self.items.append(contentsOf: items)
    }
    
    mutating func get(_ index: Int = 0) -> T? {
        if (items.count == 0) {
            return nil
        }
        if (items.count <= index) {
            items.removeAll()
            return nil
        }
        if (index != 0) {
            items.removeFirst(index)
        }
        return items.removeFirst()
    }
    
    mutating func sort(by: (T, T) -> Bool ) {
        items.sort(by: by)
    }
    
    mutating func filter(by: (T) -> Bool) {
        items = items.filter(by)
    }
    
    subscript(index: Int) -> T? {
        mutating get {
            return get(index)
        }
    }
}

var queue = Queue<Int>()

queue.put(1)
queue.put(4)
queue.put(3)
queue.put(2)
queue.put(5)
print(queue)

queue.sort(by: { t1, t2 in  t1 < t2} )
print(queue)

print(queue.get(0)!)
print(queue)

print(queue.get(2))
print(queue)

print(queue.get(2))
print(queue)

queue.putAll([1, 4, 3, 2, 5])
print(queue)

queue.filter(by: {(t: Int) -> Bool in return t % 2 == 0})
print(queue)

print(queue[1]!)
print(queue)

