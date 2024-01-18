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

"CommandLineTest" --> "CommandLineExt"
"CommandLineTest" --> "Model"

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
left to right direction
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
    struct CellTypeCmdExt {
        +symbol:String
    }
    
    struct OwnerCmdExt {
        +symbol:String
    }
    
    struct AnimalCmdExt {
        +symbol:String
    }
    
    struct BoardCmdExt {
        +description:String
    }
}

CellType <|-- CellTypeCmdExt
Owner <|-- OwnerCmdExt
Animal <|-- AnimalCmdExt
Board <|-- BoardCmdExt

@enduml

```

# Author

- [Axel DE LA FUENTE](https://codefirst.iut.uca.fr/git/axel.de_la_fuente)

# Acknowledgements

Thanks to my professor for his guidance and feedback throughout the development of this project.

- Marc CHEVALDONNE
