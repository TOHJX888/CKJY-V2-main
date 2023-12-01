//
//  Recipe.swift
//  CKJY V2
//
//  Created by RGS on 22/11/23.
//

import Foundation

struct RecipeIngredient: Identifiable, Codable {
    var id = UUID()
    var ingredient: Ingredient
    var amount = "0 units"
}


struct Recipe: Identifiable, Codable {
    var id = UUID()
    var recipeTitle: String
    var recipePoints: Int
    var recipeIngredients: [RecipeIngredient]
    var recipeInstructions: String
}
