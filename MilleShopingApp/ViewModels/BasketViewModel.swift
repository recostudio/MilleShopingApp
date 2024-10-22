import Foundation

class BasketViewModel: ObservableObject {
    @Published var basketItems: [BasketItem] = []
    @Published var selectedCurrency: String = "USD"

    private let currencyConverter = CurrencyConverter()

    var totalCostInUSD: Double {
        return basketItems.reduce(0) { $0 + $1.totalPrice }
    }

    var totalCostInSelectedCurrency: Double {
        return currencyConverter.convert(amount: totalCostInUSD, from: "USD", to: selectedCurrency)
    }

    func quantityForProduct(_ product: Product) -> Int {
        return basketItems.first(where: { $0.product.id == product.id })?.quantity ?? 0
    }

    func addProduct(_ product: Product) {
        if let index = basketItems.firstIndex(where: { $0.product.id == product.id }) {
            basketItems[index].quantity += 1
        } else {
            let newItem = BasketItem(product: product, quantity: 1)
            basketItems.append(newItem)
        }
    }

    func removeProduct(_ product: Product) {
        if let index = basketItems.firstIndex(where: { $0.product.id == product.id }) {
            basketItems[index].quantity -= 1
            if basketItems[index].quantity == 0 {
                basketItems.remove(at: index)
            }
        }
    }
}
