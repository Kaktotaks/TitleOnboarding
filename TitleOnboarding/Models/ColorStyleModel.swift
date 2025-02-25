//
//  ColorStyleModel.swift
//  TitleOnboarding
//
//  Created by Леонід Шевченко on 23.02.2025.
//

import Foundation

struct ColorStyleModel: Hashable, Identifiable {
    let imageName: String
    let title: String
    let id: UUID = UUID()
}

