import UIKit

enum CarType {
    case SportCar
    case TrunkCar
}

enum CarAction {
    case START_ENGINE
    case STOP_ENGINE
    case OPEN_WINDOW
    case CLOSE_WINDOW
    case PUT_TO_BACK(volume: Double)
    case GET_FROM_BACK(volume: Double)
}

struct Car {
    let type: CarType
    let brand: String
    let yearOfIssue: UInt
    let maxBackVolume: Double
    var isEngineStrated: Bool = false
    var isWindowOpen: Bool = false
    var usedBackVolume: Double = 0.0
    
    init(type: CarType, brand: String, yearOfIssue: UInt, maxBackVolume: Double) {
        self.type = type
        self.brand = brand
        self.yearOfIssue = yearOfIssue
        self.maxBackVolume = maxBackVolume
    }
    
    mutating func apply(_ action: CarAction) {
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
                } else {
                    usedBackVolume = newBackVolume
                }
            case .GET_FROM_BACK(let volume):
                usedBackVolume = max(usedBackVolume - volume, 0.0)
        }
    }
}


var audi = Car(type: CarType.SportCar, brand: "Audi", yearOfIssue: 2010, maxBackVolume: 20)
var bmw = Car(type: CarType.SportCar, brand: "BMW", yearOfIssue: 2020, maxBackVolume: 30)

audi.apply(CarAction.OPEN_WINDOW)
audi.apply(CarAction.OPEN_WINDOW)
audi.apply(CarAction.PUT_TO_BACK(volume: 10))
audi.apply(CarAction.PUT_TO_BACK(volume: 20))
audi.apply(CarAction.START_ENGINE)
