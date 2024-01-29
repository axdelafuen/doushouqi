//
//  HumanPlayer.swift
//
//
//  Created by etudiant on 29/01/2024.
//

import Foundation

public class HumanPlayer: Player {
    
    public let input :(HumanPlayer)
    
    public init?(name: String, id : Owner, inputMethod: (HumanPlayer)){
        self.input = inputMethod
        super.init(name: name, id: id)
    }
    
    override public func chooseMove(board: Board, rules: Rules) -> Move {
        //TODO
        fatalError()
    }
}
