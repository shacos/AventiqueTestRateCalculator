//
//  ContentView.swift
//  TestAventique
//
//  Created by Mehdi on 2/12/2025.
//

import SwiftUI

struct ContentView: View {

    let currencies: [Currency] = [.euro, .dollar, .yenes]
    enum PriceDirection { case price, toPrice }

    @State private var price: Double = 0
    @State private var toPrice: Double = 0
    @FocusState private var fieldEdited: PriceDirection?
    @FocusState private var pickerEdited: PriceDirection?
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
                    .focused($pickerEdited, equals: .price)
                    .onChange(of: currencyRate.fromCurrency) {
                        toPrice = price * currencyRate.rateValue
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
                    .focused($pickerEdited, equals: .toPrice)
                    .onChange(of: currencyRate.toCurrency) {
                        price = toPrice * currencyRate.counterRateValue
                    }
                    .pickerStyling()
                }
                .box()
            }
        }
    }
}

#Preview {
    ContentView()
}
