//
//  BoardTest.swift
//  
//
//  Created by etudiant on 15/01/2024.
//

import XCTest
@testable import Model

final class BoardTest: XCTestCase {

    private var board:Board!
    
    private var grid:[[Cell]]!
    
    override func setUp() {
        // init grid
        grid =
        [
            // player 1
            [Cell(cellType: CellType.jungle, owner:Owner.player1, piece: Piece(owner: Owner.player1, animal: Animal.lion)),
             Cell(cellType: CellType.jungle),
             Cell(cellType: CellType.trap),
             Cell(cellType: CellType.den),
             Cell(cellType: CellType.trap),
             Cell(cellType: CellType.jungle),
             Cell(cellType: CellType.jungle, owner:Owner.player1, piece: Piece(owner: Owner.player1, animal: Animal.tiger)),
            ],
            [Cell(cellType: CellType.jungle),
             Cell(cellType: CellType.jungle, owner:Owner.player1, piece: Piece(owner: Owner.player1, animal: Animal.dog)),
             Cell(cellType: CellType.jungle),
             Cell(cellType: CellType.trap),
             Cell(cellType: CellType.jungle),
              Cell(cellType: CellType.jungle, owner:Owner.player1, piece: Piece(owner: Owner.player1, animal: Animal.cat)),
              Cell(cellType: CellType.jungle)
            ],
            [Cell(cellType: CellType.jungle, owner:Owner.player1, piece: Piece(owner: Owner.player1, animal: Animal.rat)),
             Cell(cellType: CellType.jungle),
             Cell(cellType: CellType.jungle, owner:Owner.player1, piece: Piece(owner: Owner.player1, animal: Animal.leopard)),
             Cell(cellType: CellType.jungle),
             Cell(cellType: CellType.jungle, owner:Owner.player1, piece: Piece(owner: Owner.player1, animal: Animal.wolf)),
             Cell(cellType: CellType.jungle),
             Cell(cellType: CellType.jungle, owner:Owner.player1, piece: Piece(owner: Owner.player1, animal: Animal.elephant))
            ],
            // water
            [Cell(cellType: CellType.jungle),
             Cell(cellType: CellType.water),
             Cell(cellType: CellType.water),
             Cell(cellType: CellType.jungle),
             Cell(cellType: CellType.water),
             Cell(cellType: CellType.water),
             Cell(cellType: CellType.jungle),
            ],
            [Cell(cellType: CellType.jungle),
             Cell(cellType: CellType.water),
             Cell(cellType: CellType.water),
             Cell(cellType: CellType.jungle),
             Cell(cellType: CellType.water),
             Cell(cellType: CellType.water),
             Cell(cellType: CellType.jungle),
            ],
            [Cell(cellType: CellType.jungle),
             Cell(cellType: CellType.water),
             Cell(cellType: CellType.water),
             Cell(cellType: CellType.jungle),
             Cell(cellType: CellType.water),
             Cell(cellType: CellType.water),
             Cell(cellType: CellType.jungle),
            ],
            [Cell(cellType: CellType.jungle),
             Cell(cellType: CellType.water),
             Cell(cellType: CellType.water),
             Cell(cellType: CellType.jungle),
             Cell(cellType: CellType.water),
             Cell(cellType: CellType.water),
             Cell(cellType: CellType.jungle),
            ],
            // player 2
            [Cell(cellType: CellType.jungle, owner:Owner.player2, piece: Piece(owner: Owner.player2, animal: Animal.elephant)),
             Cell(cellType: CellType.jungle),
             Cell(cellType: CellType.jungle, owner:Owner.player2, piece: Piece(owner: Owner.player2, animal: Animal.wolf)),
             Cell(cellType: CellType.jungle),
             Cell(cellType: CellType.jungle, owner:Owner.player2, piece: Piece(owner: Owner.player2, animal: Animal.leopard)),
             Cell(cellType: CellType.jungle),
             Cell(cellType: CellType.jungle, owner:Owner.player2, piece: Piece(owner: Owner.player2, animal: Animal.rat)),
            ],
            [Cell(cellType: CellType.jungle),
             Cell(cellType: CellType.jungle, owner:Owner.player2, piece: Piece(owner: Owner.player2, animal: Animal.cat)),
             Cell(cellType: CellType.jungle),
             Cell(cellType: CellType.trap),
             Cell(cellType: CellType.jungle),
              Cell(cellType: CellType.jungle, owner:Owner.player2, piece: Piece(owner: Owner.player2, animal: Animal.dog)),
              Cell(cellType: CellType.jungle)
            ],
            [Cell(cellType: CellType.jungle, owner:Owner.player2, piece: Piece(owner: Owner.player2, animal: Animal.tiger)),
             Cell(cellType: CellType.jungle),
             Cell(cellType: CellType.trap),
             Cell(cellType: CellType.den),
             Cell(cellType: CellType.trap),
             Cell(cellType: CellType.jungle),
             Cell(cellType: CellType.jungle, owner:Owner.player2, piece: Piece(owner: Owner.player2, animal: Animal.lion))
            ],
        ]
        // init board
        board = Board(grid: grid)
    }
    
