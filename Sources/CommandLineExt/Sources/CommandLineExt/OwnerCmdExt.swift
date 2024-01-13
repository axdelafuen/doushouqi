//
//  OwnerCmdExt.swift
//
//
//  Created by etudiant on 10/01/2024.
//

import Foundation
import Model

// extension of the Owner class, in order to use it only is CommandLineTest
public extension Owner{
    var symbol: String {
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
