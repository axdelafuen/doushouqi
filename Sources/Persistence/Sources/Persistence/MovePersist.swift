import Foundation
import Model

extension Move : Codable {
    enum Key: CodingKey {
        case owner
        case rowOriginValue
        case columnOriginValue
        case rowDestinationValue
        case columnDestinationValue
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Key.self)
        
        try container.encode(owner, forKey: .owner)
        try container.encode(rowOrigin, forKey: .rowOriginValue)
        try container.encode(columnOrigin, forKey: .columnOriginValue)
        try container.encode(rowDestination, forKey: .rowDestinationValue)
        try container.encode(columnDestination, forKey: .columnDestinationValue)
    }
    
    public init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: Key.self)
        let owner = try value.decode(Owner.self, forKey: .owner)
        let rowOrigin = try value.decode(Int.self, forKey: .rowOriginValue)
        let columnOrigin = try value.decode(Int.self, forKey: .columnOriginValue)
        let rowDestination = try value.decode(Int.self, forKey: .rowDestinationValue)
        let columnDestination = try value.decode(Int.self, forKey: .columnDestinationValue)
        
        self.init(owner: owner, rowOrigin: rowOrigin, columnOrigin: columnOrigin, rowDestination: rowDestination, columnDestination: columnDestination)
    }
}
