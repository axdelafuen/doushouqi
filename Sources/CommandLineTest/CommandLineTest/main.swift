//
//  main.swift
//  CommandLineTest
//
//  Created by etudiant on 10/01/2024.
//

import Foundation
import Model
import CommandLineExt


func debugTp1() {
    
    let grid: [[Cell]] =
    [
        [Cell(cellType: CellType.jungle), Cell(cellType: CellType.jungle, owner:Owner.player1, piece: Piece(owner: Owner.player1, animal: Animal.cat)), Cell(cellType: CellType.jungle)],
        [Cell(cellType: CellType.jungle), Cell(cellType: CellType.jungle), Cell(cellType: CellType.jungle)],
        [Cell(cellType: CellType.jungle), Cell(cellType: CellType.jungle), Cell(cellType: CellType.jungle)],
        [Cell(cellType: CellType.jungle), Cell(cellType: CellType.jungle, owner:Owner.player2, piece: Piece(owner: Owner.player2, animal: Animal.cat)), Cell(cellType: CellType.jungle)],
    ]
    
    let board:Board? = Board(grid: grid)
    
    if let board {
        print(board)
    }
    else {
        print("ERROR : board not created !")
    }
}

debugTp1()
