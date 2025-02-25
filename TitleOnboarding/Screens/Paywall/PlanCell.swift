//
//  PlanCell.swift
//  TitleOnboarding
//
//  Created by Леонід Шевченко on 24.02.2025.
//

import SwiftUI

struct PlanCell: View {
    var isSelected: Bool
    let period: String
    let price: String
    let description: String
    let isHot: Bool
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                VStack() {
                    VStack {
                        Text(period)
                            .customTextStyle(textStyle: .paycellTitle(bold: !isHot))
                        
                        Text(price)
                            .customTextStyle(textStyle: .paycellTitle(bold: isHot))
                    }
                    .padding(.top, isHot ? 20 : 0)
                    
                    Spacer()
                    
                    Text(description)
                        .customTextStyle(textStyle: .secondary(size: 12))
                }
                .padding(isHot ? 8 : 14)
                
                if isHot {
                    Text("Hot Deal 🔥")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.white)
                        .frame(width: geometry.size.width + 2)
                        .padding(.vertical, 10)
                        .background(Color.black)
                        .offset(y: -15)
                }
            }
            .frame(maxWidth: geometry.size.width)
            .background(isSelected ? Color("PickedPayCellColor") : Color.white)
            .background(
                Rectangle()
                    .stroke(isSelected ? Color.black : Color.gray, lineWidth: 1)
            )
        }
    }
}
