//
//  HumanPlayer.swift
//
//
//  Created by etudiant on 29/01/2024.
//

import Foundation

public class HumanPlayer: Player {
    
    public let input:(HumanPlayer) -> Move
    
    public init?(name: String, id: Owner, inputMethod: @escaping (HumanPlayer) -> Move){
        self.input = inputMethod
        super.init(name: name, id: id)
    }
    
    override public func chooseMove(board: Board, rules: Rules) -> Move? {
        let inputMove:Move = self.input(self)
        
        if rules.isMoveValid(board: board, move: inputMove) {
            return inputMove
        }
        
        return nil
    }
}
