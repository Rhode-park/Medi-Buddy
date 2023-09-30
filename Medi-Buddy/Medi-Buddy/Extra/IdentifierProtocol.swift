//
//  IdentifierProtocol.swift
//  Medi-Buddy
//
//  Created by Jinah Park on 2023/09/08.
//

import UIKit

protocol IdentifierProtocol {
    static var reuseIdentifier: String { get }
}

extension IdentifierProtocol {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension MediListCell: IdentifierProtocol {
    
}

extension HeaderView: IdentifierProtocol {
    
}

extension SettingCell: IdentifierProtocol {
    
}

extension CategoryCell: IdentifierProtocol {
    
}
