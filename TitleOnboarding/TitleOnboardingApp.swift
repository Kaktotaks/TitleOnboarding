//
//  TitleOnboardingApp.swift
//  TitleOnboarding
//
//  Created by Леонід Шевченко on 23.02.2025.
//

import SwiftUI

@main
struct TitleOnboardingApp: App {
    @StateObject var router = Router()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.navPath) {
                WelcomeView()
                    .navigationDestination(for: Router.Destination.self) { destination in
                        router.view(for: destination)
                    }
            }
            .environmentObject(router)
        }
    }
}