    // Init test
    func testBoardInit() throws {
        XCTAssertEqual(board.nbColumns, 7)
        XCTAssertEqual(board.nbRows, 10)
    }

    // Methods tests
    func testCountPiecesOf() throws {
        XCTAssertEqual(board.countPieces(of: Owner.player1), 8)
    }
    
    func testCountPieces() throws {
        assert(board.countPieces() == (8,8))
    }
    
    func testInsertOk() throws {
        func expect(row:Int, column:Int) {
            XCTAssertNil(board.grid[row][column].piece)
            XCTAssertEqual(board.insert(piece: Piece(owner:Owner.player1, animal: Animal.dog), atRow: row, andColumn: column), BoardResult.ok)
            XCTAssertNotNil(board.grid[row][column])
        }
        expect(row: 0, column: 1)
        expect(row: 3, column: 3)
        expect(row: 7, column: 5)
    }

    func testInsertCellNotEmpty() throws {
        func expect(row:Int, column:Int){
            XCTAssertNotNil(board.grid[row][column])
            XCTAssertEqual(board.insert(piece: Piece(owner:Owner.player1, animal: Animal.dog), atRow: row, andColumn: column), BoardResult.failed(reason: BoardFailingReason.cellNotEmpty))
        }
        expect(row: 0, column: 0)
        expect(row: 2, column: 2)
        expect(row: 1, column: 5)
    }
    
    func testInsertCellOutOfBounds() throws {
        XCTAssertEqual(board.insert(piece: Piece(owner:Owner.player1, animal: Animal.dog), atRow: 20, andColumn: 1), BoardResult.failed(reason: BoardFailingReason.outOfBounds))
    }
    
    func testRemovePieceOk() throws {
        func expect(row:Int, column:Int) {
            XCTAssertNotNil(board.grid[row][column].piece)
            XCTAssertEqual(board.removePiece(atRow: row, andColumn: column), BoardResult.ok)
            XCTAssertNil(board.grid[row][column].piece)
        }
        expect(row: 0, column: 0)
        expect(row: 2, column: 2)
        expect(row: 1, column: 5)
    }

    func testRemovePieceCellEmpty() throws {
        func expect(row:Int, column:Int) {
            XCTAssertNil(board.grid[row][column].piece)
            XCTAssertEqual(board.removePiece(atRow: row, andColumn: column), BoardResult.failed(reason: BoardFailingReason.cellEmpty))
        }
        expect(row: 0, column: 1)
        expect(row: 3, column: 3)
        expect(row: 7, column: 5)
    }
    
    func testRemovePieceOutOfBounds() throws {
        XCTAssertEqual(board.removePiece(atRow: 20, andColumn: 1), BoardResult.failed(reason: BoardFailingReason.outOfBounds))
    }
    
    // Performances tests
    func testPerformanceCountPiecesOf() throws {
        self.measure {
            _ = board.countPieces(of: Owner.player1)
        }
    }
    
    func testPerformanceCountPieces() throws {
        self.measure {
            _ = board.countPieces()
        }
    }
    
    func testPerformanceInsert() throws {
        self.measure {
            _ = board.insert(piece: Piece(owner:Owner.player1, animal: Animal.dog), atRow: 0, andColumn: 1)
        }
    }

    func testPerformanceRemovePiece() throws {
        self.measure {
            _ = board.removePiece(atRow: 0, andColumn: 0)
        }
    }
}
