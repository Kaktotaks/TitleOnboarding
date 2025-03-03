//
//  TitleOnboardingApp.swift
//  TitleOnboarding
//
//  Created by Леонід Шевченко on 23.02.2025.
//

import SwiftUI
import ComposableArchitecture

@main
struct TitleOnboardingApp: App {
    let store = Store(
        initialState: RootStore.State(),
        reducer: { RootStore()}
    )
    
    var body: some Scene {
        WindowGroup {
            WelcomeView(store: store)
                .preferredColorScheme(.light)
        }
    }
}
