import UIKit

protocol Car: AnyObject, CustomStringConvertible {
    var brand: String { get }
    var yearOfIssue: UInt { get }
    var maxBackVolume: Double { get }
    var isEngineStrated: Bool { get set }
    var isWindowOpen: Bool { get set }
    var usedBackVolume: Double { get set }
    
    func startEngine()
    
    func stopEngine()
    
    func openWindow()
    
    func closeWindow()
    
    func putToBack(volume: Double)
    
    func getFromBack(volume: Double)
}

extension Car {
    func startEngine() {
        if (isEngineStrated) {
            print("Двигатель уже запущен")
        } else {
            isEngineStrated = true
        }
    }
    
    func stopEngine() {
        if (isEngineStrated) {
            isEngineStrated = false
        } else {
            print("Двигатель уже заглушен")
        }
    }
    
    func openWindow() {
        if (isWindowOpen) {
            print("Окна уже открыты")
        } else {
            isWindowOpen = true
        }
    }
    
    func closeWindow() {
        if (isWindowOpen) {
            isWindowOpen = false
        } else {
            print("Окна уже закрыты")
        }
    }
    
    func putToBack(volume: Double) {
        let newBackVolume = usedBackVolume + volume
        if (newBackVolume > maxBackVolume) {
            print("Нельзя добавить столько груза")
            usedBackVolume = min(newBackVolume, maxBackVolume)
        } else {
            usedBackVolume = newBackVolume
        }
    }
    
    func getFromBack(volume: Double) {
        usedBackVolume = max(usedBackVolume - volume, 0.0)
    }
}

class SportCar: Car {
    let brand: String
    
    let yearOfIssue: UInt
    
    let maxBackVolume: Double
    
    let maxSpeed: UInt
    
    var isEngineStrated: Bool = false
    
    var isWindowOpen: Bool = false
    
    var usedBackVolume: Double = 0.0
    
    var currentSpeed: UInt = 0
    
    var description: String {
        var description = ""
        description += "brand: \(brand)\n"
        description += "yearOfIssue: \(yearOfIssue)\n"
        description += "maxBackVolume: \(maxBackVolume)\n"
        description += "isEngineStrated: \(isEngineStrated)\n"
        description += "isWindowOpen: \(isWindowOpen)\n"
        description += "usedBackVolume: \(usedBackVolume)\n"
        description += "maxSpeed: \(maxSpeed)\n"
        description += "currentSpeed: \(currentSpeed)\n"
        return description
    }
    
    init(brand: String, yearOfIssue: UInt,  maxSpeed: UInt) {
        self.brand = brand
        self.yearOfIssue = yearOfIssue
        self.maxBackVolume = 10
        self.maxSpeed = maxSpeed
    }
    
    func increaseSpeed(speed: UInt) {
        let newSpeed = currentSpeed + speed
        if (newSpeed > maxSpeed) {
            print("Нельзя разгнаться так быстро")
            currentSpeed = min(newSpeed, maxSpeed)
        } else {
            currentSpeed = newSpeed
        }
    }
    
    func decreaseSpeed(speed: UInt) {
        currentSpeed = max(currentSpeed - speed, 0)
    }
}

class TrunkCar: Car {
    let brand: String
    
    let yearOfIssue: UInt
    
    let maxBackVolume: Double
    
    var isEngineStrated: Bool = false
    
    var isWindowOpen: Bool = false
    
    var usedBackVolume: Double = 0.0
    
    var isHasTrailer: Bool = false
    
    var description: String {
        var description = ""
        description += "brand: \(brand)\n"
        description += "yearOfIssue: \(yearOfIssue)\n"
        description += "maxBackVolume: \(maxBackVolume)\n"
        description += "isEngineStrated: \(isEngineStrated)\n"
        description += "isWindowOpen: \(isWindowOpen)\n"
        description += "usedBackVolume: \(usedBackVolume)\n"
        description += "isHasTrailer: \(isHasTrailer)\n"
        return description
    }
    
    init(brand: String, yearOfIssue: UInt) {
        self.brand = brand
        self.yearOfIssue = yearOfIssue
        self.maxBackVolume = 0
    }
    
    func appendTrailer() {
        if (isHasTrailer) {
            print("Автопоезда запрешены")
        } else {
            isHasTrailer = true
        }
    }
    
    func releaseTrailer() {
        if (isHasTrailer) {
            isHasTrailer = true
        } else {
            print("Уже разгрузились")
        }
    }
}

let sportCar = SportCar(brand: "Ferrari", yearOfIssue: 2021, maxSpeed: 320)
sportCar.openWindow()
sportCar.startEngine()
sportCar.increaseSpeed(speed: 100)
print(sportCar)

let trunkCar = TrunkCar(brand: "Renault", yearOfIssue: 2020)
trunkCar.appendTrailer()
print(trunkCar)
