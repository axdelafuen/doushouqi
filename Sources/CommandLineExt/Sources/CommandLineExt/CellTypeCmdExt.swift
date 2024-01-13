//
//  CellTypeCmdExt.swift
//
//
//  Created by etudiant on 10/01/2024.
//

import Foundation
import Model

// extension of the CellType class, in order to use it only is CommandLineTest
public extension CellType {
    var symbol: String {
            switch self {
            case .den:
                return "🪹"
            case .jungle:
                return "🌿"
            case .trap:
                return "🪤"
            case .water:
                return "💧"
            case .unknown:
                return " "
            }
        }
}
