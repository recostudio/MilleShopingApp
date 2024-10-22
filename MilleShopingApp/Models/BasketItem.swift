import Foundation

struct BasketItem: Identifiable {
    let id = UUID()
    let product: Product
    var quantity: Int

    var totalPrice: Double {
        return product.price * Double(quantity)
    }
}

