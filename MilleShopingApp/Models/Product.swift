struct Product: Identifiable, Codable {
    let id: String
    let name: String
    let price: Double

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case price
    }
}
