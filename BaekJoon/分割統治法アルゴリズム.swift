//
//  分割統治法アルゴリズム.swift
//  BaekJoon
//
//  Created by Kyus'lee on 2022/04/03.
//

import Foundation

//❗️- - - - 📮 分割統治法のアルゴリズム 📚 - - - -❗️
// 🔥分割統治法には、Quick Sort　と　Merge Sortがある

//⭐️ - - - -📝 Quick Sortのアルゴリズム - - - - ⭐️
func quickSort(_ array: [Int]) -> [Int] {
    guard let first = array.first, array.count > 1 else { return array }
 
    let pivot = first
    let left = array.filter { $0 < pivot }
    let right = array.filter { $0 > pivot }
    
    return quickSort(left) + [pivot] + quickSort(right)
}
