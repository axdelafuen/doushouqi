//
//  debugTp1.swift
//  CommandLineTest
//
//  Created by etudiant on 01/02/2024.
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
