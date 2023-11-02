//
//  ColorCell.swift
//  Medi-Buddy
//
//  Created by Jinah Park on 2023/11/01.
//

import UIKit

final class ColorCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 12
        self.layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(color: UIColor) {
        self.backgroundColor = color
    }
}
