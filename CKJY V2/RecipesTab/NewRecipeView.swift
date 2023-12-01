//
//  NewRecipeView.swift
//  CKJY V2
//
//  Created by RGS on 22/11/23.
//

import SwiftUI

struct NewRecipeView: View {
    
    @State private var recipeTitle = ""
    @State private var recipePoints = 0
    @State private var recipeInstructions = ""
    @Binding var sourceArray: [Recipe]
    @State private var whitespaceChecker = ""
    @Environment(\.dismiss) var dismiss
    @State private var searchTerm2 = ""
    @EnvironmentObject var ingredientManager: IngredientManager
    @State private var showSheet = false
    @State private var selectedIngredient: Ingredient?
    @State private var tempRecipeIngredients: [RecipeIngredient] = []
    
    var body: some View {
        NavigationStack {
            Form {
                Section("General") {
                    HStack {
                        TextField("Title", text: $recipeTitle)
                    }
                    Stepper("Points: \(recipePoints)", value: $recipePoints, in: -5...5)
                }
                Section("Ingredients") {
                    if !tempRecipeIngredients.isEmpty {
                        ForEach($tempRecipeIngredients, editActions: [.all]) { $ingredient in
                            RecipeIngredientRowView(recipeIngredient: $ingredient)
                        }
                    } else {
                        Text("Try clicking 'Add New Ingredient'")
                            .multilineTextAlignment(.center)
                            .foregroundColor(.gray)
                    }
                }
                NavigationLink {
                    NavigationStack {
                        List {
                            ForEach(ingredientManager.presetIngredientsFiltered) { $presetIngredient in
                                NewRecipeIngredientRowView(ingredient: $presetIngredient)
                                    .onTapGesture {
                                        selectedIngredient = presetIngredient
                                    }
                            }
                        }
                        .searchable(text: $ingredientManager.presetIngredientsSearchTerm)
                        .alert(item: $selectedIngredient) { ing in
                            Alert(title: Text("Are you sure you want to add \(ing.name) to your recipe?"),
                                  primaryButton: .default(Text("Yes"), action: {
                                let newRecipeIngredient = RecipeIngredient(ingredient: ing)
                                tempRecipeIngredients.append(newRecipeIngredient)
                            }),
                                  secondaryButton: .cancel())
                        }
                    }
                    .navigationTitle("Add New Ingredient")
                } label: {
                    Text("Add New Ingredient")
                }
                Section("Instructions") {
                    TextEditor(text: $recipeInstructions)
                }

                Section("Actions") {
                    Button("Save") {
                        save()
                        dismiss()
                    }
                    Button("Cancel", role: .destructive) {
                        dismiss()
                    }
                }
            }
        }
        .navigationTitle("Create New Recipe")
    }
    
    func save() {
        whitespaceChecker = recipeTitle.replacingOccurrences(of: " ", with: "")
        if !whitespaceChecker.isEmpty {
            let recipe = Recipe(
                recipeTitle: recipeTitle,
                recipePoints: recipePoints,
                recipeIngredients: tempRecipeIngredients, // TODO
                recipeInstructions: recipeInstructions
            )
            sourceArray.append(recipe)
        } else {
            let recipe = Recipe(
                recipeTitle: "Untitled",
                recipePoints: recipePoints,
                recipeIngredients: tempRecipeIngredients, // TODO
                recipeInstructions: recipeInstructions
            )
            sourceArray.append(recipe)
        }
        dismiss()
    }
}

struct NewRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        NewRecipeView(sourceArray: .constant([]))
            .environmentObject(IngredientManager())
//        RecipeIngredientRowView(ingredient: .init(name: "broccoli", points: 1))
//        NewRecipeIngredientRowView(ingredient: .init(name: "apple", points: 1))
    }
}
