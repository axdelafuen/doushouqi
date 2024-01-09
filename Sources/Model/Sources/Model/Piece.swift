//
//  Piece.swift
//
//
//  Created by etudiant on 09/01/2024.
//

struct Piece : CustomStringConvertible{
    
    public let owner:Owner
    
    public let animal:Animal
    
    init(owner: Owner, animal: Animal) {
        self.owner = owner
        self.animal = animal
    }
    
    // return string of the owner and his animal
    var description : String {
        return "[\(owner):\(animal)]"
    }
}
