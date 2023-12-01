//
//  IngredientNewRowView.swift
//  CKJY V2
//
//  Created by RGS on 22/11/23.
//

import SwiftUI

struct IngredientNewRowView: View {
    
    @Binding var ingredientNew: Ingredient
    @EnvironmentObject var ingredientManager: IngredientManager
    
    
    var body: some View {
        HStack {
         //   Image(systemName: "square")
            VStack(alignment: .leading) {
                Text(ingredientNew.name)
                HStack {
                    Text("\(ingredientNew.points)")
                    Image(systemName: "leaf.fill")
                }
                .font(.footnote)
                .foregroundColor(.gray)
            }
            Spacer()
            Image(systemName: ingredientNew.points == -1 ? "hand.thumbsdown.circle.fill" : ingredientNew.points == 0 ? "minus.circle.fill" : "hand.thumbsup.circle.fill")
        }
        .onAppear {
            ingredientNew.isSelected = false
            for item in ingredientManager.selectedIngredients {
                if item == ingredientNew {
                    ingredientNew.isSelected = true
                }
            }
        }
    }
}

struct IngredientNewRowView_Previews: PreviewProvider {
    static var previews: some View {
        IngredientNewRowView(ingredientNew: .constant(Ingredient(name: "Testing", points: 0)))
            .environmentObject(IngredientManager())
    }
}
