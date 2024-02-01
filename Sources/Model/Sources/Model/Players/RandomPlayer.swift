//
//  RandomPlayer.swift
//
//
//  Created by etudiant on 29/01/2024.
//

import Foundation

public class RandomPlayer: Player {
    override public func chooseMove(board: Board, rules: Rules) -> Move?{
        // Get all moves
        let moves:[Move] = rules.getMoves(board: board, owner: self.id)
        
        // Check if there is at least one move
        if moves.count == 0 { return nil; }
        
        // Choose a random number in moves tab, and return the selected move
        return moves[Int(UInt32.random(in: 0..<UInt32(moves.count)))]
    }
}
