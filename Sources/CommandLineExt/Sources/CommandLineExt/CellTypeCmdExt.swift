//
//  CellTypeCmdExt.swift
//
//
//  Created by etudiant on 10/01/2024.
//

import Foundation
import Model

public extension CellType {
    func symbol() -> String {
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
