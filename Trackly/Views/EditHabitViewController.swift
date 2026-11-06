import UIKit

final class EditHabitViewController: UIViewController {
    var habitText: String
    var onSave: ((String) -> Void)?
    
    private let textField = UITextField()
    private let saveButton = UIButton(type: .system)
        
    init(habitText: String, onSave: ((String) -> Void)?) {
        self.habitText = habitText
        self.onSave = onSave
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextField()
        setupSaveButton()
        title = "Редактировать привычку"
        view.backgroundColor = .systemBackground
        navigationItem.prompt = "Изменение названия"
        
    }
    
    private func setupTextField() {
        textField.placeholder = "Название привычки"
        textField.borderStyle = .roundedRect
        view.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
        ])
    }
    
    private func setupSaveButton() {
        saveButton.setTitle("Save", for: .normal)
        saveButton.backgroundColor = .systemGreen
        saveButton.setTitleColor(.white, for: .normal)
        
        view.addSubview(saveButton)
        
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20),
            saveButton.widthAnchor.constraint(equalToConstant: 120),
            saveButton.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        saveButton.addTarget(
            self, action: #selector(saveButtonTapped), for: .touchUpInside
        )
    }
    
    @objc private func saveButtonTapped() {
        let newText = textField.text
        guard let newText = newText else { return }
        onSave?(newText)
        dismiss(animated: true)
    }
}
