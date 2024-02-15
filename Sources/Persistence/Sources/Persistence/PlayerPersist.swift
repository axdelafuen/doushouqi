import Foundation
import Model


public struct PlayerDatas: Codable {
    
    public let id:Owner
    public let name:String
    public let playerType:String
    
    public init(name: String, id: Owner, playerType:String){
        self.name = name
        self.id = id
        self.playerType = playerType
    }
    
    public func toObject(input:((HumanPlayer) -> Move)?) -> Player? {
        switch playerType{
        case "HumanPlayer":
            if let input{
                return HumanPlayer(name: name, id: id, inputMethod: input)
            }
            else{
                return nil
            }
        case "SimpleAIPlayer":
            return SimpleAIPlayer(name: name, id: id)
        case "RandomPlayer":
            return RandomPlayer(name: name, id: id)
        default:
            return nil
        }
    }
    
    enum Key: CodingKey {
        case ownerId
        case nameValue
        case playerType
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Key.self)
        
        try container.encode(id, forKey: .ownerId)
        try container.encode(name, forKey: .nameValue)
        try container.encode(playerType, forKey: .playerType)
    }
    
    public init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: Key.self)
        let owner = try value.decode(Owner.self, forKey: .ownerId)
        let name = try value.decode(String.self, forKey: .nameValue)
        let playerType = try value.decode(String.self, forKey: .playerType)

        self.init(name:name, id:owner, playerType: playerType)
    }
}

extension Player {
    public func toData() -> PlayerDatas{
        var playerType: String
        
        switch self {
        case is HumanPlayer:
            playerType = "HumanPlayer"
        case is SimpleAIPlayer:
            playerType = "SimpleAIPlayer"
        case is RandomPlayer:
            playerType = "RandomPlayer"
        default:
            playerType = "unknown"
        }
        
        return PlayerDatas(name: self.name, id: self.id, playerType: playerType)
    }
}

