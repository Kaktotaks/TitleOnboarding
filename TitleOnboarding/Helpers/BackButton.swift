//
//  BackButton.swift
//  TitleOnboarding
//
//  Created by Леонід Шевченко on 25.02.2025.
//
import SwiftUI

struct NavigationBarButton: View {
    let imageName: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Image(imageName)
                    .aspectRatio(contentMode: .fit)
            }
            .padding(8)
        }
    }
}

struct BackButton: ViewModifier {
    let image: String
    let action: () -> Void
    
    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: NavigationBarButton(imageName: image, action: action))
    }
}

extension View {
    func setupBackButton(imageName: String = "backButton", action: @escaping () -> Void) -> some View {
        self.modifier(BackButton(image: imageName, action: action))
    }
}
