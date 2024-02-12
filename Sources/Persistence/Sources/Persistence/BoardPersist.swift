import Foundation
import Model

extension Board : Codable {
    
    enum Key: CodingKey {
        case grid
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Key.self)
        
        try container.encode(grid, forKey: .grid)
    }
    
    public init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: Key.self)
        let grid = try value.decode([[Cell]].self, forKey: .grid)
        
        self.init(grid: grid)!
    }
    
}
