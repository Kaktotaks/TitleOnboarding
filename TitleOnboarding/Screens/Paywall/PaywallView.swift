//
//  Paywall.swift
//  TitleOnboarding
//
//  Created by Леонід Шевченко on 24.02.2025.
//

import SwiftUI

struct PaywallView: View {
    @State private var selectedModel: PlanModel?
    @Binding var isPresented: Bool
    
    let models: [PlanModel] = [
        .init(period: "TRY 3 DAYS", price: "FOR FREE", description: "then $29.99 billed monthly", isHot: true),
        .init(period: "Quarterly", price: "$59.99", description: "billed quarterly"),
        .init(period: "Lifetime", price: "$99.99", description: "one-time payment")
    ]
    
    init(isPresented: Binding<Bool>) {
        _selectedModel = State(initialValue: models.first { $0.isHot })
        _isPresented = isPresented
    }
    
    var body: some View {
        ScrollView(.vertical) {
            VStack() {
                VStack {
                    Image(.paywallBackgroundShort)
                        .resizable()
                        .scaledToFit()
                        .edgesIgnoringSafeArea(.all)
                    
                    Spacer()
                }
                
                VStack {
                    Spacer()
                    MainInfoView()
                        .padding()
                    
                    PlansViewView(selectedModel: $selectedModel, models: models)
                        .padding()
                        .frame(height: 170)
                    
                    Text("Auto-renewable. Cancel anytime.")
                        .customTextStyle(textStyle: .secondary(size: 14))
                        .padding()
                    
                    BottomView(pickedPlan: $selectedModel)
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

struct PaywallView_Previews: PreviewProvider {
    static var previews: some View {
        PaywallView(isPresented: .constant(true))
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
                        isSelected: selectedModel == model,
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
    
    var body: some View {
        VStack(spacing: 4) {
            MainButton(style: .black , text: "Continue") {
                print(pickedPlan ?? "")
            }
            .padding([.bottom, .leading, .trailing])
            
            HStack(spacing: 8) {
                Text("Terms of Use")
                    .onTapGesture {
                        print("Terms of use tapped")
                    }
                    .customTextStyle(textStyle: .secondary(size: 14))
                    .underline()
                
                Text("|")
                    .foregroundColor(.gray)
                
                Text("Privacy Policy")
                    .onTapGesture {
                        print("Privacy Policy tapped")
                    }
                    .customTextStyle(textStyle: .secondary(size: 14))
                    .underline()
            }
        }
    }
}
