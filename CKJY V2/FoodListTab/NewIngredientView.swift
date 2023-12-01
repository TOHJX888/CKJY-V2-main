//
//  NewIngredientView.swift
//  CKJY V2
//
//  Created by RGS on 21/11/23.
//

import SwiftUI

struct NewIngredientView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var ingredientManager: IngredientManager
    @State private var selectedIngredient: Ingredient?
    
    var body: some View {
        NavigationStack {
            List(ingredientManager.presetIngredientsFiltered, editActions: [.all]) { $presetIngredient in
                if !presetIngredient.isSelected {
                    IngredientNewRowView(ingredientNew: $presetIngredient)
                        .foregroundColor(presetIngredient.points == -1 ? .red : presetIngredient.points == 0 ? Color(red: 0.95, green: 0.7, blue: 0) : .green)
                        .onTapGesture {
                            selectedIngredient = presetIngredient
                        }
                }
            }
            .searchable(text: $ingredientManager.presetIngredientsSearchTerm)
            .navigationTitle("New Ingredient")
            .alert(item: $selectedIngredient) { ing in
                Alert(title: Text("Are you sure you want to add \(ing.name) to your Food List?"),
                      primaryButton: .default(Text("Yes"), action: {
                    ingredientManager.selectedIngredients.append(ing)
                    dismiss()
                }),
                      secondaryButton: .cancel())
            }
        }
    }
}

struct NewIngredientView_Previews: PreviewProvider {
    static var previews: some View {
        NewIngredientView()
            .environmentObject(IngredientManager())
    }
}
