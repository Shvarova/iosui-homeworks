//
//  BrutForce.swift
//  Navigation
//
//  Created by Дина Шварова on 28.02.2023.
//

import Foundation

final class BrutForce {
    static func generatePassword(_ string: String, fromArray array: [String]) -> String {
        var str = string
        
        if str.count == 0 {
            str.append(characterAt(index: 0, array))
            return str
        }
        str.replace(at: str.count - 1,
                    with: characterAt(index: (indexOf(character: str.last!, array) + 1) % array.count, array))
        
        if indexOf(character: str.last!, array) == 0 {
            str = String(generatePassword(String(str.dropLast()), fromArray: array)) + String(str.last!)
        }
        
        return str
        
        func characterAt(index: Int, _ array: [String]) -> Character {
            return index < array.count ? Character(array[index]) : Character("")
        }
        
        func indexOf(character: Character, _ array: [String]) -> Int {
            return array.firstIndex(of: String(character)) ?? 0
        }
    }
}
