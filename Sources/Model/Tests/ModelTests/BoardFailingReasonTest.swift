//
//  BoardFailingReasonTest.swift
//  
//
//  Created by etudiant on 16/01/2024.
//

import XCTest
@testable import Model

final class BoardFailingReasonTest: XCTestCase {

    var unknown:BoardFailingReason!
    var outOfBounds:BoardFailingReason!
    var cellNotEmpty:BoardFailingReason!
    var cellEmpty:BoardFailingReason!
    
    override func setUpWithError() throws {
        unknown = BoardFailingReason.unknown
        outOfBounds = BoardFailingReason.outOfBounds
        cellNotEmpty = BoardFailingReason.cellNotEmpty
        cellEmpty = BoardFailingReason.cellEmpty
    }

    func testBoardFailingReasonUnknown() throws {
        XCTAssertEqual(unknown, BoardFailingReason.unknown)
    }
    
    func testBoardFailingReasonOutOfBounds() throws {
        XCTAssertEqual(outOfBounds, BoardFailingReason.outOfBounds)
    }
    
    func testBoardFailingReasonCellNotEmpty() throws {
        XCTAssertEqual(cellNotEmpty, BoardFailingReason.cellNotEmpty)
    }
    
    func testBoardFailingReasonCellEmpty() throws {
        XCTAssertEqual(cellEmpty, BoardFailingReason.cellEmpty)
    }

}
