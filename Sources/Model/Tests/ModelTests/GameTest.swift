//
//  GameTest.swift
//  
//
//  Created by etudiant on 05/02/2024.
//

import XCTest
@testable import Model

final class GameTest: XCTestCase {
    var rules:Rules!
    var player1:Player!
    var player2:Player!
    var game:Game!
    
    override func setUpWithError() throws {
        rules = VerySimpleRules()
        player1 = SimpleAIPlayer(name:"DUMB", id:Owner.player1)
        player2 = SimpleAIPlayer(name:"RANDOM", id:Owner.player2)
        
        game = Game(rules: rules, player1: player1, player2: player2)
    }

    
    func testGameStartedEvent() throws {
        func onGameStartedListener(val:Board){
            XCTAssertNotNil(val)
        }
        game.addGameStartListener(listener: onGameStartedListener)
        game.start()
    }
    
    func testNextPlayerChangedEvent() throws {
        func onNextPlayerChangedListener(val:Player){
            XCTAssertNotNil(val)
        }
        game.addNextPlayerListener(listener: onNextPlayerChangedListener)
        game.start()
    }
}
