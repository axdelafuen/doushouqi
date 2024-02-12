import Foundation
import Model

extension Piece : Codable {
    enum Key: CodingKey {
        case owner
        case animal
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Key.self)
        try container.encode(owner, forKey: .owner)
        try container.encode(animal, forKey: .animal)
    }
    
    public init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: Key.self)
        let owner = try value.decode(Owner.self, forKey: .owner)
        let animal = try value.decode(Animal.self, forKey: .animal)
        self.init(owner: owner, animal: animal)
    }
}
