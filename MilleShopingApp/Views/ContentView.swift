import Foundation
import SwiftUI

struct ContentView: View {
    @StateObject var productViewModel = ProductViewModel()
    @StateObject var basketViewModel = BasketViewModel()

    let currencies = ["USD", "EUR", "GBP"]

    var body: some View {
        NavigationView {
            VStack {

                List(productViewModel.products) { product in
                    let quantity = basketViewModel.quantityForProduct(product)

                    HStack {
                        Text(product.name)
                        Spacer()
                        Text(String(format: "$%.2f", product.price))
                        Spacer()

                        Button(action: {
                            basketViewModel.removeProduct(product)
                        }) {
                            Image(systemName: "minus.circle.fill")
                        }
                        .disabled(quantity == 0)
                        .foregroundColor(quantity == 0 ? .gray : .red)

                        Text("\(quantity)")
                            .frame(width: 30, alignment: .center)

                        // Add Button
                        Button(action: {
                            basketViewModel.addProduct(product)
                        }) {
                            Image(systemName: "plus.circle.fill")
                        }
                    }
                }

                Picker("Currency", selection: $basketViewModel.selectedCurrency) {
                    ForEach(currencies, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()

                Text("Total: \(String(format: "%.2f", basketViewModel.totalCostInSelectedCurrency)) \(basketViewModel.selectedCurrency)")
                    .font(.headline)
                    .padding()

                Spacer()

                Button(action: {
                    print("Checkout tapped, total: \(basketViewModel.totalCostInSelectedCurrency) \(basketViewModel.selectedCurrency)")
                }) {
                    Text("Checkout")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()

                Spacer()
            }
            .navigationTitle("Products")
        }
    }
}
