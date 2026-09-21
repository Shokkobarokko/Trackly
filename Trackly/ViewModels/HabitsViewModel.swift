import Foundation

final class HabitsViewModel {
    
    private(set) var habits: [Habit] = []
    
    var onHabitsChanged: (() -> Void)?
    
    
}

extension HabitsViewModel {
    func addHabit(text: String) {
        let trimmedText = text.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmedText == ""{
            return
        }
        habits.append(Habit(text: trimmedText))
        onHabitsChanged?()
        print("original:", text)
        print("count:", text.count)
        print("unicode:", text.unicodeScalars.map { $0.value })
    }
    
    func deleteHabit(at index: Int) {
        habits.remove(at: index)
        onHabitsChanged?()
        
    }
}
