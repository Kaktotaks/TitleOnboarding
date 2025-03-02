//
//  StylistsFocusView.swift
//  TitleOnboarding
//
//  Created by Леонід Шевченко on 23.02.2025.
//

import SwiftUI
import ComposableArchitecture

@Reducer
struct StylistsFocusStore {
    @Dependency(\.apiClient) var apiClient
    
    @Reducer(state: .equatable)
    enum Destination {
        case styleCollectionView(StyleCollectionStore)
        case colorsCollectionView(ColorsCollectionStore)
    }
    
    @ObservableState
    struct State: Equatable {
        var models: [FocusModel] = []
        var pickedItems: Set<FocusModel> = []
        var isLoading: Bool = false
        var path = StackState<Destination.State>()
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case toggleItem(FocusModel)
        case loadModels
        case modelsLoaded([FocusModel])
        
        case path(StackAction<Destination.State, Destination.Action>)
        case showStyleCollectionView
        case showColorsCollectionView
    }
    
    var body: some Reducer<State, Action> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .toggleItem(let model):
                if state.pickedItems.contains(model) {
                    state.pickedItems.remove(model)
                } else {
                    state.pickedItems.insert(model)
                }
                return .none
                
            case .loadModels:
                state.isLoading = true
                return .run { send in
                    let models = await apiClient.fetchFocusModels()
                    await send(.modelsLoaded(models))
                }
                
            case .modelsLoaded(let models):
                state.isLoading = false
                state.models = models
                return .none
                
                // Navigation
            case .binding(_):
                return .none
            case .path(.popFrom(id: _)):
                state.path.removeAll()
                return .none
            case .path(.element(id: _, action: .styleCollectionView(.navigateToColorsCollection))):
                state.path.append(.colorsCollectionView(ColorsCollectionStore.State()))
                return .none
                
            case .path(.element(id: _, action: .styleCollectionView(.navigateBack))), .path(.element(id: _, action: .colorsCollectionView(.navigateBack))):
                state.path.popLast()
                return .none
                
            case .path(_):
                return .none
                
            case .showStyleCollectionView:
                state.path.append(.styleCollectionView(StyleCollectionStore.State(parentState: state)))
                return .none
                
            case .showColorsCollectionView:
                state.path.append(.colorsCollectionView(ColorsCollectionStore.State()))
                return .none
            }
        }
        .forEach(\.path, action: \.path)
    }
}

struct StylistsFocusView: View {
    @State var store: StoreOf<StylistsFocusStore>
    
    var body: some View {
        NavigationStack(
            path: $store.scope(state: \.path, action: \.path)
        ) {
            WithViewStore(self.store, observe: { $0 }) { viewStore in
                ZStack {
                    VStack(alignment: .leading, spacing: 16) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("What’d you like our stylists to focus on?")
                                .customTextStyle(textStyle: .headtitleQuize)
                            Text("We offer services via live-chat mode.")
                                .customTextStyle(textStyle: .subheadline)
                        }
                        .padding(18)
                        
                        List {
                            ForEach(viewStore.models) { model in
                                TableCell(
                                    model: model,
                                    isPicked: Binding(
                                        get: { viewStore.pickedItems.contains(model) },
                                        set: { _ in
                                            viewStore.send(.toggleItem(model))
                                        }
                                    )
                                )
                                .listRowSeparator(.hidden)
                            }
                        }
                        .loadingOverlay(isLoading: viewStore.isLoading)
                        .bottomFade()
                        .scrollIndicators(.hidden)
                        .listStyle(.plain)
                        
                        MainButton(style: .black , text: "Continue") {
                            viewStore.pickedItems.forEach { item in
                                print(item)
                            }
                            viewStore.send(.showStyleCollectionView)
                        }
                        .padding([.leading, .trailing, .bottom], 20)
                    }
                    .frame(alignment: .leading)
                    .navigationTitle("Lifestyle & Interests")
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationBarBackButtonHidden()
                }
                .onAppear {
                    if viewStore.models.isEmpty {
                        viewStore.send(.loadModels)
                    }
                }
            }
            
        } destination: { state in
            switch state.case {
            case .colorsCollectionView(let store):
                ColorsCollectionView(store: store)
            case .styleCollectionView(let store):
                StyleCollectionView(store: store)
            }
        }
    }
}

struct Stylists_Focus_View: PreviewProvider {
    static var previews: some View {
        StylistsFocusView(store: Store(initialState: StylistsFocusStore.State(), reducer: { StylistsFocusStore() } ))
    }
}
