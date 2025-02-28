//
//  Untitled.swift
//  TitleOnboarding
//
//  Created by Леонід Шевченко on 28.02.2025.
//

import SwiftUI

struct LoadingViewModifier: ViewModifier {
    var isLoading: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            if isLoading {
                ProgressView()
                    .transition(.opacity.combined(with: .scale(scale: 0.8)))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea()
                    .zIndex(1)
            }
            
            content
                .opacity(isLoading ? 0 : 1)
                .animation(.easeInOut(duration: 0.3), value: isLoading)
        }
    }
}

extension View {
    func loadingOverlay(isLoading: Bool) -> some View {
        self.modifier(LoadingViewModifier(isLoading: isLoading))
    }
}
