//
//  Medicine.swift
//  Medi-Buddy
//
//  Created by Jinah Park on 2023/08/13.
//

struct Medicine: Equatable {
    var name: String
    var maximumDose: Int
    var currentDose: Int
    var category: Category?
    
    var doseState: String {
        return "\(currentDose)/\(maximumDose)"
    }
}
