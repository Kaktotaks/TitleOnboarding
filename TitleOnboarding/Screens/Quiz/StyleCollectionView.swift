//
//  StyleCollectionView.swift
//  TitleOnboarding
//
//  Created by Леонід Шевченко on 23.02.2025.
//

import SwiftUI
import ComposableArchitecture

@Reducer
struct StyleCollectionStore {
    @Dependency(\.apiClient) var apiClient
    
    @ObservableState
    struct State: Equatable {
        var models: [ColorStyleModel] = []
        var pickedItems: Set<ColorStyleModel> = []
        var isLoading: Bool = false
        var parentState: StylistsFocusStore.State
    }
    
    enum Action: BindableAction {
        case toggleItem(ColorStyleModel)
        case navigateToColorsCollection
        case loadModels
        case modelsLoaded([ColorStyleModel])
        case navigateBack
        case binding(BindingAction<State>)
        case parentAction(StylistsFocusStore.Action)
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
                
            case .navigateToColorsCollection:
                return .none /*.send(.delegate(.navigateToColorsCollection)) // Notify parent store*/
                
            case .navigateBack:
                return .none/*send(.delegate(.navigateBack))*/
                
            case .loadModels:
                state.isLoading = true
                return .run { send in
                    let models = await apiClient.fetchStylesModels()
                    await send(.modelsLoaded(models))
                }
                
            case .modelsLoaded(let models):
                state.isLoading = false
                state.models = models
                return .none
            case .binding(_):
                return .none
            case .parentAction(_):
                return .none
            }
        }
    }
}

struct StyleCollectionView: View {
    let store: StoreOf<StyleCollectionStore>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack(alignment: .leading, spacing: 16) {
                Text("Which style best represents you?")
                    .customTextStyle(textStyle: .headtitleOnboarding)
                    .padding(16)
                
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                        ForEach(viewStore.models) { model in
                            CollectionCell(
                                type: .image,
                                model: model,
                                isPicked: Binding(
                                    get: { viewStore.pickedItems.contains(model) },
                                    set: { isPicked in
                                        viewStore.send(.toggleItem(model))
                                    }
                                )
                            )
                            .frame(width: (UIScreen.main.bounds.width / 2) - 24, height: (UIScreen.main.bounds.width / 2) - 24)
                        }
                    }
                    .padding(.horizontal, 14)
                }
                .loadingOverlay(isLoading: viewStore.isLoading)
                .bottomFade()
                .scrollIndicators(.hidden)
                
                MainButton(style: .black , text: "Continue") {
                    viewStore.send(.navigateToColorsCollection)
                }
                .padding([.leading, .trailing, .bottom])
            }
            .setupBackButton() {
                viewStore.send(.navigateBack)
            }
            .onAppear {
                if viewStore.models.isEmpty {
                    viewStore.send(.loadModels)
                }
            }
            .navigationTitle("Style preferences")
            .navigationBarTitleDisplayMode(.inline)
            .frame(alignment: .leading)
        }
    }
}

struct Style_CollectionView: PreviewProvider {
    static var previews: some View {
        StyleCollectionView(store: Store(initialState: StyleCollectionStore.State(parentState: StylistsFocusStore.State()), reducer: { StyleCollectionStore() } ))
    }
}
