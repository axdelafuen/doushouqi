//
//  Game.swift
//
//
//  Created by etudiant on 30/01/2024.
//

import Foundation

public struct Game{
    private var rules:Rules
    private var board:Board
    private let player1:Player
    private let player2:Player
    
    private var gameStartCallback:[(Board)->Void] = []
    public mutating func addGameStartListener(listener:@escaping (Board) -> Void){
        gameStartCallback.append(listener)
    }
    
    private var nextPlayerCallback:[(Player, Board)->Void] = []
    public mutating func addNextPlayerListener(listener:@escaping (Player, Board) -> Void) {
        nextPlayerCallback.append(listener)
    }
    
    private var gameStateCallback:[(Result)->Void] = []
    public mutating func addGameStateListener(listener:@escaping (Result) -> Void) {
        gameStateCallback.append(listener)
    }
    
    public init(rules:Rules, player1:Player, player2:Player){
        self.rules = rules
        self.player1 = player1
        self.player2 = player2
        self.board = type(of: rules).createBoard()
    }
    
    public mutating func start(){
        for callback in gameStartCallback {
            callback(board)
        }
        
        var currentMove:Move?
        var gameOver:(Bool, Result) = (false, Result.notFinished)
        
        while(!gameOver.0) {
            let oldBoard = board
            
            if rules.getNextPlayer() == player1.id {
                for callback in nextPlayerCallback {
                    callback(player1, board)
                }
                currentMove = player1.chooseMove(board: board, rules: rules)
            }
            else {
                for callback in nextPlayerCallback {
                    callback(player2, board)
                }
                currentMove = player2.chooseMove(board: board, rules: rules)
            }
            
            // MOVE CHOSEN EVENT
            
            if !rules.isMoveValid(board: board, move: currentMove!) {
                currentMove = nil
            }
            
            if let move = currentMove {
                // HANDLE RETURN VALUE OF THE BOARD
                _ = board.removePiece(atRow: move.rowDestination, andColumn: move.columnDestination)
                _ = board.insert(piece: board.grid[move.rowOrigin][move.columnOrigin].piece!, atRow: move.rowDestination, andColumn: move.columnDestination)
                _ = board.removePiece(atRow: move.rowOrigin, andColumn: move.columnOrigin)
                
                rules.playedMove(move: move, oldBoard: oldBoard, newBoard: board)
                // BOARD CHANGED EVENT
                
                gameOver = rules.isGameOver(board: board, row: move.rowDestination, column: move.columnDestination)
                
                // MOVE DONE EVENT
            }
            else {
                // INVALID MOVE EVENT
            }
            
            for callback in gameStateCallback {
                callback(gameOver.1)
            }
        }
    }
}
