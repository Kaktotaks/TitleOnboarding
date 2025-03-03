//
//  Cells.swift
//  TitleOnboarding
//
//  Created by Леонід Шевченко on 23.02.2025.
//

import SwiftUI

enum CollectionCellType {
    case image, color
}

struct CollectionCell: View {
    let type: CollectionCellType
    let model: ColorStyleModel
    @Binding var isPicked: Bool
    
    var body: some View {
        GeometryReader { reader in
            ZStack {
                VStack {
                    HStack {
                        Spacer()
                        
                        CheckmarkButton(isPicked: $isPicked)
                            .padding([.top, .trailing], 8)
                            .opacity(type == .color && !isPicked ? 0 : 1)
                    }
                    
                    Spacer()
                }
                
                VStack {
                    Image(model.imageName)
                        .resizable()
                        .scaledToFit()
                        .padding(type == .color ? 20 : 0)
                    
                    Text(model.title)
                        .font(isPicked ? .subheadline.weight(.bold) : .subheadline.weight(.light))
                        .foregroundColor(.black)
                        .padding(.bottom, 8)
                }
            }
            .frame(maxWidth: reader.size.width, maxHeight: reader.size.width)
            .background(Color.white)
            .overlay(
                Rectangle()
                    .stroke(isPicked ? Color.black : Color.gray, lineWidth: isPicked ? 1.5 : 1)
            )
            .onTapGesture {
                withAnimation(.easeInOut) {
                    isPicked.toggle()
                }
            }
        }
    }
}

struct TableCell: View {    
    let model: FocusModel
    @Binding var isPicked: Bool
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(model.title)
                    .customTextStyle(textStyle: .collectionItemTitle)
                Text(model.subTitle)
                    .customTextStyle(textStyle: .secondary(size: 14))
            }
            
            Spacer()
            
            CheckmarkButton(isPicked: $isPicked)
        }
        .padding()
        .background(Color.white)
        .overlay(
            Rectangle()
                .stroke(isPicked ? .black : .gray, lineWidth: isPicked ? 1.5 : 1)
        )
        .onTapGesture {
            withAnimation(.easeInOut) {
                isPicked.toggle()
            }
        }
    }
}

struct Collection_Cell: PreviewProvider {
    static var previews: some View {
        CollectionCell(type: .color, model: .init(imageName: "LightBlueColor", title: "Test title"), isPicked: .constant(true))
    }
}
