//
//  AddCategoryViewController.swift
//  Medi-Buddy
//
//  Created by Jinah Park on 2023/10/01.
//

import Foundation
import UIKit

final class AddCategoryViewController: UIViewController {
    var category: Category? = nil
    
    var addCategoryHandler: ((Category) -> ())?
    
    var cancelButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = UIColor(named: "Main")
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    var doneButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "checkmark"), for: .normal)
        button.tintColor = UIColor(named: "Main")
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    let categoryTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "카테고리 이름"
        textField.font = .preferredFont(forTextStyle: .title2)
        textField.clearButtonMode = .always
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    let alarmTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "알림 시간"
        label.font = .preferredFont(forTextStyle: .body)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let alarmTimePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .time
        picker.preferredDatePickerStyle = .inline
        picker.locale = Locale(identifier: "ko_KR")
        picker.translatesAutoresizingMaskIntoConstraints = false
        
        return picker
    }()
    
    let alarmLabel: UILabel = {
        let label = UILabel()
        label.text = "알림 받기"
        label.font = .preferredFont(forTextStyle: .body)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let alarmSwitch: UISwitch = {
        let button = UISwitch()
        button.onTintColor = UIColor(named: "Main")
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    let categoryColorLabel: UILabel = {
        let label = UILabel()
        label.text = "색상"
        label.font = .preferredFont(forTextStyle: .body)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let categoryColorScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    
    let categoryColorStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        configureSubView()
        configureConstraint()
        configureTarget()
        configureContent()
        configureColorStackView()
    }
    
    private func configureSubView() {
        view.addSubview(cancelButton)
        view.addSubview(doneButton)
        view.addSubview(categoryTextField)
        view.addSubview(alarmTimeLabel)
        view.addSubview(alarmTimePicker)
        view.addSubview(alarmLabel)
        view.addSubview(alarmSwitch)
        view.addSubview(categoryColorLabel)
        view.addSubview(categoryColorScrollView)
        categoryColorScrollView.addSubview(categoryColorStackView)
    }
    
    private func configureConstraint() {
        NSLayoutConstraint.activate([
            cancelButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            cancelButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            doneButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            doneButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            categoryTextField.topAnchor.constraint(equalTo: cancelButton.bottomAnchor, constant: 28),
            categoryTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            categoryTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            alarmTimeLabel.topAnchor.constraint(equalTo: categoryTextField.bottomAnchor, constant: 28),
            alarmTimeLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            alarmTimePicker.centerYAnchor.constraint(equalTo: alarmTimeLabel.centerYAnchor),
            alarmTimePicker.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            alarmTimePicker.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 1/3),
            alarmLabel.topAnchor.constraint(equalTo: alarmTimeLabel.bottomAnchor, constant: 28),
            alarmLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            alarmSwitch.centerYAnchor.constraint(equalTo: alarmLabel.centerYAnchor),
            alarmSwitch.centerXAnchor.constraint(equalTo: alarmTimePicker.centerXAnchor),
            categoryColorLabel.topAnchor.constraint(equalTo: alarmLabel.bottomAnchor, constant: 28),
            categoryColorLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            categoryColorScrollView.frameLayoutGuide.topAnchor.constraint(equalTo: categoryColorLabel.bottomAnchor, constant: 16),
            categoryColorScrollView.frameLayoutGuide.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            categoryColorScrollView.frameLayoutGuide.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            categoryColorScrollView.frameLayoutGuide.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -28),
            categoryColorScrollView.contentLayoutGuide.topAnchor.constraint(equalTo: categoryColorLabel.bottomAnchor, constant: 16),
            categoryColorScrollView.contentLayoutGuide.widthAnchor.constraint(equalTo: categoryColorScrollView.frameLayoutGuide.widthAnchor, multiplier: CGFloat(Float(ColorChart.allCases.count))),
            categoryColorScrollView.contentLayoutGuide.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -28),
            categoryColorStackView.topAnchor.constraint(equalTo: categoryColorScrollView.contentLayoutGuide.topAnchor),
            categoryColorStackView.leadingAnchor.constraint(equalTo: categoryColorScrollView.contentLayoutGuide.leadingAnchor),
            categoryColorStackView.trailingAnchor.constraint(equalTo: categoryColorScrollView.contentLayoutGuide.trailingAnchor),
            categoryColorStackView.bottomAnchor.constraint(equalTo: categoryColorScrollView.contentLayoutGuide.bottomAnchor),
        ])
    }
    
    private func configureTarget() {
        cancelButton.addTarget(self, action: #selector(cancelEditing), for: .touchUpInside)
        doneButton.addTarget(self, action: #selector(doneEditing), for: .touchUpInside)
    }
    
    private func configureColorStackView() {
        for colors in ColorChart.allCases {
            guard let colorChip = Palette().color[colors] else { return }
            let colorView = ColorView()
            colorView.translatesAutoresizingMaskIntoConstraints = false
            colorView.configureColorChart(colorChip: colorChip)
            categoryColorStackView.addArrangedSubview(colorView)
            NSLayoutConstraint.activate([
                colorView.widthAnchor.constraint(equalTo: categoryColorScrollView.frameLayoutGuide.widthAnchor),
            ])
        }
        categoryColorStackView.arrangedSubviews[0].backgroundColor = .cyan
        categoryColorStackView.arrangedSubviews[1].backgroundColor = .systemPink
        categoryColorStackView.arrangedSubviews[2].backgroundColor = .black
    }
    
    @objc
    private func cancelEditing() {
        self.dismiss(animated: true)
    }
    
    @objc
    private func doneEditing() {
        validateCategory()
    }
    
    func configureCategory(_ category: Category) {
        self.category = category
    }
    
    private func configureContent() {
        guard let category else { return }
        
        categoryTextField.text = category.name.description
        alarmTimePicker.date = category.alarmTime
        alarmSwitch.isOn = category.isAlarmed
    }
    
    private func addCategory(name: String) {
        let alarmTime = alarmTimePicker.date
        let isAlarmed = alarmSwitch.isOn
        let id = category?.id ?? UUID()
        
        category = Category(categoryName: Category.Name.custom(name), alarmTime: alarmTime, isAlarmed: isAlarmed, id: id)
        
        guard let category else { return }
        
        addCategoryHandler?(category)
    }
    
    private func validateCategory() {
        guard let categoryName = categoryTextField.text,
              !categoryName.isEmpty else {
            displayEmptyAlert()
            
            return
        }
        addCategory(name: categoryName)
        self.dismiss(animated: true)
    }
    
    private func displayEmptyAlert() {
        let alert = UIAlertController(title: nil, message: "추가하고자하는 카테고리의 이름을 입력하시오", preferredStyle: UIAlertController.Style.alert)
        let okayAction = UIAlertAction(title: "확인", style: .default)
        alert.addAction(okayAction)
        
        present(alert, animated: false)
    }
}
