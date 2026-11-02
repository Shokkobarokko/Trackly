import UIKit

final class HabitsViewController: UIViewController {
    
    //MARK: - Properties
    
    
    private let viewModel = HabitsViewModel()
    private let tableView = UITableView()
    private let titleLabel = UILabel()
    
    //MARK: - Lifecycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTitle()
        setupTableView()
        setupNavigationBar()
        viewModel.onHabitsChanged = { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(
            red: 246.0 / 255.0,
            green: 247.0 / 255.0,
            blue: 242.0 / 255.0,
            alpha: 1
        )
    }
    
    private func setupTitle() {
        titleLabel.text = "Trackly"
        titleLabel.textColor = UIColor(
            red: 52.0 / 255.0,
            green: 66.0 / 255.0,
            blue: 54.0 / 255.0,
            alpha: 1
        )
        titleLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24)
        ])
        
    }
    
    
    
    
    
    
}

//MARK: - Setup


private extension HabitsViewController {
    func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        tableView.register(HabitCell.self, forCellReuseIdentifier: "HabitCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.rowHeight = 84
        tableView.backgroundColor = UIColor(
            red: 246.0 / 255.0,
            green: 247.0 / 255.0,
            blue: 242.0 / 255.0,
            alpha: 1
        )
    }
    
    
    
    //MARK: - Actions
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HabitCell", for: indexPath) as? HabitCell else {
            return UITableViewCell()
        }
        
        cell.configure(
            habit: habit,
            isCompleted: viewModel.isCompleted(habit: habit.id, date: Date() )
        )
        
        cell.onCheckmarkTapped = { [weak self, weak cell] in
            guard let self = self, let cell = cell else { return }
            self.viewModel.completeHabit(habit: habit.id, date: Date())
            
            let isCompleted = self.viewModel.isCompleted(
                habit: habit.id,
                date: Date()
            )
            
            cell.animateCheckmark(isCompleted: isCompleted)
        }
        
        
        return cell
    }
    
}

//MARK: UITableViewDelegate


extension HabitsViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                viewModel.deleteHabit(at: indexPath.row)
            }
        }
    
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
//        let habit = viewModel.habits[indexPath.row]
//        let alert = UIAlertController(title:"Обновить", message: nil, preferredStyle: .alert)
//        alert.addTextField { textField in
//            textField.text = habit.text
//        }
//        let saveAction = UIAlertAction(
//            title: "Сохранить",
//            style: .default,
//            handler: { action in
//                if let text = alert.textFields?.first?.text {
//                    self.viewModel.updateHabit(at: indexPath.row, text: text)
//                }
//            }
//        )
//        alert.addAction(saveAction)
//        present(alert,animated: true)
//        tableView.deselectRow(at: indexPath, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(
        _ tableView: UITableView,
        accessoryButtonTappedForRowWith indexPath: IndexPath
    ) {
        let habit = viewModel.habits[indexPath.row]
        let alert = UIAlertController(
            title: "Обновить",
            message: nil,
            preferredStyle: .alert
        )
        alert.addTextField { textField in
            textField.text = habit.text
        }
        let saveAction = UIAlertAction(
            title: "Сохранить",
            style: .default,
            handler: { action in
                if let text = alert.textFields?.first?.text {
                    self.viewModel.updateHabit(at: indexPath.row, text: text)
                }
            }
        )
        alert.addAction(saveAction)
        present(alert, animated: true)
    }
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



