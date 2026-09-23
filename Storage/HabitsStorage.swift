import Foundation

enum HabitsStorage {
    private static let key = "habits"
    
    static func save(_ habits: [Habit]) {
        let encoder = JSONEncoder()
        let data = try? encoder.encode(habits)
        UserDefaults.standard.set(data, forKey: key)
    }
    
    static func load() -> [Habit] {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            return []
        }
        
        let decoder = JSONDecoder()
        do {
            return try decoder.decode([Habit].self, from: data)
        } catch {
            return []
        }
    }
}
