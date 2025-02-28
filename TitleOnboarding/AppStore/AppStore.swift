//
//  AppStore.swift
//  TitleOnboarding
//
//  Created by Леонід Шевченко on 27.02.2025.
//

import SwiftUI
import ComposableArchitecture

//@Reducer
//struct AppStore {
//    struct State: Equatable {
//        var stylistsFocusState: StylistsFocusStore.State
//        var StyleCollectionState: SecondScreenReducer.State
//        var thirdScreen: ThirdScreenReducer.State
//        var selectedFirstModels: [FirstModel] = []
//        var selectedSecondModels: [SecondModel] = []
//        var selectedThirdModels: [ThirdModel] = []
//    }
//
//    enum Action: Equatable {
//        case firstScreen(FirstScreenReducer.Action)
//        case secondScreen(SecondScreenReducer.Action)
//        case thirdScreen(ThirdScreenReducer.Action)
//    }
//
//    var body: some Reducer<State, Action> {
//        Scope(state: \.firstScreen, action: /Action.firstScreen) {
//            FirstScreenReducer()
//        }
//        Scope(state: \.secondScreen, action: /Action.secondScreen) {
//            SecondScreenReducer()
//        }
//        Scope(state: \.thirdScreen, action: /Action.thirdScreen) {
//            ThirdScreenReducer()
//        }
//        Reduce { state, action in
//            switch action {
//            case .firstScreen(.selectModel(let model)):
//                if state.selectedFirstModels.contains(model) {
//                    state.selectedFirstModels.removeAll { $0 == model }
//                } else {
//                    state.selectedFirstModels.append(model)
//                }
//                return .none
//            case .secondScreen(.selectModel(let model)):
//                if state.selectedSecondModels.contains(model) {
//                    state.selectedSecondModels.removeAll { $0 == model }
//                } else {
//                    state.selectedSecondModels.append(model)
//                }
//                return .none
//            case .thirdScreen(.selectModel(let model)):
//                if state.selectedThirdModels.contains(model) {
//                    state.selectedThirdModels.removeAll { $0 == model }
//                } else {
//                    state.selectedThirdModels.append(model)
//                }
//                return .none
//            case .thirdScreen(.goToPayWall):
//                return .none
//            }
//        }
//    }
//}
