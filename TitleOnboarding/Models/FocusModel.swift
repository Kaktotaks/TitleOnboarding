//
//  FocusModel.swift
//  TitleOnboarding
//
//  Created by Леонід Шевченко on 23.02.2025.
//

import Foundation

struct FocusModel: Hashable, Identifiable {
    let mainTitle: String
    let subTitle: String
    let id: UUID = UUID()
}
