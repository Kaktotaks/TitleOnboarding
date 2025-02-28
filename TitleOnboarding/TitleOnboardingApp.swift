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
    @StateObject var router = Router()
    
    let store = Store(
        initialState: WelcomeDomain.State(),
        reducer: { WelcomeDomain()}
    )
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.navPath) {
                WelcomeView(store: store)
                    .navigationDestination(for: Router.Destination.self) { destination in
                    router.view(for: destination)
                }
            }
            .environmentObject(router)
        }
    }
}
