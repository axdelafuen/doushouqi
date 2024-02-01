//
//  Owner.swift
//
//
//  Created by etudiant on 09/01/2024.
//

import Foundation

public enum Owner : CustomStringConvertible{
    case noOne
    case player1
    case player2
    
    // return easily strings for each case of the enum
    public var description : String {
        switch self {
            case .noOne: return "x"
            case .player1: return "1"
            case .player2: return "2"
        }
    }
}
