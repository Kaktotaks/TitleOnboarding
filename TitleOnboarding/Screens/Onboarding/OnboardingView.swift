//
//  OnboardingView.swift
//  TitleOnboarding
//
//  Created by Леонід Шевченко on 23.02.2025.
//


import SwiftUI
import ComposableArchitecture

@Reducer
struct OnboardingStore {
    struct State: Equatable {
        var onboardingData: [OnboardingItem] = [
            OnboardingItem(
                title: "Your Personal Stylist",
                subtitle: "who matches you perfectly",
                imageName: "StylistOnboardingImage"
            ),
            OnboardingItem(
                title: "Curated outfits",
                subtitle: "of high quality and multiple brands",
                imageName: "OutfitsOnboardingImage"
            ),
            OnboardingItem(
                title: "Weekly Outfit Selections",
                subtitle: "hand-picked by your stylist",
                imageName: "WeeklyOnboardingImage"
            )
        ]
    }
    
    enum Action: BindableAction {
        case showStylistFocusView
        case binding(BindingAction<State>)
    }
    
    var body: some Reducer<State, Action> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .showStylistFocusView, .binding:
                return .none
            }
        }
    }
}

struct OnboardingView: View {
    @State private var currentPage = 0
    let store: StoreOf<OnboardingStore>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack {
                VStack {
                    Text(viewStore.onboardingData[currentPage].title)
                        .customTextStyle(textStyle: .headtitleOnboarding)
                    
                    Text(viewStore.onboardingData[currentPage].subtitle)
                        .customTextStyle(textStyle: .subheadline)
                }
                .padding(20)
                .animation(.easeOut, value: currentPage)
                
                TabView(selection: $currentPage) {
                    ForEach(0..<viewStore.onboardingData.count, id: \.self) { index in
                        Image(viewStore.onboardingData[index].imageName)
                            .resizable()
                            .padding(.bottom, 20)
                            .scaledToFit()
                            .tag(index)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                
                HStack {
                    ForEach(0..<viewStore.onboardingData.count, id: \.self) { index in
                        Image(index == currentPage ? .circlePicked : .circle)
                            .frame(width: 10, height: 10)
                            .padding(.horizontal, 2)
                            .animation(.easeOut, value: currentPage)
                            .onTapGesture {
                                currentPage = index
                            }
                    }
                }
                .padding(.bottom, 24)
                
                MainButton(style: .black) {
                    viewStore.send(.showStylistFocusView)
                }
                .padding(.bottom)
                .padding(.horizontal, 20)
                
                HStack {
                    Text("By tapping Get started or I already have an account, you agree to our Terms of Use and Privacy Policy." )
                        .padding()
                        .multilineTextAlignment(.center)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                .padding(.horizontal, 16)
            }
            .navigationBarHidden(true)
        }
    }
}

struct OnboardingItem: Equatable {
    let title: String
    let subtitle: String
    let imageName: String
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(store: Store(initialState: OnboardingStore.State(), reducer: { OnboardingStore() } ))
    }
}
