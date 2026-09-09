import Foundation

final class HabitsViewModel {
    
    private(set) var habits: [Habit] = []
    
    
}

extension HabitsViewModel {
    func addHabit(text habitText: String) {
        let habit = Habit(text: habitText)
        habits.append(habit)
    }
}
