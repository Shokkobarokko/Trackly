import UIKit

final class HabitsViewController: UIViewController {
    
    //MARK: - Properties
    
    
    private let viewModel = HabitsViewModel()
    private let tableView = UITableView()
    
    //MARK: - Lifecycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavigationBar()
    }
    
    
}

//MARK: - Setup


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
        alert.addTextField { textField in
            textField.placeholder = "Название привычки"
            
        }
        
        let addAction = UIAlertAction(
            title: "Добавить",
            style: .default,
            handler: { action in
                if let text = alert.textFields?.first?.text {
                    self.viewModel.addHabit(text: text)
                    self.tableView.reloadData()
                }
            }
        )
        alert.addAction(addAction)
        present(alert, animated: true, completion: nil)
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

