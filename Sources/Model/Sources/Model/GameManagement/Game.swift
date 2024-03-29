//
//  Game.swift
//
//
//  Created by etudiant on 30/01/2024.
//

import Foundation

public struct Game{
    public private(set) var rules:Rules
    public private(set) var board:Board
    public let player1:Player
    public let player2:Player
    
    // game is starting event
    private var gameStartCallback:[(Board)->Void] = []
    public mutating func addGameStartListener(listener:@escaping (Board) -> Void){
        gameStartCallback.append(listener)
    }

    // save the game
    private var saveGameCallback:[(Game) -> Void] = []
    public mutating func addSaveGameListener(listener:@escaping (Game) -> Void){
        saveGameCallback.append(listener)
    }
    
    // next turn, current plyer changed event
    private var nextPlayerCallback:[(Player)->Void] = []
    public mutating func addNextPlayerListener(listener:@escaping (Player) -> Void) {
        nextPlayerCallback.append(listener)
    }
    
    // game state event
    private var gameStateCallback:[(Result)->Void] = []
    public mutating func addGameStateListener(listener:@escaping (Result) -> Void) {
        gameStateCallback.append(listener)
    }
    
    // move chosen event
    private var moveChosedCallback:[(Move)->Void] = []
    public mutating func addMoveChosedListener(listener:@escaping (Move) -> Void){
        moveChosedCallback.append(listener)
    }
    
    // move done event
    private var moveDoneCallback:[(Move, Rules)->Void] = []
    public mutating func addMoveDoneListener(listener:@escaping (Move, Rules)->Void){
        moveDoneCallback.append(listener)
    }
    
    // invalid move event
    private var invalidMoveCallback:[(Move)->Void] = []
    public mutating func addInvalidMoveListener(listener:@escaping (Move)->Void){
        invalidMoveCallback.append(listener)
    }
    
    // board changed event
    private var boardChangedCallback:[(Board)->Void] = []
    public mutating func addBoardChangedListener(listener:@escaping (Board)->Void){
        boardChangedCallback.append(listener)
    }
    
    // piece removed (eated) event
    private var pieceRemovedCallback:[(Piece)->Void] = []
    public mutating func addPieceRemovedListener(listener:@escaping (Piece)->Void){
        pieceRemovedCallback.append(listener)
    }
    
    // piece inserted event
    private var pieceInsertedCallback:[(Piece)->Void] = []
    public mutating func addPieceInsertedListener(listener:@escaping (Piece)->Void){
        pieceInsertedCallback.append(listener)
    }
    
    public init(rules:Rules, player1:Player, player2:Player, board:Board? = nil){
        self.rules = rules
        self.player1 = player1
        self.player2 = player2
        if let board {
            self.board = board
        }
        else{
            self.board = type(of: rules).createBoard()
        }
    }
    
    public mutating func start(){
        for callback in gameStartCallback {
            callback(board)
        }
        
        var currentMove:Move?
        var currentPlayer:Player
        var gameOver:(Bool, Result) = (false, Result.notFinished)
        
        // save game callback
        for callback in saveGameCallback {
            callback(self)
        }
        
        while(!gameOver.0) {
            let oldBoard = board
            
            currentPlayer = rules.getNextPlayer() == player1.id ? player1 : player2
            
            for callback in nextPlayerCallback {
                callback(currentPlayer)
            }
            
            currentMove = currentPlayer.chooseMove(board: board, rules: rules)
            
            for callback in moveChosedCallback {
                callback(currentMove!)
            }
            
            if !rules.isMoveValid(board: board, move: currentMove!) {
                for callback in invalidMoveCallback {
                    callback(currentMove!)
                }
                currentMove = nil
            }
            
            if let move = currentMove {
                // HANDLE RETURN VALUE OF THE BOARD
                let firstRemoveResult:BoardResult = board.removePiece(atRow: move.rowDestination, andColumn: move.columnDestination)
                let insertedResult:BoardResult = board.insert(piece: board.grid[move.rowOrigin][move.columnOrigin].piece!, atRow: move.rowDestination, andColumn: move.columnDestination)
                let secondInsertedRemovedResult:BoardResult = board.removePiece(atRow: move.rowOrigin, andColumn: move.columnOrigin)
                
                if firstRemoveResult == BoardResult.ok {
                    for callback in pieceRemovedCallback{
                        callback(oldBoard.grid[move.rowDestination][move.columnDestination].piece!)
                    }
                }
                
                if secondInsertedRemovedResult == BoardResult.ok && insertedResult == BoardResult.ok {
                    for callback in pieceInsertedCallback{
                        callback(oldBoard.grid[move.rowOrigin][move.columnOrigin].piece!)
                    }
                }
                
                rules.playedMove(move: move, oldBoard: oldBoard, newBoard: board)
                
                for callback in moveDoneCallback {
                    callback(move, rules)
                }
                for callback in boardChangedCallback {
                    callback(board)
                }
                for callback in saveGameCallback {
                    callback(self)
                }
                gameOver = rules.isGameOver(board: board, row: move.rowDestination, column: move.columnDestination)
            }
            
            for callback in gameStateCallback {
                callback(gameOver.1)
            }
        }
    }
}
