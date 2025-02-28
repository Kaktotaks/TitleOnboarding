//
//  ApiClient.swift
//  TitleOnboarding
//
//  Created by Леонід Шевченко on 28.02.2025.
//

import ComposableArchitecture
import SwiftUI

struct APIClient {
    var fetchFocusModels: () async -> [FocusModel]
    var fetchStylesModels: () async -> [ColorStyleModel]
    var fetchColorsModels: () async -> [ColorStyleModel]
    
}

extension DependencyValues {
    var apiClient: APIClient {
        get { self[APIClient.self] }
        set { self[APIClient.self] = newValue }
    }
}

// Mock API Client
extension APIClient: DependencyKey {
    static let liveValue = APIClient(
        fetchFocusModels: {
            try? await Task.sleep(nanoseconds: 2_000_000_000)
            return [
                FocusModel(mainTitle: "Reinvent wardrobe", subTitle: "to discover fresh outfit ideas"),
                FocusModel(mainTitle: "Define color palette", subTitle: "to enhance my natural features"),
                FocusModel(mainTitle: "Create a seasonal capsule", subTitle: "to curate effortless and elegant looks"),
                FocusModel(mainTitle: "Define my style", subTitle: "to discover my signature look"),
                FocusModel(mainTitle: "Create an outfit for an event", subTitle: "to own a spotlight wherever you go")
            ]
        },
        fetchStylesModels: {
            try? await Task.sleep(nanoseconds: 2_000_000_000)
            return [
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
        },
        fetchColorsModels: {
            try? await Task.sleep(nanoseconds: 2_000_000_000)
            return [
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
        }
    )
}
