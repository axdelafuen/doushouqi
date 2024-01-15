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
    
    override func setUpWithError() throws {
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
    
    func testBoardInit() throws {
        XCTAssertEqual(board.nbColumns, 7)
        XCTAssertEqual(board.nbRows, 10)
    }

    func testCountPiecesOf() throws {
        XCTAssertEqual(board.countPieces(of: Owner.player1), 8)
    }
    
    func testCountPieces() throws {
        assert(board.countPieces() == (8,8))
    }
    
    func testInsertPass() throws {
        XCTAssertEqual(board.insert(piece: Piece(owner:Owner.player1, animal: Animal.dog), row: 0, column: 1), BoardResult.ok)
    }

    func testInsertFailed() throws {
        XCTAssertEqual(board.insert(piece: Piece(owner:Owner.player1, animal: Animal.dog), row: 1, column: 1), BoardResult.failed(reason: BoardFailingReason.cellNotEmpty))
    }
    
    func testRemovePiecePass() throws {
        XCTAssertEqual(board.removePiece(row: 0, column: 0), BoardResult.ok)
    }

    func testRemovePieceFailed() throws {
        XCTAssertEqual(board.removePiece(row: 0, column: 1), BoardResult.failed(reason: BoardFailingReason.cellEmpty))
    }
    
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
            _ = board.insert(piece: Piece(owner:Owner.player1, animal: Animal.dog), row: 0, column: 1)
        }
    }

    func testPerformanceRemovePiece() throws {
        self.measure {
            _ = board.removePiece(row: 0, column: 0)
        }
    }
}
