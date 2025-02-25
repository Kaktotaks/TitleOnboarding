//
//  PlanModel.swift
//  TitleOnboarding
//
//  Created by Леонід Шевченко on 24.02.2025.
//

import Foundation

struct PlanModel: Hashable, Identifiable {
    let period: String
    let price: String
    let description: String
    var isHot: Bool = false
    let id: UUID = UUID()
}
