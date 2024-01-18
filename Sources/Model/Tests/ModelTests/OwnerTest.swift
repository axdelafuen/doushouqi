//
//  OwnerTest.swift
//  
//
//  Created by etudiant on 16/01/2024.
//

import XCTest
@testable import Model

final class OwnerTest: XCTestCase {

    private var ownerNoOne:Owner!
    private var ownerPlayer1:Owner!
    private var ownerPlayer2:Owner!
    
    override func setUpWithError() throws {
        ownerNoOne = Owner.noOne
        ownerPlayer1 = Owner.player1
        ownerPlayer2 = Owner.player2
    }

    func testOwnerNoOne() throws {
        XCTAssertEqual(ownerNoOne.description, "x")
    }
    
    func testOwnerPlayer1() throws {
        XCTAssertEqual(ownerPlayer1.description, "1")
    }
    
    func testOwnerPlayer2() throws {
        XCTAssertEqual(ownerPlayer2.description, "2")
    }

}
