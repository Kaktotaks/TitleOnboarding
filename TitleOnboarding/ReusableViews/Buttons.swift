//
//  Buttons.swift
//  TitleOnboarding
//
//  Created by Леонід Шевченко on 23.02.2025.
//

import SwiftUI

enum ButtonStyles {
    case white, black
}

struct MainButton: View {
    let style: ButtonStyles
    let text: String
    let action: () -> Void
    @State var isPressed: Bool = false
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(text)
                .foregroundColor(style == .black ? .white : .black)
                .customTextStyle(textStyle: .mainButton)
                .frame(maxWidth: .infinity, minHeight: 52)
                .background(style == .black ? .black : .white)
                .animation(.easeInOut, value: isPressed)
        }
    }
}

struct CheckmarkButton: View {
    @Binding var isPicked: Bool
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: isPicked ? "checkmark.square.fill" : "")
                .resizable()
                .frame(width: 20, height: 20)
                .overlay {
                    Rectangle()
                        .stroke(.gray)
                        .frame(width: 20, height: 20)
                }
        }
        .onTapGesture {
            withAnimation {
                isPicked.toggle()
            }
        }
    }
}

struct Checkmark_Button2: PreviewProvider {
    static var previews: some View {
        //        CheckmarkButton(isPicked: .constant(true))
        MainButton(style: .black, text: "Continue") {
            print(">>> tapped")
        }
    }
}
