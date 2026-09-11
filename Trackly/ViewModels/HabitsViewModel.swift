import Foundation

final class HabitsViewModel {
    
    var habits: [Habit] = []
    
    var onHabitsChanged: (() -> Void)?
    
    
}

extension HabitsViewModel {
    func addHabit(text: String) {
        habits.append(Habit(text: text))
        onHabitsChanged?()
    }
}
