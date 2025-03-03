//
//  WelcomeView.swift
//  TitleOnboarding
//
//  Created by Леонід Шевченко on 23.02.2025.
//

import SwiftUI
import ComposableArchitecture

struct WelcomeView: View {
    @State var store: StoreOf<RootStore>
    
    var body: some View {
        NavigationStack(
            path: $store.scope(state: \.path, action: \.path)
        ) {
            WithViewStore(self.store, observe: { $0 }) { viewStore in
                VStack {
                    VStack {
                        Spacer()
                        
                        HStack() {
                            Text(viewStore.welcomeViewTitle)
                                .customTextStyle(textStyle: .welcomeTitle)
                            Spacer()
                        }
                        
                        MainButton(style: .white) {
                            viewStore.send(.showOnboardingView)
                        }
                        .padding([.bottom])
                    }
                    .padding(.horizontal, 20)
                }
                .background(
                    Image(.welcome)
                        .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all)
                        .bottomFade(height: 600, startColor: .black)
                )
            }
        } destination: { state in
            switch state.case {
            case .colorsCollectionView(let store):
                ColorsCollectionView(store: store)
            case .styleCollectionView(let store):
                StyleCollectionView(store: store)
            case .onboardingView(let store):
                OnboardingView(store: store)
            case .stylistsFocusView(let store):
                StylistsFocusView(store: store)
            }
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView(store: Store(initialState: RootStore.State(), reducer: { RootStore() } ))
    }
}
