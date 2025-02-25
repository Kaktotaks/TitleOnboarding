//
//  TextStyleModifier.swift
//  TitleOnboarding
//
//  Created by Леонід Шевченко on 23.02.2025.
//

import SwiftUI

enum TextStyle {
    case headtitleOnboarding
    case headtitleQuize
    case subheadline
    case secondary(size: CGFloat)
    case policy
    case collectionItemTitle
    case welcomeTitle
    case mainButton
    case subheadtitleQuize
    case paycellTitle(bold: Bool)
    
    var font: Font {
        switch self {
        case .welcomeTitle:
            return Font.system(size: 32, weight: .medium, design: .default)
        case .headtitleOnboarding, .headtitleQuize:
            return Font.system(size: 28, weight: .semibold, design: .default)
        case .paycellTitle(let bold):
            return Font.system(size: 14, weight: bold ? .bold : .regular, design: .default)
        case .subheadline, .subheadtitleQuize:
            return Font.system(size: 20, weight: .regular, design: .default)
        case .secondary(let size):
            return Font.system(size: size, weight: .light, design: .default)
        case .policy:
            return Font.system(size: 13, weight: .light, design: .default)
        case .collectionItemTitle:
            return Font.system(size: 20, weight: .medium, design: .default)
        case .mainButton:
            return Font.system(size: 16, weight: .medium, design: .default)
        }
    }
    
    var color: Color {
        switch self {
        case .welcomeTitle:
            .white
        case .policy:
            .gray
        default:
            .black
        }
    }
    
    var alignment: TextAlignment {
        switch self {
        case .headtitleQuize, .welcomeTitle, .subheadtitleQuize:
            .leading
        default:
            .center
        }
    }
}

struct CustomTextStyle: ViewModifier {
    var font: Font = .subheadline
    var color: Color = .gray
    var alignment: TextAlignment = .center
    
    func body(content: Content) -> some View {
        content
            .font(font)
            .foregroundColor(color)
            .multilineTextAlignment(alignment)
    }
}

extension View {
    func customTextStyle(textStyle: TextStyle) -> some View {
        self.modifier(CustomTextStyle(font: textStyle.font, color: textStyle.color, alignment: textStyle.alignment))
    }
}
