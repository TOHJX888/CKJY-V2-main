//
//  Ingredient.swift
//  CKJY V2
//
//  Created by RGS on 21/11/23.
//

import Foundation

struct Ingredient: Identifiable, Codable, Equatable, Comparable {
    
    var id = UUID()
    var name: String
    var points: Int
    var image = ""
    var isEaten: Bool = false
    var isSelected = false
    
    static func ==(lhs: Ingredient, rhs: Ingredient) -> Bool {
        lhs.name == rhs.name 
    }
    
    static func < (lhs: Ingredient, rhs: Ingredient) -> Bool {
        return lhs.name < rhs.name
    }
}

