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
    
    struct State: Equatable {
        var models: [FocusModel] = []
        var pickedItems: Set<FocusModel> = []
        var isLoading: Bool = false
    }
    
    enum Action: Equatable {
        case toggleItem(FocusModel)
        case continueButtonTapped
        case loadModels
        case modelsLoaded([FocusModel])
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
                
            case .continueButtonTapped:
                state.pickedItems.forEach { item in
                    print(item)
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
            }
        }
    }
}

struct StylistsFocusView: View {
    @EnvironmentObject var router: Router
    
    let store: StoreOf<StylistsFocusStore>
    
    var body: some View {
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
                        router.navigate(to: .styleCollectionView)
                    }
                    .padding([.leading, .trailing, .bottom], 20)
                }
                .frame(alignment: .leading)
                .navigationTitle("Lifestyle & Interests")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarBackButtonHidden()
            }
            .onAppear {
                viewStore.send(.loadModels)
            }
        }
    }
}

struct Stylists_Focus_View: PreviewProvider {
    static var previews: some View {
        StylistsFocusView(store: Store(initialState: StylistsFocusStore.State(), reducer: { StylistsFocusStore() } ))
    }
}
