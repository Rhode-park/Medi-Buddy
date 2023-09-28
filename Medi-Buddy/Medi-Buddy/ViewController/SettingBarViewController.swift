//
//  SettingBarViewController.swift
//  Medi-Buddy
//
//  Created by Jinah Park on 2023/09/27.
//

import UIKit

protocol SettingBarViewControllerDelegate: AnyObject {
    func didSelect(menuItem: SettingBarMenu)
}

final class SettingBarViewController: UIViewController {
    weak var delegate: SettingBarViewControllerDelegate?
    
    private let settingTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(SettingCell.self, forCellReuseIdentifier: SettingCell.reuseIdentifier)
        tableView.backgroundColor = .systemGroupedBackground
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureDataSource()
        configureDelegate()
    }
    
    private func configureUI() {
        view.backgroundColor = .systemGroupedBackground
        configureSubView()
        configureConstraint()
    }
    
    private func configureDataSource() {
        settingTableView.dataSource = self
    }
    
    private func configureDelegate() {
        settingTableView.delegate = self
    }
    
    private func configureSubView() {
        view.addSubview(settingTableView)
    }
    
    private func configureConstraint() {
        NSLayoutConstraint.activate([
            settingTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            settingTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            settingTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            settingTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension SettingBarViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SettingBarMenu.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingCell.reuseIdentifier, for: indexPath)
        let model = SettingBarMenu.allCases[indexPath.row]
        cell.textLabel?.text = model.rawValue
        cell.backgroundColor = .systemGroupedBackground
        
        return cell
    }
}

extension SettingBarViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = SettingBarMenu.allCases[indexPath.row]
        delegate?.didSelect(menuItem: model)
    }
}
