//
//  Paywall.swift
//  TitleOnboarding
//
//  Created by Леонід Шевченко on 24.02.2025.
//

import SwiftUI
import ComposableArchitecture

@Reducer
struct PaywallStore {
    @ObservableState
    struct State: Equatable {
        var plans: [PlanModel] = [
            .init(period: "TRY 3 DAYS", price: "FOR FREE", description: "then $29.99 billed monthly", isHot: true),
            .init(period: "Quarterly", price: "$59.99", description: "billed quarterly"),
            .init(period: "Lifetime", price: "$99.99", description: "one-time payment")
        ]
        var selectedPlan: PlanModel?
        
        init() { self.selectedPlan = plans.first }
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case selectPlan(PlanModel?)
        case continueButtonTapped
        case termsOfUseTapped
        case privacyPolicyTapped
    }
    
    var body: some Reducer<State, Action> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .selectPlan(let plan):
                state.selectedPlan = plan
                return .none
                
            case .continueButtonTapped:
                if let selectedPlan = state.selectedPlan {
                    print("Selected Plan: \(selectedPlan)")
                }
                return .none
                
            case .termsOfUseTapped:
                print("Terms of Use tapped")
                return .none
                
            case .privacyPolicyTapped:
                print("Privacy Policy tapped")
                return .none
                
            case .binding(_):
                return .none
            }
        }
    }
}

struct PaywallView: View {
    @State private var selectedModel: PlanModel?
    @Binding var isPresented: Bool
    let store = Store(initialState: PaywallStore.State(), reducer: { PaywallStore() } )
    var onContinue: () -> Void
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            ScrollView(.vertical) {
                VStack {
                    Image(.paywallBackgroundShort)
                        .resizable()
                        .scaledToFit()
                        .edgesIgnoringSafeArea(.all)
                    
                    VStack {
                        Spacer()
                        MainInfoView()
                            .padding()
                        
                        PlansViewView(
                            selectedModel: Binding(
                                get: { viewStore.selectedPlan },
                                set: { viewStore.send(.selectPlan($0)) }
                            ),
                            models: viewStore.plans
                        )
                        .padding()
                        .frame(height: 170)
                        
                        Text("Auto-renewable. Cancel anytime.")
                            .customTextStyle(textStyle: .secondary(size: 14))
                            .padding()
                        
                        BottomView(
                            pickedPlan: Binding(
                                get: { viewStore.selectedPlan },
                                set: { viewStore.send(.selectPlan($0)) }
                            ),
                            onContinue: {
                                viewStore.send(.continueButtonTapped)
                                onContinue()
                            },
                            onTermsOfUseTapped: {
                                viewStore.send(.termsOfUseTapped)
                            },
                            onPrivacyPolicyTapped: {
                                viewStore.send(.privacyPolicyTapped)
                            }
                        )
                    }
                }
            }
            .setupBackButton() {
                withAnimation(.bouncy) {
                    isPresented = false
                }
            }
            .edgesIgnoringSafeArea(.all)
            .scrollIndicators(.hidden)
        }
    }
}

fileprivate struct MainInfoView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            HStack(spacing: 8) {
                ForEach(0..<5, id: \.self) { _ in
                    Image(.paywallStar)
                }
            }
            
            Text("First meeting with a stylist")
                .customTextStyle(textStyle: .subheadtitleQuize)
            
            Text("Tessa caught my style with the first outfit she put together. Although we changed a few things she was great at finding what works for me!")
                .customTextStyle(textStyle: .secondary(size: 14))
        }
        .padding(8)
    }
}

fileprivate struct PlansViewView: View {
    @Binding var selectedModel: PlanModel?
    let models: [PlanModel]
    
    var body: some View {
        VStack(alignment: .center) {
            HStack(alignment: .bottom, spacing: 16) {
                ForEach(models) { model in
                    PlanCell(
                        isSelected: Binding(
                            get: { selectedModel == model },
                            set: { _ in selectedModel = model }
                        ),
                        period: model.period,
                        price: model.price,
                        description: model.description,
                        isHot: model.isHot
                    )
                    .onTapGesture {
                        withAnimation {
                            selectedModel = model
                        }
                    }
                }
            }
        }
    }
}

fileprivate struct BottomView: View {
    @Binding var pickedPlan: PlanModel?
    var onContinue: () -> Void
    var onTermsOfUseTapped: () -> Void
    var onPrivacyPolicyTapped: () -> Void
    
    var body: some View {
        VStack(spacing: 4) {
            MainButton(style: .black) {
                onContinue()
            }
            .padding([.bottom, .leading, .trailing])
            
            HStack(spacing: 8) {
                Text("Terms of Use")
                    .onTapGesture {
                        onTermsOfUseTapped()
                    }
                    .customTextStyle(textStyle: .secondary(size: 14))
                    .underline()
                
                Text("|")
                    .foregroundColor(.gray)
                
                Text("Privacy Policy")
                    .onTapGesture {
                        onPrivacyPolicyTapped()
                    }
                    .customTextStyle(textStyle: .secondary(size: 14))
                    .underline()
            }
        }
    }
}
