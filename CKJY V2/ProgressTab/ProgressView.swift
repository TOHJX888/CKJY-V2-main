//
//  ProgressView.swift
//  CKJY V2
//
//  Created by RGS on 22/11/23.
//

import SwiftUI

struct ProgressView: View {
    
    @EnvironmentObject var ingredientManager: IngredientManager
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("   Current points: \(ingredientManager.totalPoints)")
                        .font(.title2)
                    Image(systemName: "leaf.fill")
                    Spacer()
                }
                Spacer()
                ZStack {
                    Circle()
                        .stroke( // 1
                            Color.blue.opacity(0.5),
                            lineWidth: 30
                        )
                    Circle() // 2
                        .trim(from: 0, to: CGFloat(ingredientManager.totalPoints) / CGFloat(ingredientManager.pointsGoal)) // 1
                        .stroke(Color.blue,
                                style: StrokeStyle(
                                    lineWidth: 30,
                                    lineCap: .round
                                )
                        )
                        .rotationEffect(.degrees(-90))
                        .animation(.easeOut, value: CGFloat(ingredientManager.totalPoints) / CGFloat(ingredientManager.pointsGoal))
                    
                }
                .frame(width: 200, height: 200)
                Spacer()
                HStack {
                    Text("Goal: \(ingredientManager.pointsGoal)")
                        .font(.title)
                    Image(systemName: "leaf.fill")
                }
                
                ////            }
                .padding()
                Spacer()
            }
            .navigationTitle("My Progress View")
        }
    }
    
}

struct ProgressView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressView()
            .environmentObject(IngredientManager())
    }
}


