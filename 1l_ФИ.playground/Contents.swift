import UIKit

// квадратное уравнение
func exc1(a: Double, b: Double, c: Double) {
    let d: Double = b * b - 4 * a * c
    if d > 0 {
        let sqrtD = sqrt(d)
        let x1 = (-b + sqrtD) / (2 * a)
        let x2 = (-b - sqrtD) / (2 * a)
        print("Первый корень равен " + String(x1))
        print("Второй корень равен " + String(x2))
    } else if d < 0 {
        print("У уровнения нет решения")
    } else {
        let x = -b / (2 * a)
        print("Корень равен " + String(x))
    }
}

// треугольник
func exc2(a: UInt, b: UInt) {
    let c = sqrt(pow(Double(a), 2) + pow(Double(b), 2))
    print("Гипотенуза равна " + String(c))
    print("Площадь равна " + String(a * b / 2))
    print("Периметр равен " + String(Double(a) + Double(b) + c))
}

// про вклады
func exc3(sum: Double, percent: Double) {
    var out: Double = sum
    for _ in 1...5 {
        out += out * percent / 100
    }
    print("Сумма вклада на пятый год составит " + String(format: "%.2f", out))
}

exc1(a: 1, b: 2, c: 1)
exc2(a: 1, b: 2)
exc3(sum: 5000, percent: 10.5)
