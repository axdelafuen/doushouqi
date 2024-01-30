//
//  PieceTest.swift
//  
//
//  Created by etudiant on 30/01/2024.
//

import XCTest
@testable import Model
final class PieceTest: XCTestCase {

    private var piece:Piece!
    
    override func setUpWithError() throws {
        piece = Piece(owner: Owner.player1, animal: Animal.cat)
    }
    
    func testDescription() throws {
        XCTAssertEqual("[1:cat]", piece.description)
    }

}
