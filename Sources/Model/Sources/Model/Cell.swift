//
//  Cell.swift
//
//
//  Created by etudiant on 09/01/2024.
//

import Foundation

public struct Cell : CustomStringConvertible {
    
    public let initialOwner:Owner
    
    public let cellType:CellType
    
    public internal(set) var piece:Piece?
    
    public init(cellType:CellType, owner: Owner = Owner.noOne, piece: Piece? = nil) {
        self.cellType = cellType
        self.initialOwner = owner
        self.piece = piece
    }
    
    // return string of the piece, its type and its owner
    public var description : String {
        // en une ligne ?? (marche pas)
        // return "\(piece ?? "ø") on \(cellType), \(initialOwner)"
        
        if let p = piece {
            return "\(p) on \(cellType), \(initialOwner)"
        }
        return "ø on \(cellType), \(initialOwner)"
    }
}
