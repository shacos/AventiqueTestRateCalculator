//
//  CurrentRate.swift
//  TestAventique
//
//  Created by Mehdi on 2/12/2025.
//

import Foundation

enum Currency: String {
    case euro = "EUR"
    case dollar = "USD"
    case yenes = "JPY"
}

@Observable
class CurrencyRate {
    var fromCurrency: Currency = .euro {
        didSet {
            setRate()
        }
    }
    var toCurrency: Currency = .dollar {
        didSet {
            setRate()
        }
    }
    var rateValue = ratings[[.euro: .dollar]] ?? 1
    var counterRateValue = ratings[[.dollar: .euro]] ?? 1
    static let ratings: [[Currency: Currency]: Double] = [
        [.euro: .dollar]: 1.5,
        [.euro: .yenes]: 2.5,
        [.dollar: .euro]: 0.5,
        [.dollar: .yenes]: 2,
        [.yenes: .euro]: 0.25,
        [.yenes: .dollar]: 0.2,
    ]
    
    func setRate() {
        if fromCurrency == toCurrency {
            rateValue = 1
            counterRateValue = 1
            return
        }
        rateValue = CurrencyRate.ratings[[fromCurrency: toCurrency]] ?? 1
        counterRateValue = CurrencyRate.ratings[[toCurrency: fromCurrency]] ?? 1
    }
}
