//
//  ContentView.swift
//  TestAventique
//
//  Created by Mehdi on 2/12/2025.
//

import SwiftUI

struct ContentView: View {

    let currencies: [Currency] = [.euro, .dollar, .yenes]
    enum LastFieldEdited: String { case price = "price", toPrice = "toPrice" }

    @State private var price: Double = 0
    @State private var toPrice: Double = 0
    @FocusState private var fieldEdited: LastFieldEdited?
    @State private var currencyRate = CurrencyRate()

    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()

            VStack(spacing: 20) {
                HStack(spacing: 0) {
                    TextField("", value: $price, format: .number)
                        .priceText()
                        .keyboardType(.decimalPad)
                        .focused($fieldEdited, equals: .price)
                        .onChange(of: price) {
                            print("first textfield fieldEdited: \(fieldEdited?.rawValue ?? "null")")
                            guard fieldEdited == .price else { return }
                            toPrice = price * currencyRate.rateValue
                        }

                    HStack {
                        Spacer()
                        Rectangle()
                            .horizontalLign()
                        Spacer()
                    }

                    Picker("Currency", selection: $currencyRate.fromCurrency) {
                        ForEach(currencies, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                    .onChange(of: currencyRate.fromCurrency) {
                        updateValuesAfterCurrencyChange(.price)
                    }
                    .pickerStyling()
                }
                .box()
                
                HStack(spacing: 0) {
                    TextField("", value: $toPrice, format: .number)
                        .priceText()
                        .keyboardType(.decimalPad)
                        .focused($fieldEdited, equals: .toPrice)
                        .onChange(of: toPrice) {
                            print("second textfield fieldEdited: \(fieldEdited?.rawValue ?? "null")")
                            guard fieldEdited == .toPrice else { return }
                            price = toPrice * currencyRate.counterRateValue
                        }
                    
                    HStack {
                        Spacer()
                        Rectangle()
                            .horizontalLign()
                        Spacer()
                    }
                    
                    Picker("Currency", selection: $currencyRate.toCurrency) {
                        ForEach(currencies, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                    .onChange(of: currencyRate.toCurrency) {
                        updateValuesAfterCurrencyChange(.toPrice)
                    }
                    .pickerStyling()
                }
                .box()
            }
        }
    }

    private func updateValuesAfterCurrencyChange(_ focused: LastFieldEdited) {
        fieldEdited = nil
        
        DispatchQueue.main.async {
            switch focused {
            case .price:
                toPrice = price * currencyRate.rateValue
            case .toPrice:
                price = toPrice * currencyRate.counterRateValue
            }
        }
    }
}

#Preview {
    ContentView()
}
