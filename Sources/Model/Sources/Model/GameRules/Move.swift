//
//  Move.swift
//
//
//  Created by etudiant on 22/01/2024.
//

import Foundation

public struct Move : CustomStringConvertible, Equatable{
    public var description: String {
        "Movement for Player : " + owner.description + " from (" + rowOrigin.description + ", " + columnOrigin.description + ") to (" + rowDestination.description + ", " + columnDestination.description + ")"
    }
    
    public let owner: Owner
    public let rowOrigin: Int
    public let columnOrigin: Int
    public let rowDestination: Int
    public let columnDestination: Int
    
    public init(owner: Owner, rowOrigin: Int, columnOrigin: Int, rowDestination: Int, columnDestination: Int) {
        self.owner = owner
        self.rowOrigin = rowOrigin
        self.columnOrigin = columnOrigin
        self.rowDestination = rowDestination
        self.columnDestination = columnDestination
    }
}
