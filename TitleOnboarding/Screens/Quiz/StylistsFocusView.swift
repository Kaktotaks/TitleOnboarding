//
//  StylistsFocusView.swift
//  TitleOnboarding
//
//  Created by Леонід Шевченко on 23.02.2025.
//

import SwiftUI

struct StylistsFocusView: View {
    let title: String = "What’d you like our stylists to focus on?"
    let subTitle: String = "We offer services via live-chat mode."
    
    let models: [FocusModel] = [
        FocusModel(mainTitle: "Reinvent wardrobe", subTitle: "to discover fresh outfit ideas"),
        FocusModel(mainTitle: "Define color palette", subTitle: "to enhance my natural features"),
        FocusModel(mainTitle: "Create a seasonal capsule", subTitle: "to curate effortless and elegant looks"),
        FocusModel(mainTitle: "Define my style", subTitle: "to discover my signature look"),
        FocusModel(mainTitle: "Create an outfit for an event", subTitle: "to own a spotlight wherever you go")
    ]
    
    @State private var pickedItems: Set<FocusModel> = []
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .customTextStyle(textStyle: .headtitleQuize)
                Text(subTitle)
                    .customTextStyle(textStyle: .subheadline)
            }
            .padding(18)
            
            List {
                ForEach(models) { model in
                    TableCell(
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
                    .listRowSeparator(.hidden)
                }
            }
            .bottomFade()
            .scrollIndicators(.hidden)
            .listStyle(.plain)
            
            MainButton(style: .black , text: "Continue") {
                pickedItems.map { item in
                    print(item)
                }
            }
            .padding([.leading, .trailing, .bottom], 20)
        }
        .frame(alignment: .leading)
    }
}

struct Stylists_Focus_View: PreviewProvider {
    static var previews: some View {
        StylistsFocusView()
    }
}
