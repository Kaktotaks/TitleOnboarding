//
//  StyleCollectionView.swift
//  TitleOnboarding
//
//  Created by Леонід Шевченко on 23.02.2025.
//

import SwiftUI

struct StyleCollectionView: View {
    let title: String = "Which style best represents you?"
    
    let models: [ColorStyleModel] = [
        ColorStyleModel(imageName: "casualModel", title: "CASUAL"),
        ColorStyleModel(imageName: "bohoModel", title: "BOHO"),
        ColorStyleModel(imageName: "classyModel", title: "CLASSY"),
        ColorStyleModel(imageName: "ladylikeModel", title: "LADYLIKE"),
        ColorStyleModel(imageName: "urbanModel", title: "URBAN"),
        ColorStyleModel(imageName: "sportyModel", title: "SPORTY"),
        ColorStyleModel(imageName: "creativeModel", title: "CREATIVE"),
        ColorStyleModel(imageName: "funkyRockModel", title: "FUNKY ROCK"),
        ColorStyleModel(imageName: "preppyModel", title: "PREPPY"),
        ColorStyleModel(imageName: "sexyModel", title: "SEXY"),
        ColorStyleModel(imageName: "unspecifiedModel", title: "don’t know")
    ]
    
    @State private var pickedItems: Set<ColorStyleModel> = []
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(title)
                .customTextStyle(textStyle: .headtitleOnboarding)
                .padding(16)
            
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                    ForEach(models) { model in
                        CollectionCell(
                            type: .image,
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
                        .frame(width: (UIScreen.main.bounds.width / 2) - 24, height: (UIScreen.main.bounds.width / 2) - 24)
                    }
                }
                .padding(.horizontal, 14)
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

struct Style_CollectionView: PreviewProvider {
    static var previews: some View {
        StyleCollectionView()
    }
}
