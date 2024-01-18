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
package "CommandLineTest" {
  node "Command Line Tool" 
}

package "CommandLineExt" {
  node "Model Classes Extensions"
}

"CommandLineTest" --> "CommandLineExt"
"CommandLineTest" --> "Model"

package "Model" {
  node "Model Classes"
  node "Tests Model Classes"
}

"Model Classes Extensions" --|> "Model Classes"

@enduml
```

# Model & Extensions - class diagram

```mermaid
classDiagram

	direction LR

    namespace Model{

        class Board {
            <<struct>>
            +nbRows : Int
            +nbColumns : Int
            +init?(grid:[[Cell]])
            +countPieces(owner:Owner) Int
            +countPieces() :(Int, Int)
            +insert(piece:Piece, row:Int, column:Int) BoardResult
            +removePiece(row:Int, column:Int) BoardResult
        }

        class Cell {
            <<struct>>
            +init(type:CellType, owner:Owner, piece:Piece?)
        }
        
        class CellType {
            <<enum>>
            unknown
            jungle
            water
            trap
            den
        }

        class Owner {
            noOne
            player1
            player2
        }
        
        class BoardResult {
        <<enum>>
        unknown
        ok
        failed(reason:BoardFailingReason)
        }
        
        class BoardFailingReason {
        <<enum>>
        unknown
        outOfBounds
        cellNotEmpty
        cellEmpty
        }
        
        class Animal {
            <<enum>>
            rat
            cat
            dog
            wolf
            leopard
            tiger
            lion
            elephant
        }
        
        class Piece {
            <<struct>>
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

    namespace CommandLineExt{

        class CellTypeCmdExt{
            +symbol:String
        }

        class OwnerCmdExt{
            +symbol:String
        }

        class AnimalCmdExt{
            +symbol:String
        }

        class BoardCmdExt{
            +descritpion:String
        }
    }

    CellType <|-- CellTypeCmdExt
    Owner <|-- OwnerCmdExt
    Animal <|-- AnimalCmdExt
    Board <|-- BoardCmdExt
```

# Author

- [Axel DE LA FUENTE](https://codefirst.iut.uca.fr/git/axel.de_la_fuente)

# Acknowledgements

Thanks to my professor for his guidance and feedback throughout the development of this project.

- Marc CHEVALDONNE
