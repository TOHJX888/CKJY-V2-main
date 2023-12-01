//
//  RecipeDetailVIew.swift
//  CKJY V2
//
//  Created by RGS on 24/11/23.
//

import SwiftUI

struct RecipeDetailView: View {
    
    @Binding var recipe: Recipe
    @EnvironmentObject var ingredientManager: IngredientManager
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var pointsChange = 0
    
    
    var body: some View {
        NavigationStack {
            Form {
                Section("General") {
                    HStack {
                        TextField("Title", text: $recipe.recipeTitle)
                    }
                    Stepper("Points: \(recipe.recipePoints)", value: $recipe.recipePoints, in: -5...5)
                }
                Section("Ingredients") {
                    ForEach($recipe.recipeIngredients) { $ingredient in
               
                    RecipeIngredientRowView(recipeIngredient: $ingredient)
                    }
                }
                Section("Instructions") {
                    TextEditor(text: $recipe.recipeInstructions)
                }
                Section("Actions") {
                    Button("Tap when eaten") {
                        alertMessage = "Are you sure you have eaten this?"
                        pointsChange = recipe.recipePoints
                        showAlert = true
                    }
                    Button("Tap to undo", role: .destructive) {
                        alertMessage = "Are you sure you want to undo this action?"
                        pointsChange = recipe.recipePoints * -1
                        showAlert = true
                    }
                }
                .alert(alertMessage, isPresented: $showAlert) {
                    Button("Continue", role: .destructive) {
                        ingredientManager.totalPoints += pointsChange
                    }
                } message: {
                    Text("This will result in a change of \(pointsChange) \(pointsChange == 1 ? "point" : "points").")
                }
            }
        }
        .navigationTitle("View Recipe")
    }
}

struct RecipeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetailView(
            recipe: .constant(
                Recipe(
                    recipeTitle: "Broccoli Soup",
                    recipePoints: 4,
                    recipeIngredients: [],
                    recipeInstructions: "make broccoli soup and eat it lol"
                )
            )
        )
        .environmentObject(IngredientManager())
    }
}
