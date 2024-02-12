//
//  debugTp6.swift
//  CommandLineTest
//
//  Created by etudiant on 12/02/2024.
//

import Foundation
import Model
import Persistence

func debugTp6() throws{
    let jsonDecoder = JSONDecoder()
    
    let cell = CellType.water
    
    let piece = Piece(owner: Owner.player1, animal: Animal.cat)
        
    //try printEncode(piece)
    
    let move = Move(owner: Owner.player1, rowOrigin: 0, columnOrigin: 0, rowDestination: 0, columnDestination: 0)
    
    let moveDatas = try printEncode(move)
    
    let board = VerySimpleRules.createBoard()
    let boardDatas = try printEncode(board)
    
    let data = try jsonDecoder.decode(Board.self, from: boardDatas)
    
    print(data)
    
    //try printDecode(boardDatas, type: Board)
}

func printEncode<T>(_ val: T) throws -> Data where T : Encodable {
    let jsonEncoder = JSONEncoder()
    
    let jsonData = try jsonEncoder.encode(val)
    
    let json = String(data: jsonData, encoding: String.Encoding.utf8)!
    
    print(json)
    
    return jsonData
}

func printDecode<T>(_ val: Data, type:T) throws -> T where T : Decodable {
    let jsonDecoder = JSONDecoder()
    
    let data = try jsonDecoder.decode(T.self, from: val)
    
    print(data)
    
    return data
}
