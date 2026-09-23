import Foundation

final class HabitsViewModel {
    
    private(set) var habits: [Habit] = []
    
    var onHabitsChanged: (() -> Void)?
    
    init() {
        habits = HabitsStorage.load()
    }
}

extension HabitsViewModel {
    func addHabit(text: String) {
        let trimmedText = text.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmedText == "" {
            return
        }
        habits.append(Habit(text: trimmedText))
        HabitsStorage.save(habits)
        onHabitsChanged?()
    }
    
    func deleteHabit(at index: Int) {
        habits.remove(at: index)
        HabitsStorage.save(habits)
        onHabitsChanged?()
        
    }
}
