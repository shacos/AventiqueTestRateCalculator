//
//  ContentView.swift
//  TestAventique
//
//  Created by Mehdi on 2/12/2025.
//

import SwiftUI

struct ContentView: View {

    let currencies: [Currency] = [.euro, .dollar, .yenes]

    @State private var price: Double = 0
    @State private var toPrice: Double = 0
    @State private var currencyRate = CurrencyRate()

    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()

            VStack(spacing: 20) {
                HStack(spacing: 0) {
                    TextField("", value: $price, format: .number)
                        .priceText()
                        .onChange(of: price) {
                            toPrice = price * currencyRate.rate
                        }
                    
                    Rectangle()
                        .horizontalLign()
                    
                    Picker("Currency", selection: $currencyRate.fromCurrency) {
                        ForEach(currencies, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                    .onChange(of: currencyRate.fromCurrency) {
                        toPrice = price * currencyRate.rate
                    }
                    .pickerStyling()
                }
                .box()
                
                HStack(spacing: 0) {
                    TextField("", value: $toPrice, format: .number)
                        .priceText()
                        .keyboardType(.numberPad)
                    
                    Rectangle()
                        .horizontalLign()
                    
                    Picker("Currency", selection: $currencyRate.toCurrency) {
                        ForEach(currencies, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                    .onChange(of: currencyRate.toCurrency) {
                        toPrice = price * currencyRate.rate
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
