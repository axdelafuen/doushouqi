import Foundation
import Model

public extension Animal {
    var csvNotation: String {
        switch self {
        case .rat:
            return "S"
        case .cat:
            return "M"
        case .dog:
            return "C"
        case .wolf:
            return "W"
        case .leopard:
            return "P"
        case .tiger:
            return "T"
        case .lion:
            return "L"
        case .elephant:
            return "E"
        }
    }
}
