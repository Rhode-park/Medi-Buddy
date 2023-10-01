//
//  ModifyCategoryViewController.swift
//  Medi-Buddy
//
//  Created by Jinah Park on 2023/09/28.
//

import UIKit

final class ModifyCategoryViewController: UIViewController {
    private var categoryList: [Category] {
        return CategoryManager.shared.list
    }
    
    var controllerChangeHandler: (()->())?
    
    private let categoryTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CategoryCell.self, forCellReuseIdentifier: CategoryCell.reuseIdentifier)
        tableView.backgroundColor = .systemGroupedBackground
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureDataSource()
        configureDelegate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        controllerChangeHandler?()
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        configureSubView()
        configureConstraint()
    }
    
    private func configureDataSource() {
        categoryTableView.dataSource = self
    }
    
    private func configureDelegate() {
        categoryTableView.delegate = self
    }
    
    private func configureNavigationBar() {
        let addCategoryButton = UIBarButtonItem(barButtonSystemItem: .add,
                                                target: self,
                                                action: #selector(addCategoryButtonTapped))
        addCategoryButton.tintColor = .systemCyan
        
        self.navigationController?.navigationBar.topItem?.leftBarButtonItem = addCategoryButton
        self.navigationController?.navigationBar.topItem?.title = "카테고리 수정"
    }
    
    @objc
    private func addCategoryButtonTapped() {
        let addCategoryViewController = AddCategoryViewController()
        
        self.present(addCategoryViewController, animated: true)
    }
    
    private func configureSubView() {
        view.addSubview(categoryTableView)
    }
    
    private func configureConstraint() {
        NSLayoutConstraint.activate([
            categoryTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            categoryTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            categoryTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            categoryTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension ModifyCategoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let category = categoryList[at: indexPath.row] else { return CategoryCell() }
        
        guard let cell = categoryTableView.dequeueReusableCell(withIdentifier: CategoryCell.reuseIdentifier, for: indexPath) as? CategoryCell else { return CategoryCell() }
        
        cell.configureCell(category: category)
        
        return cell
    }
}

extension ModifyCategoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let categoryToModify = categoryList[at: indexPath.row] else { return }
        
        let addCategoryViewController = AddCategoryViewController()
        addCategoryViewController.configureCategory(categoryToModify)
        
        self.present(addCategoryViewController, animated: true)
    }
}
