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
    
    struct State: Equatable {
        var models: [ColorStyleModel] = []
        var pickedItems: Set<ColorStyleModel> = []
        var isLoading: Bool = false
    }
    
    
    enum Action: Equatable {
        case toggleItem(ColorStyleModel)
        case navigateToColorsCollection
        case loadModels
        case modelsLoaded([ColorStyleModel])
        case navigateBack
    }
    
    var body: some Reducer<State, Action> {
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
                return .none
                
            case .navigateBack:
                return .none
                
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
            }
        }
    }
}

struct StyleCollectionView: View {
    @EnvironmentObject var router: Router
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
                    //                    viewStore.send(.navigateToColorsCollection)
                    router.navigate(to: .colorsCollectionView)
                    viewStore.pickedItems.forEach { item in
                        print(item)
                    }
                }
                .padding([.leading, .trailing, .bottom])
            }
            .setupBackButton() {
                //                viewStore.send(.navigateBack)
                router.navigateBack()
            }
            .onAppear {
                viewStore.send(.loadModels)
            }
            .navigationTitle("Style preferences")
            .navigationBarTitleDisplayMode(.inline)
            .frame(alignment: .leading)
        }
    }
}

struct Style_CollectionView: PreviewProvider {
    static var previews: some View {
        StyleCollectionView(store: Store(initialState: StyleCollectionStore.State(), reducer: { StyleCollectionStore() } ))
    }
}
