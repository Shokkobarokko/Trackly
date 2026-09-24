import Foundation

struct Habit: Codable {
    let id: UUID
    var text: String
    let createdDate: Date
    
    init(
        id: UUID = UUID(),
        text: String,
        createdDate: Date = Date()
    ) {
        self.id = id
        self.text = text
        self.createdDate = createdDate
    }
}

