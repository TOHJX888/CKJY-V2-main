//
//  RecipeRowView.swift
//  CKJY V2
//
//  Created by RGS on 22/11/23.
//

import SwiftUI

struct RecipeRowView: View {
    
    @Binding var recipe: Recipe

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(recipe.recipeTitle)
                HStack {
                    Text("\(recipe.recipePoints)")
                    Image(systemName: "leaf.fill")
                }
                .font(.footnote)
                .foregroundColor(.gray)
            }
            Spacer()
            Image(systemName: recipe.recipePoints < -2 ? "hand.thumbsdown.circle.fill" : recipe.recipePoints < 3 ? "minus.circle.fill" : "hand.thumbsup.circle.fill")
        }
        .foregroundColor(recipe.recipePoints < -2 ? .red : recipe.recipePoints < 3 ? Color(red: 0.95, green: 0.7, blue: 0) : .green)
    }
}

struct RecipeRowView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeRowView(recipe: .constant(Recipe(recipeTitle: "Testing", recipePoints: 0, recipeIngredients: [RecipeIngredient(ingredient: Ingredient(name: "Broccoli", points: 1))], recipeInstructions: "")))
    }
}
