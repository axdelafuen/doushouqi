//
//  debugTp2.swift
//  CommandLineTest
//
//  Created by etudiant on 01/02/2024.
//

import Foundation
import Model
import CommandLineExt

func debugTp2(){
    if var board {
        print("Nombre de piece pour player1 : ", board.countPieces(of: Owner.player1))
        print("Nombre de piece pour les 2 players : ", board.countPieces())
        
        var insertResult = board.insert(piece: Piece(owner:Owner.player1, animal: Animal.dog), atRow: 0, andColumn: 1)
        print("Insertion d'un 'dog' en 1,2 (should be 'ok') : ", insertResult)
        print(board)
        
        insertResult = board.insert(piece: Piece(owner:Owner.player1, animal: Animal.dog), atRow: 1, andColumn: 1)
        print("Insertion d'un 'dog' en 2,2 (should be 'failed') : ", insertResult)
        print(board)
    }
    else {
        print("ERROR : board not created !")
    }
}
