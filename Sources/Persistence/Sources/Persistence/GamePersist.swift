import Foundation
import Model

/*
extension Game : Codable {
    
    enum Key: CodingKey {
        case rules
        case board
        case player1
        case player2
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Key.self)
        
        try container.encode(rules, forKey: .rules)
        try container.encode(board, forKey: .board)
        try container.encode(player1, forKey: .player1)
        try container.encode(player2, forKey: .player2)
    }
    
    public init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: Key.self)
        let rules = try value.decode(Rules.self, forKey: .rules)
        let board = try value.decode(Board.self, forKey: .board)
        let player1 = try value.decode(Player.self, forKey: .player1)
        let player2 = try value.decode(Player.self, forKey: .player2)
        
        self.init(rules: rules, player1: player1, player2: player2, board: board)
    }
}
*/
