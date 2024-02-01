//
//  Player.swift
//
//
//  Created by etudiant on 29/01/2024.
//

import Foundation

public class Player {
    public let id:Owner
    
    public let name:String
    
    public init?(name: String, id: Owner){
        if id == Owner.noOne {
            return nil
        }
        self.name = name
        self.id = id
    }
    
    public func chooseMove(board: Board, rules: Rules) -> Move? {
        return nil
    }
}
