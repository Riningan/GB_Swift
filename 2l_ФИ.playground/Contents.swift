import UIKit
import Darwin

func isModToN(value: Int, mod: Int) -> Bool {
    if (value % mod == 0) {
        return true
    } else {
        return false
    }
}

// 1. Написать функцию, которая определяет, четное число или нет.
func isEvenOrNot(value: Int) -> Bool {
    return isModToN(value: value, mod: 2)
}

// 2. Написать функцию, которая определяет, делится ли число без остатка на 3.
func isMod3(value: Int) -> Bool {
    return isModToN(value: value, mod: 3)
}

// 3. Создать возрастающий массив из 100 чисел.
func createIncreasingArray(size: UInt) -> [Int] {
    var array = [Int]()
    var previous = 0
    for _ in 1...size {
        previous += Int(arc4random_uniform(5)) + 1
        array.append(previous)
    }
    return array
}
var array = createIncreasingArray(size: 100)

// 4. Удалить из этого массива все четные числа и все числа, которые не делятся на 3.
for i in stride(from: array.count - 1, to: -1, by: -1) {
    let item = array[i]
    if (isEvenOrNot(value: item) || !isMod3(value: item)) {
        array.remove(at: i)
    }
}
print(array)

// 5. Написать функцию, которая добавляет в массив новое число Фибоначчи, и добавить при помощи нее 50 элементов.
func createFibonachi(size: UInt) -> [Int] {
    var array = [Int]()
    if (size > 0) {
        array.append(1)
        if (size > 1) {
            array.append(1)
            if (size > 2) {
                for i in stride(from: 2, to: Int(size), by: 1) {
                    array.append(array[i - 1] + array[i - 2])
                }
            }
        }
    }
    return array
}

print(createFibonachi(size: 50))

// 6. Заполнить массив из 100 элементов различными простыми числами.
func createCandidates(from: Int, to: Int) -> [Int] {
    var array = [Int]()
    for i in from...to {
        array.append(i)
    }
    return array
}
func createSimple(size: UInt, step: UInt = 10) -> [Int] {
    var result = [Int]()
    if (size > 0) {
        result.append(2)
        // создаем массив последовательных чисел
        var from = 2
        var to = Int(step) + 1
        var candidates = createCandidates(from: from, to: to)
        while result.count != Int(size) {
            // удаляем числа которые делятся на те что уже определили как простые
            // удаляем с конца чтобы не напрушить индекс в массиве
            for i in stride(from: candidates.count - 1, to: -1, by: -1) {
                let value = candidates[i]
                for p in result {
                    if (isModToN(value: value, mod: p)) {
                        candidates.remove(at: i)
                        break
                    }
                }
            }
            if (candidates.count == 0) {
                // все числа были удалены, нужен новый массив
                from = to + 1
                to += Int(step)
                candidates = createCandidates(from: from, to: to)
            } else {
                // есть простое число
                result.append(candidates.remove(at: 0))
            }
        }
    }
    return result
}
print(createSimple(size: 100))
