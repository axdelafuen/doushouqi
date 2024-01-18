//
//  BoardResult.swift
//
//
//  Created by etudiant on 15/01/2024.
//

import Foundation

public enum BoardResult : Equatable {
    case unknown
    case ok
    case failed(reason:BoardFailingReason)
    
    public static func == (lhs: BoardResult, rhs: BoardResult) -> Bool {
        switch (lhs, rhs) {
        case (.unknown, .unknown):
            return true
        case (.ok, .ok):
            return true
        case (.failed, .failed):
            return true
        default:
            return false
        }
    }
}
