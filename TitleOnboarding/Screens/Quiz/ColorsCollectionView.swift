//
//  ColorsCollectionView.swift
//  TitleOnboarding
//
//  Created by Леонід Шевченко on 23.02.2025.
//


import SwiftUI
import ComposableArchitecture

@Reducer
struct ColorsCollectionStore {
    @Dependency(\.apiClient) var apiClient
    
    @ObservableState
    struct State: Equatable {
        var models: [ColorStyleModel] = []
        var pickedItems: Set<ColorStyleModel> = []
        var isLoading: Bool = false
        var paywallPresented: Bool = false
    }
    
    enum Action: BindableAction {
        case toggleItem(ColorStyleModel)
        case togglePaywall
        case loadModels
        case modelsLoaded([ColorStyleModel])
        case navigateBack
        case binding(BindingAction<State>)
        case getFinalResult
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
                
            case .togglePaywall:
                state.paywallPresented.toggle()
                return .none
                
            case .loadModels:
                state.isLoading = true
                return .run { send in
                    let models = await apiClient.fetchColorsModels()
                    await send(.modelsLoaded(models))
                }
                
            case .modelsLoaded(let models):
                state.isLoading = false
                state.models = models
                return .none
                
            case .navigateBack:
                return .none
                
            case .binding(_):
                return .none
            case .getFinalResult:
                return .none
            }
        }
    }
}

struct ColorsCollectionView: View {
    let store: StoreOf<ColorsCollectionStore>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            ZStack {
                if viewStore.paywallPresented {
                    PaywallView(isPresented: viewStore.binding(
                        get: \.paywallPresented,
                        send: ColorsCollectionStore.Action.togglePaywall
                    )) {
                        viewStore.send(.getFinalResult)
                    }
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                    .zIndex(1)
                } else {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Choose favourite colors")
                            .customTextStyle(textStyle: .headtitleOnboarding)
                            .padding(16)
                        
                        ScrollView {
                            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                                ForEach(viewStore.models) { model in
                                    CollectionCell(
                                        type: .color,
                                        model: model,
                                        isPicked: Binding(
                                            get: { viewStore.pickedItems.contains(model) },
                                            set: { isPicked in
                                                viewStore.send(.toggleItem(model))
                                            }
                                        )
                                    )
                                    .frame(width: (UIScreen.main.bounds.width / 3) - 24, height: (UIScreen.main.bounds.width / 3) - 24)
                                }
                            }
                            .padding(.horizontal, 10)
                        }
                        .loadingOverlay(isLoading: viewStore.isLoading)
                        .bottomFade()
                        .scrollIndicators(.hidden)
                        
                        MainButton(style: .black) {
                            withAnimation(.bouncy) {
                                viewStore.send(.togglePaywall)
                            }
                            viewStore.pickedItems.forEach { item in
                                print(item)
                            }
                        }
                        .padding([.leading, .trailing, .bottom])
                    }
                    .onAppear {
                        if viewStore.models.isEmpty {
                            viewStore.send(.loadModels)
                        }
                    }
                    .setupBackButton() {
                        viewStore.send(.navigateBack)
                    }
                    .navigationTitle("Style preferences")
                    .navigationBarTitleDisplayMode(.inline)
                    .frame(alignment: .leading)
                }
            }
        }
    }
}

struct ColorsCollection_Store: PreviewProvider {
    static var previews: some View {
        Group {
            ColorsCollectionView(store: Store(initialState: ColorsCollectionStore.State(), reducer: { ColorsCollectionStore() } ))
                .previewDevice(PreviewDevice(rawValue: "iPhone SE (3rd generation)"))
            
            ColorsCollectionView(store: Store(initialState: ColorsCollectionStore.State(), reducer: { ColorsCollectionStore() } ))
                .previewDevice(PreviewDevice(rawValue: "iPhone 16 Pro Max"))
        }
    }
}
