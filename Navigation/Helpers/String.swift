//
//  String.swift
//  Navigation
//
//  Created by Дина Шварова on 28.02.2023.
//

import Foundation

extension String {
    mutating func replace(at index: Int, with character: Character) {
        var stringArray = Array(self)
        stringArray[index] = character
        self = String(stringArray)
    }
}
