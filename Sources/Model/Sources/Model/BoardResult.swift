//
//  BoardResult.swift
//
//
//  Created by etudiant on 15/01/2024.
//

import Foundation

public enum BoardResult {
    case unknown
    case ok
    case failed(reason:BoardFailingReason)
}
