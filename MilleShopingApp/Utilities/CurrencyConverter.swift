import Foundation

struct CurrencyRates: Codable {
    let success: Bool
    let timestamp: Int
    let source: String
    let quotes: [String: Double]
}

class CurrencyConverter {
    private var exchangeRates: [String: Double] = [:]

    init() {
        loadExchangeRates()
    }

    private func loadExchangeRates() {
        if let url = Bundle.main.url(forResource: "conversion_rates", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let currencyRates = try decoder.decode(CurrencyRates.self, from: data)

                self.exchangeRates = currencyRates.quotes.reduce(into: [:]) { result, pair in
                    let key = pair.key.replacingOccurrences(of: "USD", with: "")
                    result[key] = pair.value
                }

            } catch {
                print("Failed to load exchange rates: \(error)")
            }
        }
    }

    func convert(amount: Double, from baseCurrency: String, to targetCurrency: String) -> Double {
        guard baseCurrency == "USD" else {
            print("Currently only conversion from USD is supported")
            return amount
        }

        guard let targetRate = exchangeRates[targetCurrency] else {
            return amount
        }

        return amount * targetRate
    }
}
