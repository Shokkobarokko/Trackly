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
        guard index >= 0 && index < habits.count else {
            return
        }
        let habit = habits[index]
        completions = completions.filter { completion in
            completion.habitID != habit.id
        }
        habits.remove(at: index)
        HabitsStorage.save(habits)
        HabitCompletionStorage.save(completions)
        onHabitsChanged?()
        }
        
    
    
    func updateHabit(at index: Int, text: String) {
        guard index >= 0 && index < habits.count else {
            return
        }
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
        guard habits.contains(where: { $0.id == habit }) else {
            return
        }
        if isCompleted(habit: habit, date: date) {
            let completion = HabitCompletion(habitID: habit, date: date)
            completions.remove(completion)
        } else {
            let completion = HabitCompletion(habitID: habit, date: date)
            completions.insert(completion)
        }
        HabitCompletionStorage.save(completions)
        onHabitsChanged?()
    }
    
}
