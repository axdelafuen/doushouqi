//
//  SimpleAIPlayer.swift
//
//
//  Created by etudiant on 01/02/2024.
//

import Foundation

public class SimpleAIPlayer: Player {
    override public func chooseMove(board: Board, rules: Rules) -> Move?{
        // Get all moves
        let moves:[Move] = rules.getMoves(board: board, owner: self.id)
        
        // Check if there is at least one move
        if moves.count == 0 { return nil; }
        
        // Check if a move can win the game by reaching the opponent den, in moves tab
        for move in moves {
            if board.grid[move.rowDestination][move.columnDestination].cellType == CellType.den {
                // Return the move
                return move
            }
        }
        
        // Check if a move can eat an opponent piece, in moves tab
        for move in moves {
            if let _ = board.grid[move.rowDestination][move.columnDestination].piece {
                // Return the move
                return move
            }
        }
        // Play a random move
        return moves[Int(UInt32.random(in: 0..<UInt32(moves.count)))]
    }
}
