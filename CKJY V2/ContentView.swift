//
//  ContentView.swift
//  CKJY V2
//
//  Created by RGS on 21/11/23.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var ingredientManager: IngredientManager
    let lastActionDateKey = "lastActionDate"
    @State private var showSummary = false
    @State private var isSummaryDay = false
    @State private var newPointsGoalString = ""
    @Environment(\.dismiss) var dismiss
    @State private var pressedSaveButton = false
    @AppStorage("hasLaunchedBefore") var hasLaunchedBefore: Bool = false
    @State private var showOnboardingSheet = false
    @State private var days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    @State private var selectedDay = ""
    @State private var summaryDayInt = 2
    
    var body: some View {
        TabView {
            RecipesView()
                .tabItem {
                    Label("Recipes", systemImage: "takeoutbag.and.cup.and.straw")
                }
            FoodListView()
                .tabItem {
                    Label("Food List", systemImage: "list.clipboard")
                }
            ProgressView()
                .tabItem {
                    Label("Progress", systemImage: "circle.circle")
                }
        }
        .onAppear {
            if !hasLaunchedBefore {
                showOnboardingSheet = true
                isSummaryDay = true
            }
            performActionIfNeeded()
        }
        .sheet(isPresented: $showSummary, onDismiss: {
            if !pressedSaveButton {
                newPointsGoalString = ""
            } else {
                pressedSaveButton = false
            }
        }) {
            NavigationStack {
                Form {
                    HStack {
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
                        .padding()
                        Spacer()
                    }
                    Section("") {
                        Text("You achieved \(Int(Double(ingredientManager.totalPoints) / Double(ingredientManager.pointsGoal) * 100))% of your goal! Congratulations!")
                        TextField("New Goal", text: $newPointsGoalString)
                            .keyboardType(.numberPad)
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Cancel", role: .destructive) {
                            newPointsGoalString = ""
                            dismiss()
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Save") {
                            ingredientManager.pointsGoal = Int(newPointsGoalString) ?? 0
                            newPointsGoalString = ""
                            dismiss()
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $showOnboardingSheet, onDismiss: {
            hasLaunchedBefore = true
        }) {
            Form {
                Text("Goal-Setting")
                    .font(.title)
                Text("Hello User!")
                    .font(.title)
                Text("This app uses a self-set goal method to help you on your healthy-eating journey. Before you start, please choose your preferences:")
                TextField("Starting Goal", text: $newPointsGoalString)
                    .keyboardType(.numberPad)
                Picker("Goal Reset Day", selection: $selectedDay) {
                    ForEach(days, id:\.self) {
                        Text($0)
                    }
                }
                Button("Save") {
                    ingredientManager.pointsGoal = Int(newPointsGoalString) ?? 0
                    newPointsGoalString = ""
                    switch selectedDay {
                    case "Monday":
                        summaryDayInt = 2
                    case "Tuesday":
                        summaryDayInt = 3
                    case "Wednesday":
                        summaryDayInt = 4
                    case "Thursday":
                        summaryDayInt = 5
                    case "Friday":
                        summaryDayInt = 6
                    case "Saturday":
                        summaryDayInt = 7
                    case "Sunday":
                        summaryDayInt = 1
                    default:
                        summaryDayInt = 2
                    }
                    showOnboardingSheet = false
                    hasLaunchedBefore = true
                }
            }
        }
    }
    func performActionIfNeeded() {
        let calendar = Calendar.current
        let now = Date()

        // Check if today is Monday
        if calendar.component(.weekday, from: now) == summaryDayInt && !isSummaryDay && hasLaunchedBefore {
            isSummaryDay = true
            showSummary = true
            print("Action performed on Monday!")

            // Update UserDefaults with the current date
            UserDefaults.standard.set(now, forKey: lastActionDateKey)
        }
        if calendar.component(.weekday, from: now) != summaryDayInt {
            isSummaryDay = false
            print("can show sheet again")
        }
    }

}






struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(IngredientManager())
    }
}
