//
//  VerySimpleRules.swift
//
//
//  Created by etudiant on 22/01/2024.
//

import Foundation

public struct VerySimpleRules : Rules {
    public var occurences: [Board : Int]
    
    public var historic: [Move]
    
    public static func createBoard() -> Board {
        return Board(grid:[
                        [Cell(cellType: CellType.jungle, owner:Owner.player1, piece: Piece(owner: Owner.player1, animal: Animal.lion)),
                         Cell(cellType: CellType.jungle),
                         Cell(cellType: CellType.den),
                         Cell(cellType: CellType.jungle),
                         Cell(cellType: CellType.jungle, owner:Owner.player1, piece: Piece(owner: Owner.player1, animal: Animal.tiger)),
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
                        [Cell(cellType: CellType.jungle, owner:Owner.player2, piece: Piece(owner: Owner.player2, animal: Animal.elephant)),
                         Cell(cellType: CellType.jungle),
                         Cell(cellType: CellType.jungle, owner:Owner.player2, piece: Piece(owner: Owner.player2, animal: Animal.cat)),
                         Cell(cellType: CellType.jungle),
                         Cell(cellType: CellType.jungle, owner:Owner.player2, piece: Piece(owner: Owner.player2, animal: Animal.rat))
                        ],
                        [Cell(cellType: CellType.jungle, owner:Owner.player2, piece: Piece(owner: Owner.player2, animal: Animal.tiger)),
                         Cell(cellType: CellType.jungle),
                         Cell(cellType: CellType.den),
                         Cell(cellType: CellType.jungle),
                         Cell(cellType: CellType.jungle, owner:Owner.player2, piece: Piece(owner: Owner.player2, animal: Animal.lion)),
                        ]
        ])! // TO HANDLE CORRECTLY !
            // TEST IT WITH "checkBoard" ?
    }
    
    /*
    * TO REFACTOR !!!!!
    */
    public static func checkBoard(board: Board) throws {
        // Check board size (row x column)
        if board.nbColumns != 5 || board.nbRows != 5 { throw InvalidBoardError.badDimensions(board.nbColumns, board.nbColumns) }
        
        // Check if CellType "den" is at the right place
        if board.grid[0][2].cellType != CellType.den { throw InvalidBoardError.badCellType(board.grid[0][2].cellType, 0, 2) }
        if board.grid[4][2].cellType != CellType.den { throw InvalidBoardError.badCellType(board.grid[4][2].cellType, 4, 2) }
        
        // Check if every CellType is "jungle" except for the "den" Cells
        for row in 0...4 {
            for column in 0...4 {
                if ( row != 0 && column != 2 ) || ( row != 4 && column != 2 ) {
                    if board.grid[row][column].cellType != CellType.jungle {
                       throw InvalidBoardError.badCellType(board.grid[row][column].cellType, row, column)
                   }
                }
             }
        }
        
        // Check if multiple occurences of same pieces
        var set:Set<Piece> = Set()
        for row in board.grid {
            for cell in row {
                if let piece = cell.piece {
                    if !set.insert(piece).inserted {
                        throw InvalidBoardError.multipleOccurencesOfSamePiece(piece)
                    }
                }
            }
        }
        
        // Check if some pieces have no owners
        for row in board.grid {
            for cell in row {
                if let piece = cell.piece {
                    if piece.owner == Owner.noOne {
                        throw InvalidBoardError.pieceWithNoOwner(piece)
                    }
                }
            }
        }
        
        // Check if there is pieces none allowed pieces
        // TODO
        //throw InvalidBoardError.pieceNotAllowedOnThisCell(<#T##Piece#>, <#T##Cell#>)
        
    }
    
    public func getNextPlayer() -> Owner {
        if let owner = historic.last?.owner {
            return owner
        }
        return Owner.noOne
    }
    
    public func getMoves(board: Board, owner: Owner) -> Array<Move> {
        return [Move(owner: Owner.noOne, rowOrigin: 0, columnOrigin: 0, rowDestination: 0, columnDestination: 1)]
    }
    
    public func getMoves(board: Board, owner: Owner, row: Int, column: Int) -> Array<Move> {
        return [Move(owner: Owner.noOne, rowOrigin: 0, columnOrigin: 0, rowDestination: 0, columnDestination: 1)]
    }
    
    public func isMoveValid(board: Board, rowOrigin: Int, columnOrigin: Int, rowDestination: Int, columnDestination: Int) -> Bool {
        if rowDestination > board.nbRows || columnDestination > board.nbColumns {
            return false
        }
        
        if let _ = board.grid[rowDestination][columnDestination].piece {
            return false
        }
        
        return true
    }
    
    public func isMoveValid(board: Board, move: Move) -> Bool {
        return isMoveValid(board: board, rowOrigin: move.rowOrigin, columnOrigin: move.columnOrigin, rowDestination: move.rowDestination, columnDestination: move.columnDestination)
    }
    
    // indicates if the game is over (giving the last cell (row & col) in which a piece moved)
    public func isGameOver(board: Board, row: Int, column: Int) -> (Bool, Result) {
        
        // no pieces for player1 -> player2 win
        if ( board.grid.flatMap { $0 }
            .filter{ $0.piece?.owner == Owner.player1 }
            .count == 0 ) {
            return (true, Result.winner(owner: Owner.player2, winningReason: WinningReason.noMorePieces))
        }
        
        // no pieces for player2 -> player1 win
        if ( board.grid.flatMap { $0 }
            .filter{ $0.piece?.owner == Owner.player2 }
            .count == 0 ) {
            return (true, Result.winner(owner: Owner.player1, winningReason: WinningReason.noMorePieces))
        }
        
        // den reached bu player1
        if ( row == 4 && column == 2 ), let piece = board.grid[row][column].piece {
            if piece.owner == Owner.player1 {
                return (true, Result.winner(owner: Owner.player1, winningReason: WinningReason.denReached))
            }
        }
        
        // den reached by player2
        if ( row == 0 && column == 2 ), let piece = board.grid[row][column].piece {
            if piece.owner == Owner.player2 {
                return (true, Result.winner(owner: Owner.player2, winningReason: WinningReason.denReached))
            }
        }

        // too many occurrences
        if (occurences.values.contains { $0 >= 3 }) {
            // IS IT NO ONE ?
            // IS IT NO ONE ?
            return (true, Result.winner(owner: Owner.noOne, winningReason: WinningReason.tooManyOccurences))
        }
        
        // no more moves
        if getMoves(board: board, owner: getNextPlayer()).count <= 0 {
            if getNextPlayer() == Owner.player1 {
                return (true, Result.winner(owner: Owner.player2, winningReason: WinningReason.noMovesLeft))
            }
            return (true, Result.winner(owner: Owner.player1, winningReason: WinningReason.noMovesLeft))
        }
        
        // else, game is not finished
        return (false, Result.notFinished)
    }
    
    mutating public func playedMove(move: Move, oldBoard: Board, newBoard: Board) {
        historic.append(move)
    }
}
