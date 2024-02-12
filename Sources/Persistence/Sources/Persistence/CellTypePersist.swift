import Foundation
import Model

extension CellType : Codable {
    enum Key: CodingKey {
        case cellTypeValue
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Key.self)
        switch self {
        case .den:
            try container.encode(0, forKey: .cellTypeValue)
        case .jungle:
            try container.encode(1, forKey: .cellTypeValue)
        case .trap:
            try container.encode(2, forKey: .cellTypeValue)
        case .unknown:
            try container.encode(3, forKey: .cellTypeValue)
        case .water:
            try container.encode(4, forKey: .cellTypeValue)
        }
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)
        let value = try container.decode(Int.self, forKey: .cellTypeValue)
        switch value {
        case 0:
            self = .den
        case 1:
            self = .jungle
        case 2:
            self = .trap
        case 3:
            self = .unknown
        case 4:
            self = .water
        default:
            throw CodingError.unknownValue
        }
    }
}
