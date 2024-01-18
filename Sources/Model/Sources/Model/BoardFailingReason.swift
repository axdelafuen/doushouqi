//
//  BoardFailingReason.swift
//
//
//  Created by etudiant on 15/01/2024.
//

import Foundation

public enum BoardFailingReason : Equatable {
    case unknown
    case outOfBounds
    case cellNotEmpty
    case cellEmpty
}
