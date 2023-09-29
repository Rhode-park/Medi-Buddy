//
//  Medicine.swift
//  Medi-Buddy
//
//  Created by Jinah Park on 2023/08/13.
//

import Foundation

struct Medicine: Equatable {
    let name: String
    let maximumDose: Int
    let currentDose: Int
    let category: Category?
    let id: UUID
    
    var doseState: String {
        return "\(currentDose)/\(maximumDose)"
    }
}
