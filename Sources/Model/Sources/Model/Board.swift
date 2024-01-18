//
//  Board.swift
//
//
//  Created by etudiant on 10/01/2024.
//

import Foundation

public struct Board {
    
    public let nbRows:Int
    
    public let nbColumns:Int
    
    public private(set) var grid: [[Cell]] // suffisant car c'est une struct (pas de ref)
    
    // ameliorable
    public init?(grid: [[Cell]]) {
        if(grid.isEmpty) {
            return nil
        }
        
        var rows:Int = 0
        
        for i in 0...grid.count-1 {
            if grid[i].count != grid[0].count {
                return nil
            }
            rows += 1
        }
        
        self.nbRows = rows
        self.nbColumns = grid[0].count
        self.grid = grid
    }
    
    // Compte le nombre de pieces de la grid, pour un player donné
    public func countPieces(of:Owner) -> Int {
        return grid.flatMap { $0 } // Aplatir la grille
            .filter { $0.piece?.owner == of } // Filtrer les cellules par propriétaire
            .count
    }
    
    // Compte le nombre de pieces total de la grid, pour les 2 player
    public func countPieces() -> (player1 : Int, player2 : Int) {
        return (countPieces(of: Owner.player1), countPieces(of: Owner.player2))
    }
    
    // Insert une piece, à la ligne et colonne passer en parametre
    mutating public func insert(piece:Piece, atRow row:Int, andColumn column:Int) -> BoardResult {
        
        if row > nbRows || column > nbColumns {
            return BoardResult.failed(reason: BoardFailingReason.outOfBounds)
        }
        
        guard grid[row][column].piece == nil else {
            return BoardResult.failed(reason: BoardFailingReason.cellNotEmpty)
        }
        
        grid[row][column] = Cell(cellType: grid[row][column].cellType, owner: grid[row][column].initialOwner, piece: piece)
        return BoardResult.ok
    }
    
    // Supprime une piece, à la ligne et colonne passer en parametre
    mutating public func removePiece(atRow row:Int, andColumn column:Int) -> BoardResult {
        
        guard row <= nbRows && column <= nbColumns else {
            return BoardResult.failed(reason: BoardFailingReason.outOfBounds)
        }
        
        if grid[row][column].piece == nil {
            return BoardResult.failed(reason: BoardFailingReason.cellEmpty)
        }
        
        grid[row][column] = Cell(cellType: grid[row][column].cellType)
        return BoardResult.ok
    }
}
