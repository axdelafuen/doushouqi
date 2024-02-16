import Foundation
import Model

extension Animal: Codable{
    
    enum Key: CodingKey {
        case animalValue
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Key.self)
        switch self {
        case .cat:
            try container.encode(0, forKey: .animalValue)
        case .dog:
            try container.encode(1, forKey: .animalValue)
        case .elephant:
            try container.encode(2, forKey: .animalValue)
        case .leopard:
            try container.encode(3, forKey: .animalValue)
        case .lion:
            try container.encode(4, forKey: .animalValue)
        case .rat:
            try container.encode(5, forKey: .animalValue)
        case .tiger:
            try container.encode(6, forKey: .animalValue)
        case .wolf:
            try container.encode(7, forKey: .animalValue)
        }
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)
        let value = try container.decode(Int.self, forKey: .animalValue)
        switch value {
        case 0:
            self = .cat
        case 1:
            self = .dog
        case 2:
            self = .elephant
        case 3:
            self = .leopard
        case 4:
            self = .lion
        case 5:
            self = .rat
        case 6:
            self = .tiger
        case 7:
            self = .wolf
        default:
            throw SerializationError.unknownValue
        }
    }
}
