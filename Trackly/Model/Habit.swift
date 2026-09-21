import Foundation

struct Habit: Codable {
    let id = UUID()
    var text: String
    let createdDate = Date()
}

