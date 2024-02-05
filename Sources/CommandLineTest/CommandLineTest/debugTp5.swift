//
//  debugTp5.swift
//  CommandLineTest
//
//  Created by etudiant on 05/02/2024.
//

import Foundation
import Model

public func debugTp5(){
    
    // EVENT LISTENER
    func onGameStarted(val:Board){
        print("**************************************\n\t\t==>> GAME STARTS! <<==\n**************************************\n\(val)")
    }
    
    func onNextPlayerChanged(player:Player){
        print("**************************************\nPlayer \(player.id) - \(player.name), it's your turn!\n**************************************")
    }
    
    func onBoardChanged(board:Board){
        print(board)
    }
    
    func onGameStateChanged(result:Result) {
        
        switch(result){
        case .even:
            print("**************************************")
            print("Game Over!!!\nIt's a TIE!")
            print("**************************************")
        case .notFinished:
            print("")
        case .winner(let owner, let winnigReason):
            print("**************************************")
            print("Game Over!!!\nand the winner is... Player \(owner)!\n\(winnigReason).")
            print("**************************************")
        }
    }
    
    // HUMAN INPUT METHOD
    func userInputMethod(player: HumanPlayer) -> Move {
        print("\(player.name), veuillez entrer votre mouvement :")
        
        var rowOrigin:Int? = nil; var columnOrigin:Int? = nil; var rowDestination:Int? = nil; var columnDestination:Int? = nil
        
        func getValue() -> Int? {
            if let input = readLine() {
                return Int(input) ?? nil
            }
            return nil
        }
        
        while(rowOrigin == nil){
            print("Ligne d'origine : ")
            rowOrigin = getValue()
        }
        while(columnOrigin == nil){
            print("Colonne d'origine : ")
            columnOrigin = getValue()
        }
        while(rowDestination == nil){
            print("Ligne de destination : ")
            rowDestination = getValue()
        }
        while(columnDestination == nil){
            print("Colonne de destination : ")
            columnDestination = getValue()
        }
        
        return Move(owner: player.id, rowOrigin: rowOrigin!, columnOrigin: columnOrigin!, rowDestination: rowDestination!, columnDestination: columnDestination!)
    }
    
    // GAME CREATION
    let rules:Rules = VerySimpleRules()
    //let player1:Player? = SimpleAIPlayer(name:"DUMB", id:Owner.player1)
    let player1:Player? = HumanPlayer(name: "MOI", id: Owner.player1, inputMethod: userInputMethod)
    let player2:Player? = RandomPlayer(name:"RANDOM", id:Owner.player2)
    
    var game:Game = Game(rules: rules, player1: player1!, player2: player2!)
    
    game.addGameStartListener(listener: onGameStarted)
    game.addGameStateListener(listener: onGameStateChanged)
    game.addBoardChangedListener(listener: onBoardChanged)
    game.addNextPlayerListener(listener: onNextPlayerChanged)
    game.start()
}
