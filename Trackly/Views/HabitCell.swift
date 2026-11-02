import UIKit

final class HabitCell: UITableViewCell {
    
    let cardView = UIView()
    let checkMarkView = UIView()
    let checkImageView = UIImageView()
    let habitLabel = UILabel()
    var onCheckmarkTapped: (() -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
        setupCardView()
        setupCheckMarkView()
        setupCheckImageView()
        setupHabitLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        selectionStyle = .none
    }
    
    private func setupCardView() {
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
    
    private func setupCheckMarkView() {
        
     
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
        
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(checkMarkTapped)
        )
        checkMarkView.addGestureRecognizer(tapGesture)
        checkMarkView.isUserInteractionEnabled = true
    }
    
    private func setupCheckImageView() {
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
    }
    
    private func setupHabitLabel() {
        habitLabel.textColor = UIColor(
            red: 52.0 / 255.0,
            green: 66.0 / 255.0,
            blue: 54.0 / 255.0,
            alpha: 1
        )
        cardView.addSubview(habitLabel)
        habitLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            habitLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            habitLabel.trailingAnchor.constraint(equalTo: checkMarkView.leadingAnchor, constant: -12),
            habitLabel.centerYAnchor.constraint(equalTo: cardView.centerYAnchor)
        ])
    }
    
    func configure(habit: Habit, isCompleted: Bool) {
        habitLabel.text = habit.text
        
        checkMarkView.backgroundColor = isCompleted ? UIColor(
            red: 168.0 / 255.0,
            green: 185.0 / 255.0,
            blue: 154.0 / 255.0,
            alpha: 1
        ): .clear
        
        checkImageView.isHidden = !isCompleted
        checkImageView.transform = .identity
    }
    
    func animateCheckmark(isCompleted: Bool) {
        let sageColor = UIColor(
            red: 168.0 / 255.0,
            green: 185.0 / 255.0,
            blue: 154.0 / 255.0,
            alpha: 1
        )
        
        if isCompleted {
            checkImageView.isHidden = false
            checkImageView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            
            UIView.animate(withDuration: 0.25, animations: {
                self.checkMarkView.backgroundColor = sageColor
                self.checkImageView.transform = .identity
            })
        } else {
            checkImageView.isHidden = false
            UIView.animate(withDuration: 0.2, animations: {
                self.checkMarkView.backgroundColor = .clear
                self.checkImageView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            }, completion: { _ in
                self.checkImageView.isHidden = true
                self.checkImageView.transform = .identity
            })
        }
    }
    
    @objc private func checkMarkTapped() {
        onCheckmarkTapped?()
    }
}

