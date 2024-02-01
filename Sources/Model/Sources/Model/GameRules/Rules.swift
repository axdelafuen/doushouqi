//
//  Rules.swift
//
//
//  Created by etudiant on 22/01/2024.
//

import Foundation

public protocol Rules{
    var occurences: [Board:Int] {get set}
    
    var historic : [Move] {get set}
    
    static func createBoard() -> Board
    
    static func checkBoard(board: Board) throws
    
    func getNextPlayer() -> Owner
    
    func getMoves(board:Board, owner:Owner) -> Array<Move>
    
    func getMoves(board:Board, owner:Owner, row:Int, column:Int) -> Array<Move>
    
    func isMoveValid(board: Board, rowOrigin: Int, columnOrigin: Int, rowDestination: Int, columnDestination: Int) -> Bool
    
    func isMoveValid(board:Board, move:Move) -> Bool
    
    func isGameOver(board:Board, row:Int, column:Int) -> (Bool, Result)
    
    mutating func playedMove(move:Move, oldBoard:Board, newBoard:Board)
}
