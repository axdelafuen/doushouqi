//
//  PlayerTest.swift
//  
//
//  Created by etudiant on 30/01/2024.
//

import XCTest
@testable import Model

final class PlayerTest: XCTestCase {

    private var rules:Rules!
    private var board:Board!
    
    override func setUpWithError() throws {
        rules = VerySimpleRules()
        board = VerySimpleRules.createBoard()
    }

    func testRandomPlayerCanBeCreated() throws {
        let randPlayer:Player? = RandomPlayer(name: "test", id: Owner.player1)
        XCTAssertNotNil(randPlayer)
        XCTAssertEqual(randPlayer?.name, "test")
    }
    
    func testRandomPlayerCreationError() throws {
        let randPlayer:Player? = RandomPlayer(name: "test", id: Owner.noOne)
        XCTAssertNil(randPlayer)
    }
    
    func testPlayerIsInstanciatedAndTryAMove() throws {
        let randPlayer:Player? = Player(name: "test", id: Owner.player1)
        XCTAssertNotNil(randPlayer)
        XCTAssertNil(randPlayer?.chooseMove(board: board, rules: rules))
    }
    
    func testRandomPlayerChooseMove() throws {
        let randPlayer:Player? = RandomPlayer(name: "test", id: Owner.player1)
        XCTAssertNotNil(randPlayer)
        let move:Move? = randPlayer?.chooseMove(board: board, rules: rules)
        XCTAssertNotNil(move)
        XCTAssertTrue(rules.getMoves(board: board, owner: randPlayer!.id).contains(where: { $0 == move! }))
    }

}
