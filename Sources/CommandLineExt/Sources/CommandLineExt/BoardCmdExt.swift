//
//  BoardCmdExt.swift
//
//
//  Created by etudiant on 10/01/2024.
//

import Foundation
import Model

extension Board : CustomStringConvertible{
    public var description : String {
        var board:String = ""
        
        for i in 0...grid.count-1{
            for y in 0...grid[i].count-1{
                board += grid[i][y].cellType.symbol()
                if let piece = grid[i][y].piece {
                    board += piece.animal.symbol() + piece.owner.symbol()
                }
                board += " "
            }
            board += "\n"
        }
        
        return board
    }
}
