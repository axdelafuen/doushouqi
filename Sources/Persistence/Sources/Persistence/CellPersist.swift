import Foundation
import Model

extension Cell : Codable {
    enum Key: CodingKey {
        case initialOwner
        case cellType
        case piece
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Key.self)
        try container.encode(initialOwner, forKey: .initialOwner)
        try container.encode(cellType, forKey: .cellType)
        try container.encode(piece, forKey: .piece)
    }
    
    public init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: Key.self)
        let initialOwner = try value.decode(Owner.self, forKey: .initialOwner)
        let cellType = try value.decode(CellType.self, forKey: .cellType)
        let piece:Piece? = try value.decode(Piece?.self, forKey: .piece)
        
        self.init(cellType: cellType, owner: initialOwner, piece: piece)
    }
}
