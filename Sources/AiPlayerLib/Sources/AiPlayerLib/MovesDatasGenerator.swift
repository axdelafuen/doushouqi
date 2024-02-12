import Foundation
import Model


let rowNotation:[Character] = ["A","B","C","D","E","F"]

public func gamesGenerator() -> GameDatas? {
    var rules:Rules!
    var winner:Owner = Owner.noOne
    
    var insertedPiece:Piece? = nil
    var removedPiece:Piece? = nil
    
    var csvMoves:String = ""
    
    // CHOOSE OPPONENT
    let dumb1 = SimpleAIPlayer(name: "STUPID1", id: Owner.player1)!
    let dumb2 = SimpleAIPlayer(name: "STUPID2", id: Owner.player2)!
    
    var game:Game = Game(rules: VerySimpleRules(), player1: dumb1, player2: dumb2)
    
    func onMoveDoneListener(move:Move, newRules:Rules){
        rules = newRules
        
        if let removedPiece, let insertedPiece {
            csvMoves += "\(insertedPiece.animal.csvNotation)x\(removedPiece.animal.csvNotation) "
        }
        else if let insertedPiece {
            csvMoves += "\(insertedPiece.animal.csvNotation)\(rowNotation[move.rowDestination])\(move.columnDestination+1) "
        }
        
        insertedPiece = nil
        removedPiece = nil
    }
    func onGameStateChangedListener(result:Result){
        switch(result){
        case .winner(let owner, _):
            winner = owner
        default:
            winner = Owner.noOne
        }
    }
    func onPieceRemovedListener(removed:Piece){
        removedPiece = removed
    }
    func onPieceInsertedListener(inserted:Piece){
        insertedPiece = inserted
    }
    
    game.addMoveDoneListener(listener: onMoveDoneListener)
    game.addGameStateListener(listener: onGameStateChangedListener)
    game.addPieceRemovedListener(listener: onPieceRemovedListener)
    game.addPieceInsertedListener(listener: onPieceInsertedListener)
    game.start()
    
    switch (winner){
    case .noOne:
        return nil
    default:
        return GameDatas(dumb1: dumb1, dumb2: dumb2, moves: csvMoves, winner: winner, rules: rules)
    }
}

public func moveToString(move:Move, insertedPiece:Piece, removedPiece:Piece?)->String{
    if let removedPiece {
        return "\(insertedPiece)x\(removedPiece) "
    }
    
    return "\(insertedPiece)\(rowNotation[move.rowDestination])\(move.columnDestination+1) "
}

public func gameToCSV(game: GameDatas, gameNb: Int) -> String {
    return "\(gameNb),\(game.moves),\(game.winner)"
}


public func writeGamesMovesToCSV(games: [GameDatas], filePath: String) {
    var csvString:String = "gameNb,moves,winner\n"
    var countGame:Int = 1
    
    for game in games {
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

public func generateCsvMoves(nbGameSample:Int){
    var games:[GameDatas] = Array()
    for _ in 0...nbGameSample {
        let game:GameDatas? = gamesGenerator()
        if let game {
            games.append(game)
        }
    }
    writeGamesMovesToCSV(games: games, filePath: "./gamesSample.csv")
}
