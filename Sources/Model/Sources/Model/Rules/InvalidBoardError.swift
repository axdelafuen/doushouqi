//
//  InvalidBoardError.swift
//
//
//  Created by etudiant on 22/01/2024.
//

import Foundation

public enum InvalidBoardError : Error{
    case badDimensions(Int, Int)
    case badCellType(CellType,Int,Int)
    case multipleOccurencesOfSamePiece(Piece)
    case pieceWithNoOwner(Piece)
    case pieceNotAllowedOnThisCell(Piece, Cell)
}
