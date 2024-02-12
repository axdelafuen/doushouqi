//
//  GameError.swift
//
//
//  Created by etudiant on 22/01/2024.
//

import Foundation

public enum GameError : Error {
    case invalidMove
    case nextPlayerError
    case badPlayerId(String)
}
