import Foundation

enum HabitsStorage {
    private static let key = "habits"
    
    static func save(_ habits: [Habit]) {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(habits)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print(error)
        }
        
        

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
            print(error)
            return[]
        }
    }
}
