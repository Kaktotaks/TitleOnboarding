//
//  BottomFadeModifier.swift
//  TitleOnboarding
//
//  Created by Леонід Шевченко on 23.02.2025.
//

import SwiftUI

struct BottomFadeModifier: ViewModifier {
    var height: CGFloat
    var startColor: Color
    
    func body(content: Content) -> some View {
        ZStack {
            content
            VStack {
                Spacer()
                LinearGradient(
                    gradient: Gradient(colors: [
                        startColor,
                        Color(.clear)
                    ]),
                    startPoint: .bottom,
                    endPoint: .top
                )
                .frame(height: height)
            }
            .allowsHitTesting(false)
        }
    }
}

extension View {
    func bottomFade(height: CGFloat = 40, startColor: Color = .white) -> some View {
        self.modifier(BottomFadeModifier(height: height, startColor: startColor))
    }
}
