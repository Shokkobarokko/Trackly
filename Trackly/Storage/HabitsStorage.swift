import Foundation

enum HabitsStorage {
    private static let key = "habits"
    
    static func save(_ habits: [Habit]) {
        let encoder = JSONEncoder()
        let data = try? encoder.encode(habits)
        UserDefaults.standard.set(data, forKey: key)
        print("Encoded date:", data as Any)
    }
    
    static func load() -> [Habit] {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            return []
        }
        let decoder = JSONDecoder()
        do {
            let habits = try decoder.decode([Habit].self, from: data)
            return habits
        } catch {
            return []
        }
    }
}
