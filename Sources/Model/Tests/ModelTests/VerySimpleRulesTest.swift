//
//  VerySimpleRulesTest.swift
//  
//
//  Created by etudiant on 25/01/2024.
//

import XCTest
@testable import Model

final class VerySimpleRulesTest: XCTestCase {
    
    private var validBoard:Board!
    
    private var badBoard:Board!
    
    private var rules:Rules!
    
    override func setUpWithError() throws {
        validBoard = VerySimpleRules.createBoard()
        rules = VerySimpleRules()
        badBoard = Board(grid:[[Cell(cellType: CellType.jungle),
                    Cell(cellType: CellType.jungle, owner:Owner.player1, piece: Piece(owner: Owner.player1, animal: Animal.lion)),
                    Cell(cellType: CellType.jungle),
                    Cell(cellType: CellType.jungle, owner:Owner.player1, piece: Piece(owner: Owner.player1, animal: Animal.tiger)),
                    Cell(cellType: CellType.jungle)
                   ],
                   [Cell(cellType: CellType.jungle, owner:Owner.player1, piece: Piece(owner: Owner.player1, animal: Animal.rat)),
                    Cell(cellType: CellType.jungle),
                    Cell(cellType: CellType.jungle, owner:Owner.player1, piece: Piece(owner: Owner.player1, animal: Animal.cat)),
                    Cell(cellType: CellType.jungle),
                    Cell(cellType: CellType.jungle, owner:Owner.player1, piece: Piece(owner: Owner.player1, animal: Animal.elephant))
                   ],
                   [Cell(cellType: CellType.jungle),
                    Cell(cellType: CellType.jungle),
                    Cell(cellType: CellType.jungle),
                    Cell(cellType: CellType.jungle),
                    Cell(cellType: CellType.jungle)
                   ],
                   [Cell(cellType: CellType.jungle),
                    Cell(cellType: CellType.jungle),
                    Cell(cellType: CellType.jungle),
                    Cell(cellType: CellType.jungle),
                    Cell(cellType: CellType.jungle)
                   ],
                   [Cell(cellType: CellType.jungle),
                    Cell(cellType: CellType.jungle),
                    Cell(cellType: CellType.den),
                    Cell(cellType: CellType.jungle),
                    Cell(cellType: CellType.jungle)
                   ]])
    }
    
    func testCreateBoard() throws {
        XCTAssertEqual(validBoard.nbColumns, 5)
        XCTAssertEqual(validBoard.nbRows, 5)
    }

    func testCheckValidBoard() throws {
        XCTAssertNoThrow(try VerySimpleRules.checkBoard(board: validBoard))
    }
    
    // FAIRE LES AUTRES CAS
    func testCheckBoardMissingDen() throws {
        var thrownError: Error?
        XCTAssertThrowsError(try VerySimpleRules.checkBoard(board: badBoard)){
            thrownError = $0
        }
        XCTAssertTrue(
            thrownError is InvalidBoardError,
            "Unexpected error type: \(type(of: thrownError))"
        )
        XCTAssertEqual(thrownError as? InvalidBoardError, .badCellType(CellType.jungle, 0, 2))
    }
    
    func testGetNextPlayerFirstMove() throws {
        XCTAssertEqual(rules.getNextPlayer(), Owner.player1)
    }
    
    func testGetNextPlayer() throws {
        rules.playedMove(move: Move(owner: rules.getNextPlayer(), rowOrigin: 0, columnOrigin: 0, rowDestination: 0, columnDestination: 1), oldBoard: validBoard, newBoard: validBoard)
        XCTAssertEqual(rules.getNextPlayer(), Owner.player2)
    }
    
    func testIsValidMoveTrue() throws {
        XCTAssertTrue(rules.isMoveValid(board: validBoard, move: Move(owner: Owner.player1, rowOrigin: 0, columnOrigin: 1, rowDestination: 1, columnDestination: 1)))
    }
    
    func testIsValidMoveFalse() throws {
        XCTAssertFalse(rules.isMoveValid(board: validBoard, move: Move(owner: Owner.player1, rowOrigin: 0, columnOrigin: 1, rowDestination: 3, columnDestination: 1)))
    }
    
    func testGetMove() throws {
        XCTAssertEqual(rules.getMoves(board: validBoard, owner: Owner.player1).count, 16)
    }
    
    func testGameIsNotOver () throws {
        XCTAssertFalse(rules.isGameOver(board: validBoard, row: 0, column: 1).0)
        XCTAssertEqual(rules.isGameOver(board: validBoard, row: 0, column: 1).1, Result.notFinished)
    }
    
