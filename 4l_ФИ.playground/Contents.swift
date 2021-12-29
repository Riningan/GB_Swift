import UIKit

enum CarAction {
    case START_ENGINE
    case STOP_ENGINE
    case OPEN_WINDOW
    case CLOSE_WINDOW
    case PUT_TO_BACK(volume: Double)
    case GET_FROM_BACK(volume: Double)
    case APPEND_TRAILER
    case RELEASE_TRAILER
    case INCREASE_SPEED(speed: UInt)
    case DECREASE_SPEED(speed: UInt)
}

class Car : CustomStringConvertible{
    let brand: String
    let yearOfIssue: UInt
    let maxBackVolume: Double
    var isEngineStrated: Bool = false
    var isWindowOpen: Bool = false
    var usedBackVolume: Double = 0.0
    
    var description: String {
        var description = ""
        description += "brand: \(brand)\n"
        description += "yearOfIssue: \(yearOfIssue)\n"
        description += "maxBackVolume: \(maxBackVolume)\n"
        description += "isEngineStrated: \(isEngineStrated)\n"
        description += "isWindowOpen: \(isWindowOpen)\n"
        description += "usedBackVolume: \(usedBackVolume)\n"
        return description
    }
    
    init(brand: String, yearOfIssue: UInt, maxBackVolume: Double) {
        self.brand = brand
        self.yearOfIssue = yearOfIssue
        self.maxBackVolume = maxBackVolume
    }
    
    func apply(_ action: CarAction) {
        switch action {
            case .START_ENGINE:
                if (isEngineStrated) {
                    print("Двигатель уже запущен")
                } else {
                    isEngineStrated = true
                }
            case .STOP_ENGINE:
                if (isEngineStrated) {
                    isEngineStrated = false
                } else {
                    print("Двигатель уже заглушен")
                }
            case .OPEN_WINDOW:
                if (isWindowOpen) {
                    print("Окна уже открыты")
                } else {
                    isWindowOpen = true
                }
            case .CLOSE_WINDOW:
                if (isWindowOpen) {
                    isWindowOpen = false
                } else {
                    print("Окна уже закрыты")
                }
            case .PUT_TO_BACK(let volume):
                let newBackVolume = usedBackVolume + volume
                if (newBackVolume > maxBackVolume) {
                    print("Нельзя добавить столько груза")
                    usedBackVolume = min(newBackVolume, maxBackVolume)
                } else {
                    usedBackVolume = newBackVolume
                }
            case .GET_FROM_BACK(let volume):
                usedBackVolume = max(usedBackVolume - volume, 0.0)
            default:
                print("Action not supported")
        }
    }
}

class TrunkCar : Car {
    var isHasTrailer: Bool = false
    
    override var description: String {
        var description = super.description
        description += "isHasTrailer: \(isHasTrailer)\n"
        return description
    }
    
    init(brand: String, yearOfIssue: UInt) {
        // у грузовиков нет багажника
        super.init(brand: brand, yearOfIssue: yearOfIssue, maxBackVolume: 0)
    }
    
    override func apply(_ action: CarAction) {
        switch action {
            case .APPEND_TRAILER:
                if (isHasTrailer) {
                    print("Автопоезда запрешены")
                } else {
                    isHasTrailer = true
                }
            case .RELEASE_TRAILER:
                if (isHasTrailer) {
                    isHasTrailer = true
                } else {
                    print("Уже разгрузились")
                }
            default:
                super.apply(action)
        }
    }
}

class SportCar : Car {
    let maxSpeed: UInt
    var currentSpeed: UInt = 0
    
    override var description: String {
        var description = super.description
        description += "maxSpeed: \(maxSpeed)\n"
        description += "currentSpeed: \(currentSpeed)\n"
        return description
    }
    
    init(brand: String, yearOfIssue: UInt,  maxSpeed: UInt) {
        self.maxSpeed = maxSpeed
        super.init(brand: brand, yearOfIssue: yearOfIssue, maxBackVolume: 10)
    }
    
    override func apply(_ action: CarAction) {
        switch action {
            case .INCREASE_SPEED(let speed):
                let newSpeed = currentSpeed + speed
                if (newSpeed > maxSpeed) {
                    print("Нельзя разгнаться так быстро")
                    currentSpeed = min(newSpeed, maxSpeed)
                } else {
                    currentSpeed = newSpeed
                }
            case .DECREASE_SPEED(let speed):
                currentSpeed = max(currentSpeed - speed, 0)
            default:
                super.apply(action)
        }
    }
}

let sportCar = SportCar(brand: "Ferrari", yearOfIssue: 2021, maxSpeed: 320)
sportCar.apply(CarAction.OPEN_WINDOW)
sportCar.apply(CarAction.START_ENGINE)
sportCar.apply(CarAction.INCREASE_SPEED(speed: 100))
sportCar.apply(CarAction.INCREASE_SPEED(speed: 100))
sportCar.apply(CarAction.INCREASE_SPEED(speed: 100))
sportCar.apply(CarAction.INCREASE_SPEED(speed: 100))
sportCar.apply(CarAction.RELEASE_TRAILER) // not supported
print(sportCar)

let trunkCar = TrunkCar(brand: "Renault", yearOfIssue: 2020)
trunkCar.apply(CarAction.APPEND_TRAILER)
print(trunkCar)
