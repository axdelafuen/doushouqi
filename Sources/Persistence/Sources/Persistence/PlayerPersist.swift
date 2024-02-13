import Foundation
import Model


internal struct InputMethodData: Codable {
    let functionPointer: UnsafeMutableRawPointer
    
    public init(functionPointer: UnsafeMutableRawPointer) {
        self.functionPointer = functionPointer
    }
    
    enum Key: CodingKey {
        case inputMethodPtr
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Key.self)
        let pointerValue = UInt(bitPattern: functionPointer)
        try container.encode(pointerValue, forKey: .inputMethodPtr)

    }
    
    public init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: Key.self)
        let pointerValue = try value.decode(UInt.self, forKey: .inputMethodPtr)
        let inputMethodPtr = UnsafeMutableRawPointer(bitPattern: pointerValue)
        
        guard let unwrappedPtr = inputMethodPtr else {
            throw DecodingError.dataCorruptedError(forKey: .inputMethodPtr, in: value, debugDescription: "Failed to decode UnsafeMutableRawPointer")
        }
        
        self.init(functionPointer: unwrappedPtr)
    }
}

/*
extension Player: Codable {
    
    enum Key: CodingKey {
        case ownerId
        case nameValue
        case inputMethodData
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Key.self)
        
        try container.encode(id, forKey: .ownerId)
        try container.encode(name, forKey: .nameValue)
        if self is HumanPlayer {
            let inputMethodData = InputMethodData(functionPointer: UnsafeMutableRawPointer(mutating: unsafeBitCast((self as! HumanPlayer).input, to: UnsafeRawPointer.self)))
            try container.encode(inputMethodData, forKey: .inputMethodData)
        }
    }
    
    public convenience init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: Key.self)
        let owner = try value.decode(Owner.self, forKey: .ownerId)
        let name = try value.decode(String.self, forKey: .nameValue)
        /*
         if self is HumanPlayer {
         let inputMethodData = try value.decode(InputMethodData.self, forKey: .inputMethodData)
         let input = unsafeBitCast(inputMethodData.functionPointer, to: ((HumanPlayer) -> Move).self)
         (self as! HumanPlayer).init(name: name, id: owner, inputMethod: input)
         }
         */
        self.init(name:name, id:owner)!
    }
}
*/
