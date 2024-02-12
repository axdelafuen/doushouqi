//
//  TestAi.swift
//  CommandLineTest
//
//  Created by etudiant on 06/02/2024.
//

import Foundation
import Model
import AiPlayerLib

public func createMovesCsv(){
    generateCsvMoves(nbGameSample: 5)
    if #available(macOS 10.14, *) {
        var movePred = MovePrediction()
        movePred.loadDatas()
        if let df = movePred.df {
            print(df)
        }
    }
}

public func createRandomBoardCsv(){
    //generateCsvBoards(nbGameSample: <#T##Int#>)
}
