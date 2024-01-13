//
//  OwnerCmdExt.swift
//
//
//  Created by etudiant on 10/01/2024.
//

import Foundation
import Model

public extension Owner{
    func symbol() -> String {
        switch self {
        case .noOne:
            return " "
        case .player1:
            return "🟡"
        case .player2:
            return "🔴"
        }
    }
}
