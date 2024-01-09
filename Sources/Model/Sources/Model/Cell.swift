//
//  Cell.swift
//
//
//  Created by etudiant on 09/01/2024.
//

struct Cell : CustomStringConvertible {
    
    public let initialOwner:Owner
    
    public let cellType:CellType
    
    public let piece:Piece?
    
    init(cellType:CellType, owner: Owner = Owner.noOne, piece: Piece? = nil) {
        self.cellType = cellType
        self.initialOwner = owner
        self.piece = piece
    }
    
    // return string of the piece, its type and its owner
    var description : String {
        if let p = piece {
            return "\(p) on \(cellType), \(initialOwner)"
        }
        return "ø on \(cellType), \(initialOwner)"
    }
}
