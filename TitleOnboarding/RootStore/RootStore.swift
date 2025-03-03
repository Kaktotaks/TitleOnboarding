//
//  AppStore.swift
//  TitleOnboarding
//
//  Created by Леонід Шевченко on 27.02.2025.
//

import SwiftUI
import ComposableArchitecture

@Reducer
struct RootStore {
    @Dependency(\.apiClient) var apiClient
    
    @Reducer(state: .equatable)
    enum Destination {
        case onboardingView(OnboardingStore)
        case stylistsFocusView(StylistsFocusStore)
        case styleCollectionView(StyleCollectionStore)
        case colorsCollectionView(ColorsCollectionStore)
    }
    
    @ObservableState
    struct State: Equatable {
        var path = StackState<Destination.State>()
        var welcomeViewTitle: String = """
                             Online Personal
                             Styling.
                             Outfits for
                             Every Woman.
                             """
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case showOnboardingView
        case path(StackAction<Destination.State, Destination.Action>)
    }
    
    var body: some Reducer<State, Action> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .path(.element(id: _, action: .colorsCollectionView(.getFinalResult))):
                state.getAllPickedItems()
                return .none
            case .binding(_):
                return .none
            case .path(.popFrom(id: _)):
                state.path.removeAll()
                return .none
            case .path(.element(id: _, action: .styleCollectionView(.navigateToColorsCollection))):
                state.path.append(.colorsCollectionView(ColorsCollectionStore.State()))
                return .none
            case .path(.element(id: _, action: .onboardingView(.showStylistFocusView))):
                state.path.append(.stylistsFocusView(StylistsFocusStore.State()))
                return .none
            case .path(.element(id: _, action: .stylistsFocusView(.showStyleCollectionView))):
                state.path.append(.styleCollectionView(StyleCollectionStore.State()))
                return .none
            case .path(.element(id: _, action: .styleCollectionView(.navigateBack))),
                    .path(.element(id: _, action: .colorsCollectionView(.navigateBack))):
                state.path.popLast()
                return .none
            case .path(_):
                return .none
            case .showOnboardingView:
                state.path.append(.onboardingView(OnboardingStore.State()))
                return .none
            }
        }
        .forEach(\.path, action: \.path)
    }
}

extension RootStore.State {
    func getAllPickedItems() -> (Set<FocusModel>, Set<ColorStyleModel>, Set<ColorStyleModel>) {
        var stylistsFocusPickedItems: Set<FocusModel> = []
        var styleCollectionPickedItems: Set<ColorStyleModel> = []
        var colorsCollectionPickedItems: Set<ColorStyleModel> = []
        
        for destination in path {
            switch destination {
            case .stylistsFocusView(let state):
                stylistsFocusPickedItems = state.pickedItems
            case .styleCollectionView(let state):
                styleCollectionPickedItems = state.pickedItems
            case .colorsCollectionView(let state):
                colorsCollectionPickedItems = state.pickedItems
            default:
                break
            }
        }
        
        stylistsFocusPickedItems.map {
            let name = $0.title
            print("Stylists Focus Picked Items: \(name)")
        }
        
        styleCollectionPickedItems.map {
            let name = $0.title
            print("Style Collection Picked Items: \(name)")
        }
        
        colorsCollectionPickedItems.map {
            let name = $0.title
            print("Colors Collection Picked Items: \(name)")
        }
        
        return (stylistsFocusPickedItems, styleCollectionPickedItems, colorsCollectionPickedItems)
    }
}
