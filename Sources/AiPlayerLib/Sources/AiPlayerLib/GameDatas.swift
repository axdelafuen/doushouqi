import Foundation
import Model

public struct GameDatas{
    let dumb1:Player
    let dumb2:Player
    let moves:String
    let winner:Owner
    let rules:Rules
        
    init(dumb1: Player, dumb2: Player, moves: String, winner: Owner, rules:Rules) {
        self.dumb1 = dumb1
        self.dumb2 = dumb2
        self.moves = moves
        self.winner = winner
        self.rules = rules
    }
}