    func testGameIsOverNoMorePiecesPlayer1() throws {
        XCTAssertTrue(rules.isGameOver(board: badBoard, row: 0, column: 1).0)
        XCTAssertEqual(rules.isGameOver(board: badBoard, row: 0, column: 1).1, Result.winner(owner: Owner.player1, winningReason: WinningReason.noMorePieces))
    }
    
    func testGameIsOverNoMorePiecesPlayer2() throws {
        badBoard = Board(grid:[[Cell(cellType: CellType.jungle),
                    Cell(cellType: CellType.jungle, owner:Owner.player1, piece: Piece(owner: Owner.player2, animal: Animal.lion)),
                    Cell(cellType: CellType.jungle),
                    Cell(cellType: CellType.jungle, owner:Owner.player1, piece: Piece(owner: Owner.player2, animal: Animal.tiger)),
                    Cell(cellType: CellType.jungle)
                   ],
                   [Cell(cellType: CellType.jungle, owner:Owner.player1, piece: Piece(owner: Owner.player2, animal: Animal.rat)),
                    Cell(cellType: CellType.jungle),
                    Cell(cellType: CellType.jungle, owner:Owner.player1, piece: Piece(owner: Owner.player2, animal: Animal.cat)),
                    Cell(cellType: CellType.jungle),
                    Cell(cellType: CellType.jungle, owner:Owner.player1, piece: Piece(owner: Owner.player2, animal: Animal.elephant))
                   ],
                   [Cell(cellType: CellType.jungle),
                    Cell(cellType: CellType.jungle),
                    Cell(cellType: CellType.jungle),
                    Cell(cellType: CellType.jungle),
                    Cell(cellType: CellType.jungle)
                   ],
                   [Cell(cellType: CellType.jungle),
                    Cell(cellType: CellType.jungle),
                    Cell(cellType: CellType.jungle),
                    Cell(cellType: CellType.jungle),
                    Cell(cellType: CellType.jungle)
                   ],
                   [Cell(cellType: CellType.jungle),
                    Cell(cellType: CellType.jungle),
                    Cell(cellType: CellType.den),
                    Cell(cellType: CellType.jungle),
                    Cell(cellType: CellType.jungle)
                   ]])
        XCTAssertTrue(rules.isGameOver(board: badBoard, row: 0, column: 1).0)
        XCTAssertEqual(rules.isGameOver(board: badBoard, row: 0, column: 1).1, Result.winner(owner: Owner.player2, winningReason: WinningReason.noMorePieces))
    }
    
    func testGameIsOver() throws {
        badBoard = Board(grid:[[Cell(cellType: CellType.jungle),
                    Cell(cellType: CellType.jungle, owner:Owner.player1, piece: Piece(owner: Owner.player2, animal: Animal.lion)),
                    Cell(cellType: CellType.jungle),
                    Cell(cellType: CellType.jungle, owner:Owner.player1, piece: Piece(owner: Owner.player2, animal: Animal.tiger)),
                    Cell(cellType: CellType.jungle)
                   ],
                   [Cell(cellType: CellType.jungle, owner:Owner.player1, piece: Piece(owner: Owner.player2, animal: Animal.rat)),
                    Cell(cellType: CellType.jungle),
                    Cell(cellType: CellType.jungle, owner:Owner.player1, piece: Piece(owner: Owner.player2, animal: Animal.cat)),
                    Cell(cellType: CellType.jungle),
                    Cell(cellType: CellType.jungle, owner:Owner.player1, piece: Piece(owner: Owner.player2, animal: Animal.elephant))
                   ],
                   [Cell(cellType: CellType.jungle),
                    Cell(cellType: CellType.jungle),
                    Cell(cellType: CellType.jungle),
                    Cell(cellType: CellType.jungle),
                    Cell(cellType: CellType.jungle)
                   ],
                   [Cell(cellType: CellType.jungle),
                    Cell(cellType: CellType.jungle),
                    Cell(cellType: CellType.jungle),
                    Cell(cellType: CellType.jungle),
                    Cell(cellType: CellType.jungle)
                   ],
                   [Cell(cellType: CellType.jungle),
                    Cell(cellType: CellType.jungle),
                    Cell(cellType: CellType.den, owner:Owner.player1, piece: Piece(owner: Owner.player1, animal: Animal.cat)),
                    Cell(cellType: CellType.jungle),
                    Cell(cellType: CellType.jungle)
                   ]])
        XCTAssertTrue(rules.isGameOver(board: badBoard, row: 4, column: 2).0)
        XCTAssertEqual(rules.isGameOver(board: badBoard, row: 4, column: 2).1, Result.winner(owner: Owner.player1, winningReason: WinningReason.denReached))
    }

}
