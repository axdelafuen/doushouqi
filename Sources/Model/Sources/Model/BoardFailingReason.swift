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
    
    public static func == (lhs: BoardFailingReason, rhs: BoardFailingReason) -> Bool {
        switch (lhs, rhs) {
        case (.unknown, .unknown):
            return true
        case (.outOfBounds, .outOfBounds):
            return true
        case (.cellNotEmpty, .cellNotEmpty):
            return true
        case (.cellEmpty, .cellEmpty):
            return true
        default:
            return false
        }
    }
}
