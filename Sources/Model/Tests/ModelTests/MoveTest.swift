//
//  MoveTest.swift
//  
//
//  Created by etudiant on 25/01/2024.
//

import XCTest
@testable import Model

final class MoveTest: XCTestCase {

    private var move:Move!
    
    override func setUpWithError() throws {
        move = Move(owner: Owner.player1, rowOrigin: 0, columnOrigin: 0, rowDestination: 0, columnDestination: 1)
    }

    func testCanBeCreated() throws {
        XCTAssertEqual(move.owner, Owner.player1)
        XCTAssertEqual(move.rowOrigin, 0)
        XCTAssertEqual(move.columnOrigin, 0)
        XCTAssertEqual(move.rowDestination, 0)
        XCTAssertEqual(move.columnDestination, 1)
    }
    
    func testDescritption() throws {
        XCTAssertEqual(move.description, "Movement for Player : 1 from (0, 0) to (0, 1)")
    }

}
