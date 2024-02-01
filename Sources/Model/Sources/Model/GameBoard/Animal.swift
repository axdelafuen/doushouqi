//
//  Animal.swift
//
//
//  Created by etudiant on 09/01/2024.
//

import Foundation

public enum Animal : Equatable, Comparable{
    case rat
    case cat
    case dog
    case wolf
    case leopard
    case tiger
    case lion
    case elephant
    
    var weight: Int {
            switch self {
            case .rat: return 1
            case .cat: return 2
            case .dog: return 3
            case .wolf: return 4
            case .leopard: return 5
            case .tiger: return 6
            case .lion: return 7
            case .elephant: return 8
            }
        }

    public static func < (lhs: Animal, rhs: Animal) -> Bool {
            switch (lhs, rhs) {
            case (.elephant, .rat):
                return true
            case (.rat, .elephant):
                return false
            default:
                return lhs.weight < rhs.weight
            }
        }
    
    public static func > (lhs: Animal, rhs: Animal) -> Bool {
            switch (lhs, rhs) {
            case (.elephant, .rat):
                return false
            case (.rat, .elephant):
                return true
            default:
                return lhs.weight > rhs.weight
            }
        }
}
