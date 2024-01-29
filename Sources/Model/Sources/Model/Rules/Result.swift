//
//  Result.swift
//
//
//  Created by etudiant on 22/01/2024.
//

import Foundation

public enum Result : Equatable{
    case notFinished
    case even
    case winner(owner: Owner, winningReason: WinningReason)
}
