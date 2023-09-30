//
//  ModifyCategoryViewController.swift
//  Medi-Buddy
//
//  Created by Jinah Park on 2023/09/28.
//

import UIKit

final class ModifyCategoryViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
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
}
