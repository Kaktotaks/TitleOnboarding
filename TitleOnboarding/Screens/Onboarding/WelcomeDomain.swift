//
//  WelcomeDomain.swift
//  TitleOnboarding
//
//  Created by Леонід Шевченко on 26.02.2025.
//

import SwiftUI
import ComposableArchitecture

@Reducer
struct WelcomeDomain {
    struct State: Equatable {
    }
    
    enum Action: Equatable {
        case navigateToOnboarding
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .navigateToOnboarding:
                return .none
            }
        }
    }
}
