//
//  ModifierExtensions.swift
//  TestAventique
//
//  Created by Mehdi on 2/12/2025.
//

import SwiftUI

struct BoxDesign: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.vertical, 15)
            .padding(.horizontal, 25)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.white, lineWidth: 2)
            }
    }
}

struct PickerStyling: ViewModifier {
    func body(content: Content) -> some View {
        content
            .labelsHidden()
            .tint(.white)
            .padding(.leading, 100)
    }
}

struct HorizontalLign: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 1, height: 30)
            .foregroundStyle(.gray)
    }
}

struct PriceTextField: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title)
            .foregroundStyle(.white)
            .keyboardType(.numberPad)
    }
}

extension View {
    func box() -> some View {
        self.modifier(BoxDesign())
    }
    
    func pickerStyling() -> some View {
        self.modifier(PickerStyling())
    }
    
    func horizontalLign() -> some View {
        self.modifier(HorizontalLign())
    }
    
    func priceText() -> some View {
        self.modifier(PriceTextField())
    }
}
