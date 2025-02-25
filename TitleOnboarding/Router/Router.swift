//
//  Router.swift
//  TitleOnboarding
//
//  Created by Леонід Шевченко on 25.02.2025.
//

import SwiftUI

final class Router: NSObject, ObservableObject {
    
    public enum Destination: Hashable {
        case onboardingView
        case welcomeView
        case stylistsFocusView
        case styleCollectionView
        case colorsCollectionView
        case paywallView
    }
    
    @Published var navPath = NavigationPath()
//    @Published var currentRoot: Destination = UserData.isAuthenticated ?
    
    // Builds the views
    @ViewBuilder func view(for destination: Destination) -> some View {
        switch destination {
            case .welcomeView:
            WelcomeView()
        case .stylistsFocusView:
            StylistsFocusView()
        case .styleCollectionView:
            StyleCollectionView()
        case .colorsCollectionView:
            ColorsCollectionView()
        case .onboardingView:
            OnboardingView()
        case .paywallView:
            PaywallView()
        }
    }
    
    func navigate(to destination: Destination) {
        navPath.append(destination)
    }
    
    func navigateBack() {
        navPath.removeLast()
    }
    
    func navigateToRoot() {
        navPath.removeLast(navPath.count)
    }
}
