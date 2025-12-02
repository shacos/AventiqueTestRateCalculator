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
    var rate: Double = 1.1
    
    func setRate() {
        switch fromCurrency {
        case .euro:
            if toCurrency == .euro {
                rate = 1.0
            } else if toCurrency == .dollar {
                rate = 1.1
            } else {
                rate = 160
            }
        case .dollar:
            if toCurrency == .dollar {
                rate = 1.0
            } else if toCurrency == .euro {
                rate = 0.9
            } else {
                rate = 130
            }
        case .yenes:
            if toCurrency == .yenes {
                rate = 1.0
            } else if toCurrency == .euro {
                rate = 0.94
            } else {
                rate = 0.97
            }
        }
    }
}
