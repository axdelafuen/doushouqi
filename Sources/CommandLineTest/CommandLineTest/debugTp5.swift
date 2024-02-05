//
//  debugTp5.swift
//  CommandLineTest
//
//  Created by etudiant on 05/02/2024.
//

import Foundation
import Model

public func debugTp5(){
    
    func onGameStarted(val:Board){
        print("**************************************\n\t\t==>> GAME STARTS! <<==\n**************************************\n\(val)")
    }
    
    func onNextPlayerChanged(player:Player, board:Board){
        print("**************************************\nPlayer \(player.id) - \(player.name), it's your turn!\n**************************************")
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
    
    let rules:Rules = VerySimpleRules()
    let player1:Player? = RandomPlayer(name:"test", id:Owner.player1)
    let player2:Player? = RandomPlayer(name:"test", id:Owner.player2)
    
    var game:Game = Game(rules: rules, player1: player1!, player2: player2!)
    
    game.addGameStartListener(listener: onGameStarted)
    game.addGameStateListener(listener: onGameStateChanged)
    game.addNextPlayerListener(listener: onNextPlayerChanged)
    game.start()
}
