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
    
    override func setUpWithError() throws {
        // init grid
        let grid: [[Cell]] =
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

    func testCountPiecesOf() throws {
        assert(board.countPieces(of: Owner.player1) == 8)
    }
    
    func testCountPieces() throws {
        assert(board.countPieces() == (8,8))
    }

    func testPerformanceCountPiecesOf() throws {
        // This is an example of a performance test case.
        self.measure {
            _ = board.countPieces(of: Owner.player1)
        }
    }
    
    func testPerformanceCountPieces() throws {
        // This is an example of a performance test case.
        self.measure {
            _ = board.countPieces()
        }
    }

}
