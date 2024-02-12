import Foundation
import Model

public struct RulesDatas: Codable {
    let occurences: [Board:Int]
    let historic: [Move]
    let rulesType: String
    
    public init(occurences: [Board : Int], historic: [Move], rulesType: String) {
        self.occurences = occurences
        self.historic = historic
        self.rulesType = rulesType
    }
    
    public func toObject() -> Rules? {
        switch rulesType {
        case "VerySimpleRules":
            var rules = VerySimpleRules()
            rules.occurences = occurences
            rules.historic = historic
            return rules
        default:
            return nil
        }
    }

    enum Key: CodingKey {
        case occurences
        case historic
        case rulesType
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Key.self)
        
        try container.encode(occurences, forKey: .occurences)
        try container.encode(historic, forKey: .historic)
        try container.encode(rulesType, forKey: .rulesType)
    }
    
    public init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: Key.self)
        let occurences = try value.decode([Board:Int].self, forKey: .occurences)
        let historic = try value.decode([Move].self, forKey: .historic)
        let rulesType = try value.decode(String.self, forKey: .rulesType)
        
        self.init(occurences: occurences, historic: historic, rulesType: rulesType)
    }
    
    
}

extension Rules{
    public func toData() -> RulesDatas{
        var rulesType: String
        
        switch self {
        case is VerySimpleRules:
            rulesType = "VerySimpleRules"
        default:
            rulesType = "unknown"
        }
        
        return RulesDatas(occurences: self.occurences, historic: self.historic, rulesType: rulesType)
    }
}
