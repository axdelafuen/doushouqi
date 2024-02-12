import Foundation
import Model

extension Owner : Codable {
    
    enum Key: CodingKey {
        case ownerValue
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Key.self)
        switch self {
        case .noOne:
            try container.encode(0, forKey: .ownerValue)
        case .player1:
            try container.encode(1, forKey: .ownerValue)
        case .player2:
            try container.encode(2, forKey: .ownerValue)
        }
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)
        let value = try container.decode(Int.self, forKey: .ownerValue)
        switch value {
        case 0:
            self = .noOne
        case 1:
            self = .player1
        case 2:
            self = .player2
        default:
            throw CodingError.unknownValue
        }
    }
}

