//
//  RecipeIngredientRowView.swift
//  CKJY V2
//
//  Created by RGS on 25/11/23.
//

import SwiftUI

struct RecipeIngredientRowView: View {
    
    @EnvironmentObject var ingredientManager: IngredientManager
    @Binding var recipeIngredient: RecipeIngredient
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(recipeIngredient.ingredient.name)
                HStack {
                    Text("\(recipeIngredient.ingredient.points)")
                    Image(systemName: "leaf.fill")
                }
                .font(.footnote)
                .foregroundColor(.gray)
            }
            Spacer()
            TextField("Amount", text: $recipeIngredient.amount)
                .multilineTextAlignment(.trailing)
                .foregroundColor(.gray)
            Image(systemName: recipeIngredient.ingredient.points == -1 ? "hand.thumbsdown.circle.fill" : recipeIngredient.ingredient.points == 0 ? "minus.circle.fill" : "hand.thumbsup.circle.fill")
            }
                .foregroundColor(recipeIngredient.ingredient.points == -1 ? .red : recipeIngredient.ingredient.points == 0 ? Color(red: 0.95, green: 0.7, blue: 0) : .green)
            }
        }
        

struct RecipeIngredientRowView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeIngredientRowView(recipeIngredient: .constant(.init(ingredient: .init(name: "Broccoli", points: 1))))
            .environmentObject(IngredientManager())
    }
}
