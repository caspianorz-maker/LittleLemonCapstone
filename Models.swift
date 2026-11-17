import Foundation

struct UserProfile: Codable, Equatable {
    var firstName: String
    var lastName: String
    var email: String
    var phone: String

    static let empty = UserProfile(firstName: "", lastName: "", email: "", phone: "")
}

struct MenuItem: Identifiable {
    let id = UUID()
    let name: String
    let description: String
    let price: String
    let category: String
    let symbol: String

    static let samples: [MenuItem] = [
        MenuItem(name: "Greek Salad", description: "Crisp lettuce, peppers, olives and feta", price: "$12.99", category: "Starters", symbol: "leaf.fill"),
        MenuItem(name: "Bruschetta", description: "Grilled bread with tomatoes and herbs", price: "$8.99", category: "Starters", symbol: "takeoutbag.and.cup.and.straw.fill"),
        MenuItem(name: "Grilled Fish", description: "Fresh fish with lemon and seasonal greens", price: "$18.99", category: "Mains", symbol: "fish.fill"),
        MenuItem(name: "Pasta Primavera", description: "Pasta tossed with garden vegetables", price: "$16.50", category: "Mains", symbol: "fork.knife"),
        MenuItem(name: "Lemon Cake", description: "Soft citrus cake with a bright lemon glaze", price: "$7.50", category: "Desserts", symbol: "birthday.cake.fill"),
        MenuItem(name: "Fresh Lemonade", description: "House-made lemonade with fresh mint", price: "$4.50", category: "Drinks", symbol: "cup.and.saucer.fill")
    ]
}
