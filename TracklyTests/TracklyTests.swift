import Testing
import Foundation
@testable import Trackly
@MainActor
struct TracklyTests {
    
    @Test func testValidHabitIsAdded() async throws {
        let habitsViewModel = HabitsViewModel()
        let currentHabits = habitsViewModel.habits.count
        habitsViewModel.addHabit(text: "Read a book")
        #expect(habitsViewModel.habits.count == currentHabits + 1)
    }
    
    @Test func testEmptyHabitIsNotAdded() async throws {
        let habitsViewModel = HabitsViewModel()
        let currentHabits = habitsViewModel.habits.count
        habitsViewModel.addHabit(text: " ")
        #expect(habitsViewModel.habits.count == currentHabits)
    }
    
    @Test func testHabitCanBeUpdated() async throws {
        let habitsViewModel = HabitsViewModel()
        habitsViewModel.addHabit(text: "Read a book")
        let indexHabit = habitsViewModel.habits.count - 1
        habitsViewModel.updateHabit(at: indexHabit, text: "Read every day")
        #expect(habitsViewModel.habits[indexHabit].text == "Read every day")
    }
    
    @Test func testEmptyHabitUpdateIsIgnored() async throws {
        let habitsViewModel = HabitsViewModel()
        habitsViewModel.addHabit(text: "Read a book")
        let indexHabit = habitsViewModel.habits.count - 1
        habitsViewModel.updateHabit(at: indexHabit, text: "   ")
        #expect(habitsViewModel.habits[indexHabit].text == "Read a book")
    }
    
    @Test func testHabitCanBeDeleted() async throws {
        let habitsViewModel = HabitsViewModel()
        habitsViewModel.addHabit(text: "Read a book")
        let currentHabits = habitsViewModel.habits.count
        let indexHabit = habitsViewModel.habits.count - 1
        habitsViewModel.deleteHabit(at: indexHabit)
        #expect(habitsViewModel.habits.count == currentHabits - 1)
    }
    
    @Test func testDeletingHabitRemovesCompletion() async throws {
        let habitsViewModel = HabitsViewModel()
        habitsViewModel.addHabit(text: "Read a book")
        let indexHabit = habitsViewModel.habits.count - 1
        let habitID = habitsViewModel.habits[indexHabit].id
        habitsViewModel.completeHabit(habit: habitID, date: Date())
        #expect(habitsViewModel.isCompleted(habit: habitID ,date: Date()))
        let currentHabits = habitsViewModel.habits.count
        habitsViewModel.deleteHabit(at: indexHabit)
        #expect(habitsViewModel.habits.count == currentHabits - 1)
        #expect(!habitsViewModel.isCompleted(habit: habitID, date: Date()))
        
    }
    
}
