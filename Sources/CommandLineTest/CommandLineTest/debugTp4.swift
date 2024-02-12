//
//  debugTp4.swift
//  CommandLineTest
//
//  Created by etudiant on 01/02/2024.
//

import Foundation
import Model
import CommandLineExt


public func debugTp4() {
    let board = VerySimpleRules.createBoard()
    
    print(board)
    
    let sa:Player? = RandomPlayer(name: "Supidité Artificielle", id: Owner.player1)
    
    if let sa {
        print(sa.chooseMove(board: board, rules: VerySimpleRules())!)
    }

    //let player:Player? = HumanPlayer(name: "GROSLARDON", id: Owner.player2, inputMethod: )
}


public func two_dumb_AI_Game() async throws {
    var board = VerySimpleRules.createBoard()
    var rules = VerySimpleRules()
    let dumb1 = RandomPlayer(name: "STUPID 1", id: Owner.player1)!
    let dumb2 = RandomPlayer(name: "STUPID 2", id: Owner.player2)!
    
    var currentMove:Move?
    
    var counter = 1
    
    var gameOver:(Bool, Result) = (false, Result.notFinished)
    while(!gameOver.0) {
        print("---------- Tour : ", counter, "(", rules.getNextPlayer(),")" , " ----------")
        print(board)
        let oldBoard = board
        if rules.getNextPlayer() == dumb1.id {
            currentMove = dumb1.chooseMove(board: board, rules: rules)
        }
        else {
            currentMove = dumb2.chooseMove(board: board, rules: rules)
        }
        // ya t il un move ?
        if let move = currentMove {
            _ = board.removePiece(atRow: move.rowDestination, andColumn: move.columnDestination)
            _ = board.insert(piece: board.grid[move.rowOrigin][move.columnOrigin].piece!, atRow: move.rowDestination, andColumn: move.columnDestination)
            _ = board.removePiece(atRow: move.rowOrigin, andColumn: move.columnOrigin)
            
            rules.playedMove(move: move, oldBoard: oldBoard, newBoard: board)
            
            gameOver = rules.isGameOver(board: board, row: move.rowDestination, column: move.columnDestination)
            
            counter += 1
        }
        //try await Task.sleep(nanoseconds: UInt64(0.2*(pow(10.0, 9))))
    }
    print(gameOver.1)
    print(board)
}

public func simple_AI_vs_random_Game() async throws {
    var board = VerySimpleRules.createBoard()
    var rules = VerySimpleRules()
    let dumb1 = SimpleAIPlayer(name: "STUPID 1", id: Owner.player1)!
    let dumb2 = RandomPlayer(name: "STUPID 2", id: Owner.player2)!
    
    var currentMove:Move?
    
    var counter = 1
    
    var gameOver:(Bool, Result) = (false, Result.notFinished)
    while(!gameOver.0) {
        print("---------- Tour : ", counter, "(", rules.getNextPlayer(),")" , " ----------")
        print(board)
        let oldBoard = board
        if rules.getNextPlayer() == dumb1.id {
            currentMove = dumb1.chooseMove(board: board, rules: rules)
        }
        else {
            currentMove = dumb2.chooseMove(board: board, rules: rules)
        }
        // ya t il un move ?
        if let move = currentMove {
            _ = board.removePiece(atRow: move.rowDestination, andColumn: move.columnDestination)
            _ = board.insert(piece: board.grid[move.rowOrigin][move.columnOrigin].piece!, atRow: move.rowDestination, andColumn: move.columnDestination)
            _ = board.removePiece(atRow: move.rowOrigin, andColumn: move.columnOrigin)
            
            rules.playedMove(move: move, oldBoard: oldBoard, newBoard: board)
            
            gameOver = rules.isGameOver(board: board, row: move.rowDestination, column: move.columnDestination)
            
            counter += 1
        }
        //try await Task.sleep(nanoseconds: UInt64(0.2*(pow(10.0, 9))))
    }
    print(gameOver.1)
    print(board)
}

func userInputMethod(player: HumanPlayer) -> Move {
    print("\(player.name), veuillez entrer votre mouvement :")
    
    var rowOrigin:Int = -1; var columnOrigin:Int = -1; var rowDestination:Int = -1; var columnDestination:Int = -1
    
    print("Ligne d'origine : ")
    if let inputRowOrigin = readLine() {
        let value = Int(inputRowOrigin) ?? -1
        if value == -1 {
            fatalError("Only numbers can be input")
        }
        rowOrigin = value
    }
    
    print("Colonne d'origine : ")
    if let inputColumnOrigin = readLine() {
        let value = Int(inputColumnOrigin) ?? -1
        if value == -1 {
            fatalError("Only numbers can be input")
        }
        columnOrigin = value
    }
    
    print("Ligne de destination : ")
    if let inputRowDest = readLine() {
        let value = Int(inputRowDest) ?? -1
        if value == -1 {
            fatalError("Only numbers can be input")
        }
        rowDestination = value
    }
    
    print("Colonne de destination : ")
    if let inputColumnDest = readLine() {
        let value = Int(inputColumnDest) ?? -1
        if value == -1 {
            fatalError("Only numbers can be input")
        }
        columnDestination = value
    }
    
    return Move(owner: player.id, rowOrigin: rowOrigin, columnOrigin: columnOrigin, rowDestination: rowDestination, columnDestination: columnDestination)
}

public func testHumanVsRandom() async throws {
    var board = VerySimpleRules.createBoard()
    var rules = VerySimpleRules()
    let player = HumanPlayer(name: "PLAYER", id: Owner.player1, inputMethod: userInputMethod)!
    // CHOOSE OPPONENT
    let dumb = SimpleAIPlayer(name: "STUPID", id: Owner.player2)!
    //let dumb = RandomPlayer(name: "STUPID", id: Owner.player2)!
    
    var currentMove:Move?
    
    var counter = 1
    
    var gameOver:(Bool, Result) = (false, Result.notFinished)
    while(!gameOver.0) {
        print("---------- Tour :", counter, "(", rules.getNextPlayer().symbol,")" , " ----------")
        print(board)
        let oldBoard = board
        if rules.getNextPlayer() == dumb.id {
            currentMove = dumb.chooseMove(board: board, rules: rules)
        }
        else {
            // CHOOSE INPUT METHOD (only in console)
            currentMove = player.chooseMove(board: board, rules: rules)
            if !rules.isMoveValid(board: board, move: currentMove!) {
                currentMove = nil
            }
            //currentMove = player.chooseAmongAvalaibleMove(board: board, rules: rules)
        }
        // ya t il un move ?
        if let move = currentMove {
            _ = board.removePiece(atRow: move.rowDestination, andColumn: move.columnDestination)
            _ = board.insert(piece: board.grid[move.rowOrigin][move.columnOrigin].piece!, atRow: move.rowDestination, andColumn: move.columnDestination)
            _ = board.removePiece(atRow: move.rowOrigin, andColumn: move.columnOrigin)
            
            rules.playedMove(move: move, oldBoard: oldBoard, newBoard: board)
            
            gameOver = rules.isGameOver(board: board, row: move.rowDestination, column: move.columnDestination)
            
            counter += 1
        }
        //try await Task.sleep(nanoseconds: UInt64(1*(pow(10.0, 9))))
    }
    print(gameOver.1)
    print(board)
}
