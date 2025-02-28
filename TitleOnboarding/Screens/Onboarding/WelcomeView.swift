//
//  WelcomeView.swift
//  TitleOnboarding
//
//  Created by Леонід Шевченко on 23.02.2025.
//

import SwiftUI
import ComposableArchitecture

struct WelcomeView: View {
    @EnvironmentObject var router: Router
    let store: StoreOf<WelcomeDomain>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack {
                VStack {
                    Spacer()
                    
                    HStack() {
                        Text("""
                             Online Personal
                             Styling.
                             Outfits for
                             Every Woman.
                             """)
                        .customTextStyle(textStyle: .welcomeTitle)
                        Spacer()
                    }
                    
                    MainButton(style: .white, text: "CONTINUE") {
                        router.navigate(to: .onboardingView)
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
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView(store: Store(initialState: WelcomeDomain.State(), reducer: { WelcomeDomain() } ))
    }
}
