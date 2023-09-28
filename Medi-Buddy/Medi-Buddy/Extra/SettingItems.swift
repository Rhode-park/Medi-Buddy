//
//  SettingItems.swift
//  Medi-Buddy
//
//  Created by Jinah Park on 2023/09/27.
//

enum SettingBarState {
    case opened
    case closed
}

enum SettingBarMenu: String, CaseIterable {
    case main = "메인"
    case category = "카테고리"
}
