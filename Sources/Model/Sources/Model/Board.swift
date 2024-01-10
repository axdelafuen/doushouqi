//
//  Board.swift
//
//
//  Created by etudiant on 10/01/2024.
//

import Foundation

public struct Board {
    
    public let nbRows:Int
    
    public let nbColumns:Int
    
    public private(set) var grid: [[Cell]]
    
    init?(grid: [[Cell]]) {
        if(grid.isEmpty) {
            return nil
        }
        
        var rows:Int = 0
        
        for i in 0...grid.count-1 {
            if grid[i].count != grid[0].count {
                return nil
            }
            rows += 1
        }
        
        self.nbRows = rows
        self.nbColumns = grid.count
        self.grid = grid
    }
}
