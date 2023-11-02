//
//  ColorView.swift
//  Medi-Buddy
//
//  Created by Jinah Park on 2023/10/30.
//

import UIKit

class ColorView: UIView {
    var colorChart = [[String]]()
    
    private let colorChartLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var colorCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureIconLayout())
        collectionView.register(ColorCell.self, forCellWithReuseIdentifier: ColorCell.reuseIdentifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        configureDataSource()
        configureDelegate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        configureSubView()
        configureConstraint()
    }
    
    private func configureDataSource() {
        colorCollectionView.dataSource = self
    }
    
    private func configureDelegate() {
        colorCollectionView.delegate = self
    }
    
    private func configureSubView() {
        self.addSubview(colorChartLabel)
        self.addSubview(colorCollectionView)
    }
    
    private func configureIconLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/4), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(1/4))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
    
    private func configureConstraint() {
        NSLayoutConstraint.activate([
            colorChartLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            colorChartLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            colorChartLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            colorCollectionView.topAnchor.constraint(equalTo: colorChartLabel.bottomAnchor, constant: 16),
            colorCollectionView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            colorCollectionView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            colorCollectionView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    func configureColorChart(colorChip: [[String]]) {
        colorChart = colorChip
    }
    
    func configureColorChartLabel(name: String) {
        colorChartLabel.text = name
    }
}

extension ColorView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let color = UIColor(named: colorChart[indexPath.section][indexPath.item]) else {
            return ColorCell()
        }
        
        guard let cell = colorCollectionView.dequeueReusableCell(withReuseIdentifier: ColorCell.reuseIdentifier, for: indexPath) as? ColorCell else {
            return ColorCell()
        }
        cell.configureCell(color: color)
        
        return cell
    }
}

extension ColorView: UICollectionViewDelegate {
    
}
