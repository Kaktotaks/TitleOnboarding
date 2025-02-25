//
//  ColorsCollectionView.swift
//  TitleOnboarding
//
//  Created by Леонід Шевченко on 23.02.2025.
//


import SwiftUI

struct ColorsCollectionView: View {
    let title: String = "Choose favourite colors"
    
    let models: [ColorStyleModel] = [
        ColorStyleModel(imageName: "LightBlueColor", title: "Light blue"),
        ColorStyleModel(imageName: "Blue", title: "Blue"),
        ColorStyleModel(imageName: "Indigo", title: "Indigo"),
        ColorStyleModel(imageName: "Turquoise", title: "Turquoise"),
        ColorStyleModel(imageName: "Mint", title: "Mint"),
        ColorStyleModel(imageName: "Olive", title: "Olive"),
        ColorStyleModel(imageName: "Green", title: "Green"),
        ColorStyleModel(imageName: "Emerald", title: "Emerald"),
        ColorStyleModel(imageName: "Yellow", title: "Yellow"),
        ColorStyleModel(imageName: "Beige", title: "Beige"),
        ColorStyleModel(imageName: "Orange", title: "Orange"),
        ColorStyleModel(imageName: "Brown", title: "Brown"),
        ColorStyleModel(imageName: "Pink", title: "Pink"),
        ColorStyleModel(imageName: "Magenta", title: "Magenta"),
        ColorStyleModel(imageName: "Red", title: "Red"),
        ColorStyleModel(imageName: "Lavender", title: "Lavender"),
        ColorStyleModel(imageName: "White", title: "White"),
        ColorStyleModel(imageName: "Gray", title: "Gray")
    ]
    
    @State private var pickedItems: Set<ColorStyleModel> = []
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(title)
                .customTextStyle(textStyle: .headtitleOnboarding)
                .padding(16)
            
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                    ForEach(models) { model in
                        CollectionCell(
                            type: .color,
                            model: model,
                            isPicked: Binding(
                                get: { pickedItems.contains(model) },
                                set: { isPicked in
                                    if isPicked {
                                        pickedItems.insert(model)
                                    } else {
                                        pickedItems.remove(model)
                                    }
                                }
                            )
                        )
                        .frame(width: (UIScreen.main.bounds.width / 3) - 24, height: (UIScreen.main.bounds.width / 3) - 24)
                    }
                }
                .padding(.horizontal, 10)
            }
            .bottomFade()
            .scrollIndicators(.hidden)
            
            MainButton(style: .black , text: "Continue") {
                pickedItems.map { item in
                    print(item)
                }
            }
            .padding([.leading, .trailing, .bottom])
        }
        .frame(alignment: .leading)
    }
}

struct Colors_CollectionView: PreviewProvider {
    static var previews: some View {
        ColorsCollectionView()
    }
}
