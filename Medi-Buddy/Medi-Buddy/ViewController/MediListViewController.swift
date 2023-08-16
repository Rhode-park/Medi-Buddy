//
//  MediListViewController.swift
//  Medi-Buddy
//
//  Created by Jinah Park on 2023/08/13.
//

import UIKit

final class MediListViewController: UIViewController {
    private var isSectionHidden = [Category: Bool]() {
        didSet {
            mediListCollectionView.reloadData()
        }
    }
    
    lazy var mediListCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureListLayout())
        collectionView.register(MediListCell.self, forCellWithReuseIdentifier: "MediListCell")
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderView")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureDataSource()
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        configureNavigationBar()
        configureSubView()
        configureConstraint()
    }
    
    private func configureDataSource() {
        mediListCollectionView.dataSource = self
    }
    
    private func configureNavigationBar() {
        let addMedicineButton = UIBarButtonItem(barButtonSystemItem: .add,
                                                target: self,
                                                action: #selector(addMedicineButtonTapped))
        addMedicineButton.tintColor = .systemCyan
        
        let settingButton = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"),
                                            style: .plain,
                                            target: self,
                                            action: #selector(settingButtonTapped))
        settingButton.tintColor = .systemCyan
        
        navigationItem.leftBarButtonItem = addMedicineButton
        navigationItem.rightBarButtonItem = settingButton
        navigationItem.title = Date().convertDate()
    }
    
    @objc
    private func addMedicineButtonTapped() {
        let addMedicineViewController = AddMedicineViewController()
        addMedicineViewController.sheetPresentationController?.detents = [.medium()]
        addMedicineViewController.addMedicineHandler = { medicine in
            
            if MedicineManager.shared.list.filter({ $0.name == medicine.name && $0.category == medicine.category }).count != 0 {
                MedicineManager.shared.update(medicine: medicine)
            } else {
                MedicineManager.shared.add(medicine: medicine)
            }
            
            self.mediListCollectionView.reloadData()
        }
        
        self.present(addMedicineViewController, animated: true)
    }
    
    @objc
    private func settingButtonTapped() {
        print("setMedicineList")
    }
    
    private func configureSubView() {
        view.addSubview(mediListCollectionView)
    }
    
    func configureListLayout() -> UICollectionViewCompositionalLayout {
        var configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        configuration.trailingSwipeActionsConfigurationProvider = { indexPath in
            guard let medicineToDelete = MedicineManager.shared.list.filter({ $0.category == MedicineManager.shared.categoryList[at: indexPath.section] })[at: indexPath.item] else { return UISwipeActionsConfiguration() }
            let deleteAction = UIContextualAction(style: .destructive, title: "삭제") { action, view, actionPerformed in
                MedicineManager.shared.delete(medicine: medicineToDelete)
                self.mediListCollectionView.reloadData()
                actionPerformed(true)
            }

            return UISwipeActionsConfiguration(actions: [deleteAction])
        }
        configuration.headerMode = .supplementary
        
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        
        return layout
    }
    
    private func configureConstraint() {
        NSLayoutConstraint.activate([
            mediListCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mediListCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mediListCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            mediListCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension MediListViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return MedicineManager.shared.categoryList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let category = CategoryManager.shared.getCategory(at: section) else { return 0 }
        
        if !isSectionHidden[category, default: false] {
            return MedicineManager.shared.list.filter { $0.category == MedicineManager.shared.categoryList[at: section] }.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let medicine = MedicineManager.shared.list.filter({ $0.category == MedicineManager.shared.categoryList[at: indexPath.section] })[at: indexPath.item] else { return MediListCell() }
        
        guard let cell = mediListCollectionView.dequeueReusableCell(withReuseIdentifier: "MediListCell",
                                                                    for: indexPath) as? MediListCell else { return MediListCell() }
        cell.configureCell(medicine: medicine)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard kind == UICollectionView.elementKindSectionHeader,
              let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: "HeaderView",
                for: indexPath
              ) as? HeaderView else { return UICollectionReusableView() }
        
        guard let category = MedicineManager.shared.categoryList[at: indexPath.section] else { return HeaderView() }
        
        guard let hiddenCategory = CategoryManager.shared.getCategory(at: indexPath.section) else { return HeaderView() }
        
        header.configureHeader(category: category)
        header.configureIsCellHidden(isCellHidden: isSectionHidden[hiddenCategory, default: false])
        header.hideHandler = { [weak self] isHidden in
            self?.isSectionHidden[hiddenCategory] = isHidden
        }
        
        return header
    }
}
