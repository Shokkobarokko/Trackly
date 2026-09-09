import UIKit

final class HabitsViewController: UIViewController {
    
    private let viewModel = HabitsViewModel()
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        viewModel.addHabit(text: "Кушать")
        viewModel.addHabit(text: "Гулять")
        setupNavigationBar()
    }
    
    
}

private extension HabitsViewController {
    func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "HabitCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    @objc func addButtonTapped() {
        let alert = UIAlertController(title: "Новая привычка", message: nil, preferredStyle: .alert)
    }
}

//MARK: UITableViewDataSource
extension HabitsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.habits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let habit = viewModel.habits[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "HabitCell", for: indexPath)
        cell.textLabel?.text = habit.text
        return cell
    }
}

//MARK: UITableViewDelegate
extension HabitsViewController: UITableViewDelegate {
    
}

//MARK: NavigationBar
extension HabitsViewController {
    func setupNavigationBar() {
        let addButton = UIBarButtonItem(
            title: "Добавить",
            style: .plain,
            target: self,
            action:#selector(addButtonTapped)
        )
        navigationItem.rightBarButtonItem = addButton
    }
}

