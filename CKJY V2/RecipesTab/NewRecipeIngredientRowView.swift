//
//  NewRecipeIngredientRowView.swift
//  CKJY V2
//
//  Created by RGS on 25/11/23.
//

import SwiftUI

struct NewRecipeIngredientRowView: View {
    
    @Binding var ingredient: Ingredient
    @EnvironmentObject var ingredientManager: IngredientManager
    @State var isSelected = false
    
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(ingredient.name)
                HStack {
                    Text("\(ingredient.points)")
                    Image(systemName: "leaf.fill")
                }
                .font(.footnote)
                .foregroundColor(.gray)
            }
            Spacer()
            Image(systemName: ingredient.points == -1 ? "hand.thumbsdown.circle.fill" : ingredient.points == 0 ? "minus.circle.fill" : "hand.thumbsup.circle.fill")
        }
        
        .foregroundColor(ingredient.points == -1 ? .red : ingredient.points == 0 ? Color(red: 0.95, green: 0.7, blue: 0) : .green)
        .onAppear {
            for item in ingredientManager.selectedIngredients {
                if item == ingredient {
                    isSelected = true
                }
            }
        }
    }
}

struct NewRecipeIngredientRowView_Previews: PreviewProvider {
    static var previews: some View {
        NewRecipeIngredientRowView(ingredient: .constant(Ingredient(name: "Testing", points: 0)))
            .environmentObject(IngredientManager())
    }
}
