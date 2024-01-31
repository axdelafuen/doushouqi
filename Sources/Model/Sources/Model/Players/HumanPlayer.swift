//
//  HumanPlayer.swift
//
//
//  Created by etudiant on 29/01/2024.
//

import Foundation

public class HumanPlayer: Player {
    
    public let input:(HumanPlayer, Rules, Board) -> Move?
    
    public init?(name: String, id: Owner, inputMethod: @escaping (HumanPlayer, Rules, Board) -> Move?){
        self.input = inputMethod
        super.init(name: name, id: id)
    }
    
    override public func chooseMove(board: Board, rules: Rules) -> Move? {
        return self.input(self, rules, board)
    }
}
