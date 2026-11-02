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
    
    private func setupCardView(_ cardView: UIView, in contentView: UIView) {
        cardView.backgroundColor = .white
        cardView.layer.cornerRadius = 16
        cardView.layer.masksToBounds = true
        
        contentView.addSubview(cardView)
        contentView.sendSubviewToBack(cardView)
        cardView.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6)
            
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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "HabitCell")
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
    
    func setupCheckMarkView(_ checkMarkView: UIView, in cardView: UIView) {
        
     
        checkMarkView.layer.cornerRadius = 12
        checkMarkView.layer.borderWidth = 1.5
        checkMarkView.layer.borderColor = UIColor(
            red: 168.0 / 255.0,
            green: 185.0 / 255.0,
            blue: 154.0 / 255.0,
            alpha: 1
        ).cgColor
        
        checkMarkView.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(checkMarkView)
        
        NSLayoutConstraint.activate([
            checkMarkView.widthAnchor.constraint(equalToConstant: 24),
            checkMarkView.heightAnchor.constraint(equalToConstant: 24),
            checkMarkView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),
            checkMarkView.centerYAnchor.constraint(equalTo: cardView.centerYAnchor)
        ])
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
    
    @objc func checkMarkTapped(_ sender: UITapGestureRecognizer) {
        guard
            let identifier = sender.view?.accessibilityIdentifier,
            identifier.hasPrefix("habit-checkmark-"),
            let habitID = UUID(uuidString: String(identifier.dropFirst("habit-checkmark-".count)))
        else {
            return
        }
        viewModel.completeHabit(habit: habitID, date: Date())
        
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
        cell.contentView.subviews
            .filter { $0 is UIView && $0.accessibilityIdentifier != nil }
            .forEach { $0.removeFromSuperview() }
        let cardView = UIView()
        cardView.accessibilityIdentifier = "habit-card"
        let checkMarkView = UIView()
        let checkImageView = UIImageView()
        checkImageView.image = UIImage(systemName: "checkmark")
        checkImageView.tintColor = .white
        checkImageView.contentMode = .scaleAspectFit
        checkImageView.isHidden = true
        checkMarkView.addSubview(checkImageView)
        checkImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            checkImageView.centerXAnchor.constraint(equalTo: checkMarkView.centerXAnchor),
            checkImageView.centerYAnchor.constraint(equalTo: checkMarkView.centerYAnchor),
            checkImageView.widthAnchor.constraint(equalToConstant: 12),
            checkImageView.heightAnchor.constraint(equalToConstant: 12)
        ])
        setupCardView(cardView, in: cell.contentView)
        setupCheckMarkView(checkMarkView, in: cardView)
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(checkMarkTapped(_:))
        )
        
        checkMarkView.accessibilityIdentifier = "habit-checkmark-\(habit.id.uuidString)"
        checkMarkView.addGestureRecognizer(tapGesture)
        checkMarkView.isUserInteractionEnabled = true
        
        cell.textLabel?.text = habit.text
        cell.textLabel?.textColor = UIColor(
            red: 52.0 / 255.0,
            green: 66.0 / 255.0,
            blue: 54.0 / 255.0,
            alpha: 1
        )
        cell.backgroundColor = .clear
        cell.contentView.backgroundColor = .clear
        cell.accessoryType = .none
        
        if viewModel.isCompleted(habit: habit.id, date: Date()) {
            checkImageView.isHidden = false
            checkMarkView.backgroundColor = UIColor(
                red: 168.0 / 255.0,
                green: 185.0 / 255.0,
                blue: 154.0 / 255.0,
                alpha: 1
            )
        } else {
            checkImageView.isHidden = true
            checkMarkView.backgroundColor = .clear
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



