//
//  CategoryManager.swift
//  Medi-Buddy
//
//  Created by Jinah Park on 2023/08/13.
//

import Foundation

class CategoryManager {
    static let shared = CategoryManager()
    
    private init() {}
    
    private var unOrderedList = [Category(categoryName: .morning, alarmTime: Date(timeIntervalSinceNow: -5000), isAlarmed: true),
                Category(categoryName: .inNeed, alarmTime: Date(timeIntervalSinceNow: -1500), isAlarmed: true),
                Category(categoryName: .beforeBed, alarmTime: Date(timeIntervalSinceNow: -1000), isAlarmed: true),
                Category(categoryName: .custom("비염약"), alarmTime: Date(timeIntervalSinceNow: -2000), isAlarmed: true),
                Category(categoryName: .custom("알러지약"), alarmTime: Date(timeIntervalSinceNow: -3000), isAlarmed: true)]
    
    var list: [Category] {
        return unOrderedList.sorted { $0.alarmTime < $1.alarmTime }
    }
    
    func getCategory(of name: Category.Name) -> Category? {
        return list.first { $0.name == name }
    }
    
    func getCategory(at section: Int) -> Category? {
        return list[at: section]
    }
    
    func add(category: Category) {
        unOrderedList.append(category)
    }
    
    func update(category: Category) {
        guard let updateIndex = unOrderedList.firstIndex(where: { $0.id == category.id }) else { return }
        
        unOrderedList[updateIndex] = category
    }
    
    func delete(category: Category) {
        guard let removeIndex = unOrderedList.firstIndex(of: category) else { return }
        unOrderedList.remove(at: removeIndex)
    }
}
