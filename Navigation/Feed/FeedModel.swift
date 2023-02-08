//
//  FeedModel.swift
//  Navigation
//
//  Created by Дина Шварова on 08.02.2023.
//

import UIKit

class FeedModel {
    
    private let secretWord = "Admin"
    
    func check (word: String) -> Bool {
        word == secretWord ? true : false
    }
}
