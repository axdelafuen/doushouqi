[![Build Status](https://codefirst.iut.uca.fr/api/badges/axel.de_la_fuente/DouShouQi/status.svg)](https://codefirst.iut.uca.fr/axel.de_la_fuente/DouShouQi)

### Built with

![Swift](https://img.shields.io/badge/swift-F54A2A?style=for-the-badge&logo=swift&logoColor=white)

<div align="center">
    <h1>DouShouQi</h1>
    <img src="./Documentations/doushouqi.png" height="200">
</div>

# Getting started

Clone the repository :

```shell
git clone https://codefirst.iut.uca.fr/git/axel.de_la_fuente/DouShouQi.git
```

Build dependencies :

```shell
cd ./Sources/Model/
swift build
cd ../CommandLineExt/
swift build
```

Run the app :

```shell
cd ../CommandLineTest/
swift run
```

# Tests

Tests can be launch by using the following commands :

```shell
cd ./Sources/Model/
swift test
```

# Architecture diagram

```plantuml
@startuml
left to right direction

"CommandLineTest" ..> "CommandLineExt"
"CommandLineTest" ..> "Model"

package "CommandLineTest" {
  node "Command Line Tool" 
}

package "CommandLineExt" {
  node "Model Classes Extensions"
}

package "Model" {
  node "Model Classes"
  node "Tests Model Classes"
}

"Model Classes Extensions" --|> "Model Classes"

@enduml
```

# Model & Extensions - class diagram

```plantuml

@startuml

package Model {
    struct Board {
        <<struct>>
        +nbRows : Int
        +nbColumns : Int
        +init?(grid:[ [ Cell ] ])
        +countPieces(owner:Owner) : Int
        +countPieces() : (Int, Int)
        +insert(piece:Piece, row:Int, column:Int) : BoardResult
        +removePiece(row:Int, column:Int) : BoardResult
    }

    struct Cell {
        <<struct>>
        +init(type:CellType, owner:Owner, piece:Piece?)
    }
    
    enum CellType {
        unknown
        jungle
        water
        trap
        den
    }

    struct Owner {
        noOne
        player1
        player2
    }
    
    enum BoardResult {
        unknown
        ok
        failed(reason:BoardFailingReason)
    }
    
    enum BoardFailingReason {
        unknown
        outOfBounds
        cellNotEmpty
        cellEmpty
    }

    enum Animal {
        rat
        cat
        dog
        wolf
        leopard
        tiger
        lion
        elephant
    }
    
    struct Piece {
        +init(owner:Owner, animal:Animal)
    }

    package Rules <<Rectangle>> {
       interface Rules <<protocol>> {
	    {static} +createBoard() Board
	    {static} +checkBoard(b: Board)
	    +getNextPlayer() Owner
	    +getMoves(Board, Owner) Array~Move~
	    +getMoves(Board, Owner, Int, Int) Array~Move~
	    +isMoveValid(Board, Int, Int, Int, Int) Bool
	    +isMoveValid(Board, Move) Bool
	    +isGameOver(Board, Int, Int) : (Bool, Result)  
	    +playedMove(Move, Board, Board)
	    +occurences : [Board:Int]
	    +historic: [Move]
	}

	struct ClassicRules {

        }

        struct VerySimpleRules {

        }

	Rules <|.. ClassicRules
	Rules <|.. VerySimpleRules
	
	struct Move {
	    +owner: Owner
	    +rowOrigin: Int
	    +columnOrigin: Int
	    +rowDestination: Int
	    +columnDestination: Int
	}
	
	enum Result {
	    notFinished
	    even
	    winner(Owner, WinningReason)
	}

	enum WinningReason {
	    unknown
	    denReached
	    noMorePieces
	    tooManyOccurences
	    noMovesLeft
	}

	Result ..> WinningReason
	Rules ..> Move
	Rules ..> Result
	Rules ..> Board
	
	enum InvalidBoardError {
	    badDimensions(Int, Int)
	    badCellType(CellType,Int,Int)
	    multipleOccurencesOfSamePiece(Piece)
	    pieceWithNoOwner(Piece)
	    pieceNotAllowedOnThisCell(Piece, Cell)
	}

	ClassicRules ..> InvalidBoardError
	VerySimpleRules ..> InvalidBoardError
	
	enum GameError {
	    invalidMove
	}

	ClassicRules ..> GameError
	VerySimpleRules ..> GameError
    }
}

Cell --> "1" CellType : cellType
Cell --> "1" Owner : initialOwner
Board -->  Cell : grid [[]]

Board ..> BoardResult
BoardResult ..> BoardFailingReason

Piece --> "1" Owner : owner
Piece --> "1" Animal : animal
Cell --> "?" Piece : piece

package CommandLineExt {
    struct BoardCmdExt {
        +description:String
    }

    struct CellTypeCmdExt {
        +symbol:String
    }
    
    struct OwnerCmdExt {
        +symbol:String
    }
    
    struct AnimalCmdExt {
        +symbol:String
    }
}

Board <|-- BoardCmdExt
CellType <|-- CellTypeCmdExt
Owner <|-- OwnerCmdExt
Animal <|-- AnimalCmdExt

@enduml

```

# Author

- [Axel DE LA FUENTE](https://codefirst.iut.uca.fr/git/axel.de_la_fuente)

# Acknowledgements

Thanks to my professor for his guidance and feedback throughout the development of this project.

- Marc CHEVALDONNE
