//
//  Array+.swift
//  Medi-Buddy
//
//  Created by Jinah Park on 2023/08/15.
//

extension Array {
    subscript(at index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}
