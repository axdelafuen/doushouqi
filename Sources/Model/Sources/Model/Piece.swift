//
//  Piece.swift
//
//
//  Created by etudiant on 09/01/2024.
//

import Foundation

public struct Piece : CustomStringConvertible, Equatable, Hashable{
    
    public let owner:Owner
    
    public let animal:Animal
    
    public init(owner: Owner, animal: Animal) {
        self.owner = owner
        self.animal = animal
    }
    
    // return string of the owner and his animal
    public var description : String {
        return "[\(owner):\(animal)]"
    }
}
