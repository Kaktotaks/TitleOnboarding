//
//  OnboardingView.swift
//  TitleOnboarding
//
//  Created by Леонід Шевченко on 23.02.2025.
//


import SwiftUI

struct OnboardingView: View {
    @State private var currentPage = 0
    @State private var offset: CGFloat = 0
    @EnvironmentObject var router: Router
    
    let onboardingData: [OnboardingItem] = [
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
    
    var body: some View {
        VStack {
            VStack {
                Text(onboardingData[currentPage].title)
                    .customTextStyle(textStyle: .headtitleOnboarding)
                
                Text(onboardingData[currentPage].subtitle)
                    .customTextStyle(textStyle: .subheadline)
            }
            .padding(20)
            .animation(.easeOut, value: currentPage)
            
            TabView(selection: $currentPage) {
                ForEach(0..<onboardingData.count, id: \.self) { index in
                    Image(onboardingData[index].imageName)
                        .resizable()
                        .padding(.bottom, 20)
                        .scaledToFit()
                        .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            
            HStack {
                ForEach(0..<onboardingData.count, id: \.self) { index in
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
            
            MainButton(style: .black, text: "CONTINUE") {
                router.navigate(to: .stylistsFocusView)
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

struct OnboardingItem {
    let title: String
    let subtitle: String
    let imageName: String
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
