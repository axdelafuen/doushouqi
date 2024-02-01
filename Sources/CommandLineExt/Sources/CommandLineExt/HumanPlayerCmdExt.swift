//
//  HumanPlayerCmdExt.swift
//
//
//  Created by etudiant on 01/02/2024.
//

import Foundation
import Model

public extension HumanPlayer {
    func chooseAmongAvalaibleMove(board: Board, rules: Rules) -> Move? {
        print("Joueur \(self.name), veuillez entrer votre mouvement parmis la liste :")
        
        let moves:[Move] = rules.getMoves(board: board, owner: self.id)
        
        for index in 0..<moves.count {
            print(index,"-", moves[index],"-",index)
        }

        
        if let userInput = readLine() {
            let value = Int(userInput) ?? -1
            if value == -1 {
                return nil
            }
            return moves[value]
        }
        return nil
    }
}
