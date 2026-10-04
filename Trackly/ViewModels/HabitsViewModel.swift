import Foundation

final class HabitsViewModel {
    
    private(set) var habits: [Habit] = []
    private(set) var completions: Set<HabitCompletion> = []
    
    var onHabitsChanged: (() -> Void)?
    
    init() {
        habits = HabitsStorage.load()
        completions = HabitCompletionStorage.load()
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
        print("Before save:", habits.map { $0.text })
        HabitsStorage.save(habits)
        onHabitsChanged?()
    }
    
    func updateHabit(at index: Int, text: String) {
        let trimmedText = text.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmedText == "" {
            return
        }
        habits[index].text = trimmedText
        HabitsStorage.save(habits)
        onHabitsChanged?()
    }
    
    func isCompleted(habit: UUID, date: Date) -> Bool {
        return completions.contains { completion in
            completion.habitID == habit && completion.date == Calendar.current.startOfDay(for: date)
        }
    }
    
    func completeHabit(habit: UUID, date: Date) {
        let completion = HabitCompletion(habitID: habit, date: date)
        completions.insert(completion)
        HabitCompletionStorage.save(completions)
    }
    
}
