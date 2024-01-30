//
//  main.swift
//  CommandLineTest
//
//  Created by etudiant on 10/01/2024.
//

import Foundation
import Model
import CommandLineExt

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
var board:Board? = Board(grid: grid)

// function to debug tp1
func debugTp1() {
    
    // print datas
    if let board {
        print(board)
    }
    else {
        print("ERROR : board not created !")
    }
    
}

func debugTp2(){
    if var board {
        print("Nombre de piece pour player1 : ", board.countPieces(of: Owner.player1))
        print("Nombre de piece pour les 2 players : ", board.countPieces())
        
        var insertResult = board.insert(piece: Piece(owner:Owner.player1, animal: Animal.dog), atRow: 0, andColumn: 1)
        print("Insertion d'un 'dog' en 1,2 (should be 'ok') : ", insertResult)
        print(board)
        
        insertResult = board.insert(piece: Piece(owner:Owner.player1, animal: Animal.dog), atRow: 1, andColumn: 1)
        print("Insertion d'un 'dog' en 2,2 (should be 'failed') : ", insertResult)
        print(board)
    }
    else {
        print("ERROR : board not created !")
    }
}

func debugTp3(){
    let board = VerySimpleRules.createBoard()
    
    print(board)
    
    do {
        try VerySimpleRules.checkBoard(board: board)
        print("No errors")
    }catch InvalidBoardError.badCellType(_, _, _) {
        print("Bad cell type")
    }catch InvalidBoardError.badDimensions(_, _) {
        print("Bad cell dimension")
    }catch InvalidBoardError.multipleOccurencesOfSamePiece(_) {
        print("multiple occurences of same piece")
    }catch InvalidBoardError.pieceNotAllowedOnThisCell(_, _) {
        print("Piece not allowed on this cell")
    }catch InvalidBoardError.pieceWithNoOwner(_) {
        print("Piece with no owner")
    }catch {
        print("Unknown error")
    }
    
    let rules:VerySimpleRules = VerySimpleRules()
    
    print(rules.getMoves(board: board, owner: Owner.player1))
    
    print("////////")
    
    print(rules.getMoves(board: board, owner: Owner.player1, row: 0, column: 1))
    
    let move:Move = Move(owner: rules.getNextPlayer(), rowOrigin: 0, columnOrigin: 1, rowDestination: 1, columnDestination: 1)
    print(rules.isMoveValid(board: board, move: move))
    
    // 1
    //print(rules.getNextPlayer())
    //rules.playedMove(move: move, oldBoard: board, newBoard: board)
    //2
    //print(rules.getNextPlayer())

    // test animals weights
    if Animal.dog <= Animal.rat {
        print("success")
    }
    else {
        print("failed")
    }
    
}

public func debugTp4() {
    let board = VerySimpleRules.createBoard()
    
    print(board)
    
    let sa:Player? = RandomPlayer(name: "Supidité Artificielle", id: Owner.player1)
    
    if let sa {
        print(sa.chooseMove(board: board, rules: VerySimpleRules()))
    }

    //let player:Player? = HumanPlayer(name: "GROSLARDON", id: Owner.player2, inputMethod: )
}

// call functions
//debugTp1()
//debugTp2()
//debugTp3()
//debugTp4()


public func dumb_AI_Game() async throws {
    var board = VerySimpleRules.createBoard()
    var rules = VerySimpleRules()
    let dumb1 = RandomPlayer(name: "STUPID 1", id: Owner.player1)!
    let dumb2 = RandomPlayer(name: "STUPID 2", id: Owner.player2)!
    
    var counter = 1
    
    var gameOver:(Bool, Result) = (false, Result.notFinished)
    while(!gameOver.0) {
        print("---------- Tour : ", counter, "(", rules.getNextPlayer(),")" , " ----------")
        print(board)
        if rules.getNextPlayer() == dumb1.id {
            let move = dumb1.chooseMove(board: board, rules: rules)
            let oldBoard = board
            
            _ = board.removePiece(atRow: move.rowDestination, andColumn: move.columnDestination)
            _ = board.insert(piece: board.grid[move.rowOrigin][move.columnOrigin].piece!, atRow: move.rowDestination, andColumn: move.columnDestination)
            _ = board.removePiece(atRow: move.rowOrigin, andColumn: move.columnOrigin)
            
            rules.playedMove(move: move, oldBoard: oldBoard, newBoard: board)

            gameOver = rules.isGameOver(board: board, row: move.rowDestination, column: move.columnDestination)
        }
        else {
            let move = dumb2.chooseMove(board: board, rules: rules)
            let oldBoard = board
            
            _ = board.removePiece(atRow: move.rowDestination, andColumn: move.columnDestination)
            _ = board.insert(piece: board.grid[move.rowOrigin][move.columnOrigin].piece!, atRow: move.rowDestination, andColumn: move.columnDestination)
            _ = board.removePiece(atRow: move.rowOrigin, andColumn: move.columnOrigin)
            
            rules.playedMove(move: move, oldBoard: oldBoard, newBoard: board)
            
            gameOver = rules.isGameOver(board: board, row: move.rowDestination, column: move.columnDestination)
        }
        counter += 1
        try await Task.sleep(nanoseconds: UInt64(0.2*(pow(10.0, 9))))
    }
    print(gameOver.1)
    print(board)
}

try await dumb_AI_Game()
