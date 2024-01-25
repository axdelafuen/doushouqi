//
//  VerySimpleRules.swift
//
//
//  Created by etudiant on 22/01/2024.
//

import Foundation

public struct VerySimpleRules : Rules {
    public var occurences: [Board : Int] = Dictionary()
    
    public var historic: [Move] = Array()
    
    public init() {}
    
    public static func createBoard() -> Board {
        return Board(grid:[
                        [Cell(cellType: CellType.jungle),
                         Cell(cellType: CellType.jungle, owner:Owner.player1, piece: Piece(owner: Owner.player1, animal: Animal.lion)),
                         Cell(cellType: CellType.den),
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
                        [Cell(cellType: CellType.jungle, owner:Owner.player2, piece: Piece(owner: Owner.player2, animal: Animal.elephant)),
                         Cell(cellType: CellType.jungle),
                         Cell(cellType: CellType.jungle, owner:Owner.player2, piece: Piece(owner: Owner.player2, animal: Animal.cat)),
                         Cell(cellType: CellType.jungle),
                         Cell(cellType: CellType.jungle, owner:Owner.player2, piece: Piece(owner: Owner.player2, animal: Animal.rat))
                        ],
                        [Cell(cellType: CellType.jungle),
                         Cell(cellType: CellType.jungle, owner:Owner.player2, piece: Piece(owner: Owner.player2, animal: Animal.tiger)),
                         Cell(cellType: CellType.den),
                         Cell(cellType: CellType.jungle, owner:Owner.player2, piece: Piece(owner: Owner.player2, animal: Animal.lion)),
                         Cell(cellType: CellType.jungle)
                        ]
        ])!
    }
    
    public static func checkBoard(board: Board) throws {
        // Check board size (row x column)
        if board.nbColumns != 5 || board.nbRows != 5 { throw InvalidBoardError.badDimensions(board.nbColumns, board.nbColumns) }
        
        // Check if every CellType is "jungle" except for the "den" Cells
        for row in 0...4 {
            for column in 0...4 {
                if ( row == 0 && column == 2 ) || ( row == 4 && column == 2 ) {
                    // Check if den is in correct Cell
                    if board.grid[row][column].cellType != CellType.den {
                       throw InvalidBoardError.badCellType(board.grid[row][column].cellType, row, column)
                    }
                    // Check if a piece is not on his own, den
                    if let piece = board.grid[row][column].piece{
                        if board.grid[row][column].initialOwner == piece.owner {
                            throw InvalidBoardError.pieceNotAllowedOnThisCell(piece, board.grid[row][column])
                        }
                    }
                }
                else if board.grid[row][column].cellType != CellType.jungle {
                        throw InvalidBoardError.badCellType(board.grid[row][column].cellType, row, column)
                }
             }
        }
        
        // Check if multiple occurences of same pieces or pieces with no owner
        var set:Set<Piece> = Set()
        for row in board.grid {
            for cell in row {
                if let piece = cell.piece {
                    if !set.insert(piece).inserted {
                        throw InvalidBoardError.multipleOccurencesOfSamePiece(piece)
                    }
                    if piece.owner == Owner.noOne {
                        throw InvalidBoardError.pieceWithNoOwner(piece)
                    }
                }
            }
        }
    }
    
    // Get the next player
    public func getNextPlayer() -> Owner {
        if let lastMove = historic.last{
            if lastMove.owner == Owner.player1 {
                return Owner.player2
            }
        }
        return Owner.player1
    }
    
    public func getMoves(board: Board, owner: Owner) -> Array<Move> {
        
        var moves:[Move] = Array()
        
        for row in 0...4 {
            for column in 0...4 {
                if board.grid[row][column].piece?.owner == owner {
                    moves.append(contentsOf: getMoves(board: board, owner: owner, row: row, column: column))
                }
             }
        }
        
        return moves
    }
    
    public func getMoves(board: Board, owner: Owner, row: Int, column: Int) -> Array<Move> {
        
        if board.grid[row][column].piece?.owner != owner {
            return Array()
        }
        
        var moves:[Move] = Array()
        
        let moveTop:Move = Move(owner: owner, rowOrigin: row, columnOrigin: column, rowDestination: row, columnDestination: column+1)
        let moveBottom:Move = Move(owner: owner, rowOrigin: row, columnOrigin: column, rowDestination: row, columnDestination: column-1)
        let moveRight:Move = Move(owner: owner, rowOrigin: row, columnOrigin: column, rowDestination: row+1, columnDestination: column)
        let moveLeft:Move = Move(owner: owner, rowOrigin: row, columnOrigin: column, rowDestination: row-1, columnDestination: column)

        if isMoveValid(board: board, move: moveTop) {
            moves.append(moveTop)
        }
        if isMoveValid(board: board, move: moveBottom) {
            moves.append(moveBottom)
        }
        if isMoveValid(board: board, move: moveRight) {
            moves.append(moveRight)
        }
        if isMoveValid(board: board, move: moveLeft) {
            moves.append(moveLeft)
        }
        
        return moves
    }
    
    public func isMoveValid(board: Board, rowOrigin: Int, columnOrigin: Int, rowDestination: Int, columnDestination: Int) -> Bool {
        
        if ( rowOrigin + 1 != rowDestination && rowOrigin - 1 != rowDestination && rowOrigin-rowDestination != 0 )
        || ( columnOrigin + 1 != columnDestination && columnOrigin - 1 != columnDestination && columnOrigin-columnDestination != 0 ) {
            return false
        }
        
        guard let _ = board.grid[rowOrigin][columnOrigin].piece else {
            return false
        }
        
        if rowDestination > board.nbRows-1 || columnDestination > board.nbColumns-1 || rowDestination < 0 || columnDestination < 0 {
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
            if getNextPlayer() == Owner.player1 {
                return (true, Result.winner(owner: Owner.player2, winningReason: WinningReason.tooManyOccurences))
            }
            return (true, Result.winner(owner: Owner.player1, winningReason: WinningReason.tooManyOccurences))
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
    
    // add the old board & new board to historic
    mutating public func playedMove(move: Move, oldBoard: Board, newBoard: Board) {
        historic.append(move)
    }
}
