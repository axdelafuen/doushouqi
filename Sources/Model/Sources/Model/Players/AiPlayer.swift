//
//  AiPlayer.swift
//
//
//  Created by etudiant on 05/02/2024.
//

import Foundation

public class AiPlayer : Player {
    
    
    
    public struct GameTraining{
        let dumb1:Player
        let dumb2:Player
        let moves:[Move]
        let winner:Owner
        let rules:Rules
        
        init(dumb1: Player, dumb2: Player, moves: [Move], winner: Owner, rules:Rules) {
            self.dumb1 = dumb1
            self.dumb2 = dumb2
            self.moves = moves
            self.winner = winner
            self.rules = rules
        }
    }
    
    static let rowNotation:[Character] = ["A","B","C","D","E","F"]
    
    public static func gamesGenerator() -> GameTraining? {
        var rules:Rules!
        var winner:Owner = Owner.noOne
        
        // CHOOSE OPPONENT
        let dumb1 = SimpleAIPlayer(name: "STUPID1", id: Owner.player1)!
        let dumb2 = SimpleAIPlayer(name: "STUPID2", id: Owner.player2)!
        
        var game:Game = Game(rules: VerySimpleRules(), player1: dumb1, player2: dumb2)
        
        func onMoveDoneListener(move:Move, newRules:Rules){
            rules = newRules
        }
        func onGameStateChangedListener(result:Result){
            switch(result){
            case .winner(let owner, _):
                winner = owner
            default:
                winner = Owner.noOne
            }
        }
        
        game.addMoveDoneListener(listener: onMoveDoneListener)
        game.addGameStateListener(listener: onGameStateChangedListener)
        game.start()
        
        switch (winner){
        case .noOne:
            return nil
        default:
            return GameTraining(dumb1: dumb1, dumb2: dumb2, moves: rules.historic, winner: winner, rules: rules)
        }
    }
    
    public static func gameToCSV(game: GameTraining, gameNb: Int) -> String {
        var moveString = ""
        var count = 1
        // HANDLE THE EATING POSSIBILITY
        
        // ADD THE PIECE THAT IS MOVING
        for move in game.moves {
            moveString += "\(rowNotation[move.rowDestination])\(move.columnDestination+1) "
            count += 1
        }
        
        return "\(gameNb),\(count),\(moveString),\(game.winner)"
    }
    
    public static func writeGamesToCSV(games: [GameTraining], filePath: String) {
        var csvString:String = "gameNb,roundNb,moves,winner\n"
        var countGame:Int = 1
        
        for game in games {
            //csvString += "player,gameNb,roundNb,rowOrigin,columnOrigin,rowDestination,columnDestination,winner\n"
            csvString += gameToCSV(game: game, gameNb: countGame)
            csvString += "\n"
            countGame += 1
        }
        
        do {
            try csvString.write(toFile: filePath, atomically: true, encoding: .utf8)
            print("csv correctly writed in :",filePath)
        } catch {
            print("Erreur lors de l'écriture du fichier CSV : \(error)")
        }
    }
    
    public static func trainingAI(nbGameSample:Int){
        var games:[GameTraining] = Array()
        for _ in 0...nbGameSample {
            let game:GameTraining? = gamesGenerator()
            if let game {
                games.append(game)
            }
        }
        writeGamesToCSV(games: games, filePath: "./gamesSample.csv")
    }
}

public extension Animal {
    var notation: String {
        switch self {
        case .rat:
            return "S"
        case .cat:
            return "M"
        case .dog:
            return "C"
        case .wolf:
            return "W"
        case .leopard:
            return "P"
        case .tiger:
            return "T"
        case .lion:
            return "L"
        case .elephant:
            return "E"
        }
    }
}
