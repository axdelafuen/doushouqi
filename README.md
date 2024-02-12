[![Build Status](https://codefirst.iut.uca.fr/api/badges/axel.de_la_fuente/doushouqi/status.svg)](https://codefirst.iut.uca.fr/axel.de_la_fuente/doushouqi)

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
"CommandLineTest" ..> "Persistence"
"CommandLineTest" ..> "Model"

package "CommandLineTest" {
  node "Command Line Tool" 
}

package "Persistence" {
  node "Model Persistence Extensions"
}

package "CommandLineExt" {
  node "Model Classes Extensions"
}

package "Model" {
  node "Model Classes"
  node "Tests Model Classes"
}

"Model Persistence Extensions" --|> "Model Classes"
"Model Classes Extensions" --|> "Model Classes"

@enduml
```

# Model & Extensions - class diagram

```plantuml
@startuml

package Model {

package GameBoard <<Rectangle>> {
    struct Board {
        <<struct>>
        +nbRows : Int
        +nbColumns : Int
        +init?(grid:[ [ Cell ] ])
        +countPieces(owner:Owner) -> Int
        +countPieces() -> (Int, Int)
        +insert(piece:Piece, row:Int, column:Int) -> BoardResult
        +removePiece(row:Int, column:Int) -> BoardResult
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
}

    package Players <<Rectangle>> {
        class Player {
	    +id: Owner
	    +name: String
	    +init?(name: String, id: Owner)
	    +chooseMove(board: Board, rules: Rules) -> Move?
	}
	
	class RandomPlayer {
	    +init?(name: String, id: Owner)
	}
	
	class HumanPlayer {
	    +init?(name: String, id : Owner, inputMethod: (HumanPlayer) -> Move?)
	    +input:(HumanPlayer) -> Move?
	}
	
	RandomPlayer --|> Player
	HumanPlayer --|> Player
    }

    package GameRules <<Rectangle>> {
       protocol Rules {
	    {static} +createBoard() -> Board
	    {static} +checkBoard(board: Board)
	    +getNextPlayer() -> Owner
	    +getMoves(board: Board, owner: Owner) -> Array<Move>
	    +getMoves(board: Board, owner: Owner, row: Int, column: Int) -> Array<Move>
	    +isMoveValid(board: Board, rowOrigin: Int, columnOrigin: Int, rowDest: Int, columnDest: Int) -> Bool
	    +isMoveValid(board: Board, move: Move) -> Bool
	    +isGameOver(board: Board, row: Int, column: Int) -> (Bool, Result)  
	    +playedMove(move: Move, oldBoard: Board, newBoard: Board)
	    +occurences: [Board: Int]
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
	
	exception InvalidBoardError <<enum>> {
	    badDimensions(Int, Int)
	    badCellType(CellType,Int,Int)
	    multipleOccurencesOfSamePiece(Piece)
	    pieceWithNoOwner(Piece)
	    pieceNotAllowedOnThisCell(Piece, Cell)
	}

	ClassicRules ..> InvalidBoardError
	VerySimpleRules ..> InvalidBoardError
	
	exception GameError <<enum >> {
	    invalidMove
	}

	ClassicRules ..> GameError
	VerySimpleRules ..> GameError
    }

package GameManagement <<Rectangle>> {
    struct Game {
        +init(rules:Rules, player1:Player, player2:Player)
        +start()
    }
}
Game --> "1" Rules : rules
Game --> "2" Player : players
Game --> "1" Board : board
}

Cell --> "1" CellType : cellType
Cell --> "1" Owner : initialOwner
Board --> "1" Cell : grid [[]]

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

package Persistence {
    struct AnimalPersist<Animal extension>{
        +encode()
        +decode()
    }
    struct BoardPersist<Board extension>{
        +encode()
        +decode()
    }
    struct CellPersist<Cell extension>{
        +encode()
        +decode()
    }
    struct CellTypePersist<CellType extension>{
        +encode()
        +decode()
    }
    struct MovePersist<Move extension>{
        +encode()
        +decode()
    }
    struct OwnerPersist<Owner extension>{
        +encode()
        +decode()
    }
    struct PiecePersist<Piece extension>{
        +encode()
        +decode()
    }
    struct RulesPersist<Rules extension>{
        +encode()
        +decode()
    }
    struct PlayerPersist<Player extension>{
        +encode()
        +decode()
    }
    struct GamePersist<Game extension>{
        +encode()
        +decode()
    }
}
@enduml
```

# Author

- [Axel DE LA FUENTE](https://codefirst.iut.uca.fr/git/axel.de_la_fuente)

# Acknowledgements

Thanks to my professor for his guidance and feedback throughout the development of this project.

- Marc CHEVALDONNE


