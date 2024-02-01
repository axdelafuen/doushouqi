//
//  trainingAI.swift
//  CommandLineTest
//
//  Created by etudiant on 01/02/2024.
//

import Foundation

import Model

public struct GameTraining{
    let dumb1:Player
    let dumb2:Player
    let moves:[Move]
    let winner:Owner
    
    init(dumb1: Player, dumb2: Player, moves: [Move], winner: Owner) {
        self.dumb1 = dumb1
        self.dumb2 = dumb2
        self.moves = moves
        self.winner = winner
    }
}

public func gamesGenerator() -> GameTraining? {
    var board = VerySimpleRules.createBoard()
    var rules = VerySimpleRules()
    
    // CHOOSE OPPONENT
    let dumb1 = SimpleAIPlayer(name: "STUPID1", id: Owner.player1)!
    let dumb2 = SimpleAIPlayer(name: "STUPID2", id: Owner.player2)!
    
    var currentMove:Move?
    
    var gameOver:(Bool, Result) = (false, Result.notFinished)
    
    while(!gameOver.0) {
        
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
        }
    }
    
    switch gameOver.1{
    case .winner(owner: .player1, winningReason: _):
        return GameTraining(dumb1: dumb1, dumb2: dumb2, moves: rules.historic, winner: Owner.player1)
    case .winner(owner: .player2, winningReason: _):
        return GameTraining(dumb1: dumb1, dumb2: dumb2, moves: rules.historic, winner: Owner.player2)
    default:
        return nil
    }
}

public func gameToCSV(game: GameTraining) -> String {
    var csvString = ""

    for move in game.moves {
        csvString += "\(move.owner),\(move.rowOrigin),\(move.columnOrigin),\(move.rowDestination),\(move.columnDestination),\(game.winner)"+"\n"
    }

    return csvString
}

func writeGamesToCSV(games: [GameTraining], filePath: String) {
    var csvString = "player,rowOrigin,columnOrigin,rowDestination,columnDestination,winner\n"

    for game in games {
        csvString += gameToCSV(game: game)
        csvString += "...,...,...,...,...,...\n"
    }

    do {
        try csvString.write(toFile: filePath, atomically: true, encoding: .utf8)
        print("csv correctly writed in :",filePath)
    } catch {
        print("Erreur lors de l'écriture du fichier CSV : \(error)")
    }
}

public func trainingAI(nbGameSample:Int){
    var games:[GameTraining] = Array()
    for _ in 0...nbGameSample {
        let game:GameTraining? = gamesGenerator()
        if let game {
            games.append(game)
        }
    }
    writeGamesToCSV(games: games, filePath: "./test.csv")
}
