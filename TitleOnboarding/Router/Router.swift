//
//  Router.swift
//  TitleOnboarding
//
//  Created by Леонід Шевченко on 25.02.2025.
//

import SwiftUI
import ComposableArchitecture

final class Router: NSObject, ObservableObject {
    @Published var navPath = NavigationPath() {
            didSet {
                print("navPath changed: \(navPath)")
            }
        }
    
    public enum Destination: Hashable {
        case onboardingView
        case welcomeView
        case stylistsFocusView
        case styleCollectionView
        case colorsCollectionView
        case paywallView
    }
    
    @ViewBuilder func view(for destination: Destination) -> some View {
        switch destination {
        case .welcomeView:
            WelcomeView(store: Store(initialState: WelcomeDomain.State(), reducer: { WelcomeDomain() } ))
        case .onboardingView:
            OnboardingView(store: Store(initialState: OnboardingDomain.State(), reducer: { OnboardingDomain() } ))
        case .stylistsFocusView:
            StylistsFocusView(store: Store(initialState: StylistsFocusStore.State(), reducer: { StylistsFocusStore() } ))
        case .styleCollectionView:
            StyleCollectionView(store: Store(initialState: StyleCollectionStore.State(parentState: StylistsFocusStore.State()), reducer: { StyleCollectionStore() } ))
        case .colorsCollectionView:
            ColorsCollectionView(store: Store(initialState: ColorsCollectionStore.State(), reducer: { ColorsCollectionStore() } ))
        case .paywallView:
            PaywallView(isPresented: .constant(false))
        }
    }
    
    func navigate(to destination: Destination) {
        print("Navigating to: \(destination)")
        navPath.append(destination)
        print("navPath: \(navPath)")
    }
    
    func navigateBack() {
        navPath.removeLast()
    }
    
    func navigateToRoot() {
        navPath.removeLast(navPath.count)
    }
}
