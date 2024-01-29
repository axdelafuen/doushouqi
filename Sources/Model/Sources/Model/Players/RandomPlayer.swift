//
//  RandomPlayer.swift
//
//
//  Created by etudiant on 29/01/2024.
//

import Foundation

public class RandomPlayer: Player {
    override public func chooseMove(board: Board, rules: Rules) -> Move{
        // Get all moves
        let moves:[Move] = rules.getMoves(board: board, owner: self.id)
        
        // Choose a random number in moves tab
        let chosenMoveIndex = Int(arc4random_uniform(UInt32(moves.count-1)))
        
        // Return the move
        return moves[chosenMoveIndex]
    }
}
