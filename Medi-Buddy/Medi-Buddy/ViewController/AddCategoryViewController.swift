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
    
    var cancelButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .systemCyan
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    var doneButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "checkmark"), for: .normal)
        button.tintColor = .systemCyan
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
    
    let alramTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "알람 시간"
        label.font = .preferredFont(forTextStyle: .body)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let alramTimePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .time
        picker.preferredDatePickerStyle = .inline
        picker.locale = Locale(identifier: "ko_KR")
        picker.translatesAutoresizingMaskIntoConstraints = false
        
        return picker
    }()
    
    let categoryColorLabel: UILabel = {
        let label = UILabel()
        label.text = "색상"
        label.font = .preferredFont(forTextStyle: .body)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
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
    }
    
    private func configureSubView() {
        view.addSubview(cancelButton)
        view.addSubview(doneButton)
        view.addSubview(categoryTextField)
        view.addSubview(alramTimeLabel)
        view.addSubview(alramTimePicker)
        view.addSubview(categoryColorLabel)
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
            alramTimeLabel.topAnchor.constraint(equalTo: categoryTextField.bottomAnchor, constant: 28),
            alramTimeLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            alramTimePicker.centerYAnchor.constraint(equalTo: alramTimeLabel.centerYAnchor),
            alramTimePicker.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            alramTimePicker.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 1/3),
            categoryColorLabel.topAnchor.constraint(equalTo: alramTimeLabel.bottomAnchor, constant: 16),
            categoryColorLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
        ])
    }
    
    private func configureTarget() {
        cancelButton.addTarget(self, action: #selector(cancelEditing), for: .touchUpInside)
        doneButton.addTarget(self, action: #selector(doneEditing), for: .touchUpInside)
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
        alramTimePicker.date = category.alarmTime
    }
    
    private func addCategory(name: String) {
        print("addCategory")
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
