import Foundation

class ProductViewModel: ObservableObject {
    @Published var products: [Product] = []

    init() {
        loadProducts()
    }

    func loadProducts() {
        if let url = Bundle.main.url(forResource: "products", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                products = try decoder.decode([Product].self, from: data)
            } catch {
                print("Error loading products: \(error)")
            }
        }
    }
}
