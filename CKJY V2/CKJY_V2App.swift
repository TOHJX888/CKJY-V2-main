//
//  CKJY_V2App.swift
//  CKJY V2
//
//  Created by RGS on 21/11/23.
//

import SwiftUI

@main
struct CKJY_V2App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(IngredientManager())
        }
    }
}
