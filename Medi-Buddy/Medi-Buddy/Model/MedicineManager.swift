//
//  MedicineManager.swift
//  Medi-Buddy
//
//  Created by Jinah Park on 2023/08/13.
//

import Foundation

class MedicineManager {
    static let shared = MedicineManager()
    
    private init() {}
    
    private(set) var list = [Medicine(name: "프로비질", maximumDose: 2, currentDose: 2, category: CategoryManager.shared.getCategory(of: .morning), id: UUID()),
                             Medicine(name: "명인탄산리튬정", maximumDose: 2, currentDose: 1, category: CategoryManager.shared.getCategory(of: .morning), id: UUID()),
                             Medicine(name: "콘서타OROS서방정27mg", maximumDose: 3, currentDose: 2, category: CategoryManager.shared.getCategory(of: .morning), id: UUID()),
                             Medicine(name: "콘서타OROS서방정18mg", maximumDose: 1, currentDose: 0, category: CategoryManager.shared.getCategory(of: .inNeed), id: UUID()),
                             Medicine(name: "펨도필러스유산균", maximumDose: 2, currentDose: 0, category: CategoryManager.shared.getCategory(of: .inNeed), id: UUID()),
                             Medicine(name: "오메가3", maximumDose: 4, currentDose: 2, category: CategoryManager.shared.getCategory(of: .beforeBed), id: UUID()),
                             Medicine(name: "아리피진정5mg", maximumDose: 2, currentDose: 1, category: CategoryManager.shared.getCategory(of: .custom("비염약")), id: UUID())]
    
    var categoryList: [Category] {
        return Set(list.compactMap{ $0.category }).sorted { $0.alarmTime < $1.alarmTime }
    }
    
    func add(medicine: Medicine) {
        list.append(medicine)
    }
    
    func update(medicine: Medicine) {
        guard let updateIndex = list.firstIndex(where: { $0.id == medicine.id }) else { return }
        
        let newMedicine = Medicine(name: medicine.name,
                                   maximumDose: medicine.maximumDose,
                                   currentDose: medicine.currentDose,
                                   category: medicine.category,
                                   id: medicine.id)
        list[updateIndex] = newMedicine
    }
    
    func delete(medicine: Medicine) {
        guard let removeIndex = list.firstIndex(of: medicine) else { return }
        list.remove(at: removeIndex)
    }
}
