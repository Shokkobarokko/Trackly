import Foundation

enum HabitCompletionStorage {
    private static let key = "habitCompletions"
    static func save(_ completions: Set<HabitCompletion>) {
        let encoder = JSONEncoder()
        let data = try? encoder.encode(completions)
        UserDefaults.standard.set(data, forKey: key)
    }
    
    static func load() -> Set<HabitCompletion> {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            return Set<HabitCompletion>()
        }
        
        let decoder = JSONDecoder()
        do {
            return try decoder.decode(Set<HabitCompletion>.self, from: data)
        } catch {
            return []
        }
    }
}
