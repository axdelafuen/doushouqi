//
//  debugTp3.swift
//  CommandLineTest
//
//  Created by etudiant on 01/02/2024.
//

import Foundation
import Model
import CommandLineExt

func debugTp3(){
    let board = VerySimpleRules.createBoard()
    
    print(board)
    
    do {
        try VerySimpleRules.checkBoard(board: board)
        print("No errors")
    }catch InvalidBoardError.badCellType(_, _, _) {
        print("Bad cell type")
    }catch InvalidBoardError.badDimensions(_, _) {
        print("Bad cell dimension")
    }catch InvalidBoardError.multipleOccurencesOfSamePiece(_) {
        print("multiple occurences of same piece")
    }catch InvalidBoardError.pieceNotAllowedOnThisCell(_, _) {
        print("Piece not allowed on this cell")
    }catch InvalidBoardError.pieceWithNoOwner(_) {
        print("Piece with no owner")
    }catch {
        print("Unknown error")
    }
    
    let rules:VerySimpleRules = VerySimpleRules()
    
    print(rules.getMoves(board: board, owner: Owner.player1))
    
    print("////////")
    
    print(rules.getMoves(board: board, owner: Owner.player1, row: 0, column: 1))
    
    let move:Move = Move(owner: rules.getNextPlayer(), rowOrigin: 0, columnOrigin: 1, rowDestination: 1, columnDestination: 1)
    print(rules.isMoveValid(board: board, move: move))
    
    // 1
    //print(rules.getNextPlayer())
    //rules.playedMove(move: move, oldBoard: board, newBoard: board)
    //2
    //print(rules.getNextPlayer())

    // test animals weights
    if Animal.dog <= Animal.rat {
        print("success")
    }
    else {
        print("failed")
    }
    
}
