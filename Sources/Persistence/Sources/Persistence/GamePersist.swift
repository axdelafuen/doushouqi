import Foundation
import Model

extension Game : Codable {
        
    enum Key: CodingKey {
        case rules
        case board
        case player1
        case player2
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Key.self)
        
        try container.encode(rules.toData(), forKey: .rules)
        try container.encode(board, forKey: .board)
        try container.encode(player1.toData(), forKey: .player1)
        try container.encode(player2.toData(), forKey: .player2)
    }
    
    public init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: Key.self)
        let rules = try value.decode(RulesDatas.self, forKey: .rules)
        let board = try value.decode(Board.self, forKey: .board)
        let dataPlayer1 = try value.decode(PlayerDatas.self, forKey: .player1)
        let dataPlayer2 = try value.decode(PlayerDatas.self, forKey: .player2)
        
        let player1:Player?
        let player2:Player?
        
        switch dataPlayer1.playerType{
        case "HumanPlayer":
            player1 = dataPlayer1.toObject(input: nil)
        default:
            player1 = dataPlayer1.toObject(input: nil)
        }

        switch dataPlayer2.playerType{
        case "HumanPlayer":
            player2 = dataPlayer2.toObject(input: nil)
        default:
            player2 = dataPlayer2.toObject(input: nil)
        }
        
        if let player1, let player2 {
            self.init(rules: rules.toObject()!, player1: player1, player2: player2, board: board)
        }
        self.init(rules: rules.toObject()!, player1: player1!, player2: player2!, board: board)
    }
}

