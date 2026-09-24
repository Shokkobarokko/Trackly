import Foundation

struct HabitCompletion: Codable, Hashable {
    let habitID: UUID
    let date: Date
    
    init(
        habitID: UUID,
        date: Date = Date()
    ) {
        self.habitID = habitID
        self.date = Calendar.current.startOfDay(for: date)
    }
}
