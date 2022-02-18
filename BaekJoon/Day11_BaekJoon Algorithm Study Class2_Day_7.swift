//
//  day11.swift
//  BaekJoon
//
//  Created by Kyus'lee on 2022/02/17.
//

import Foundation

//BaekJoon Algorithm Study n.2805 (木切り) 重要度：🎖🎖🎖🎖
// ９割以上自力で解けたので、やりがいを感じる😳🌱
//‼️二分探索　と　媒介変数探索のアルゴリズム
//⚠️　時間超過に注意すること！
//🌈❗️考察: mapよりcompactMapを使った方が処理時間をもっと短縮できた！
let need_data = readLine()!.split(separator: " ").compactMap { Int(String($0)) }
let have_tree = need_data[0]
let want_length = need_data[1]
let tree_data = readLine()!.split(separator: " ").compactMap { Int(String($0)) }

func tree_Finding(_ trees: [Int], _ length: Int) -> Int {
    var first = 0
    var last = trees.max()!
    var isPossible = false
    var max_setting = 0
    var middle = 0
    var count = 0
    
    while first <= last {
        count = 0
        middle = (first + last) / 2
        
        for i in tree_data {
            if i >= middle {
                count += i - middle
            } else {
                continue
            }
        }
        
        if count == length {
            max_setting = middle
            break
        }
        
        if count > length {
            isPossible = true
        } else if count < length {
            isPossible = false
        }
        
        if !isPossible {
            last = middle - 1
        } else {
            max_setting = middle
            first = middle + 1
        }
    }
    
    return max_setting
}

print(tree_Finding(tree_data, want_length))

//BaekJoon Algorithm Study n.1920 (数字探し) 重要度：🎖🎖🎖 ⚠️まだ、途中の段階
// 🔥二分探索　BinarySearch アルゴリズム
// ‼️どの状況の二分探索問題も二分探索アルゴリズムを改良してコードで実現する能力が必要である

let read_N = Int(readLine()!)!
var data_N = readLine()!.split(separator: " ").map { Int($0)! }
let read_M = Int(readLine()!)!
var data_M = readLine()!.split(separator: " ").map { Int($0)! }
data_N.sort()

var result_find = [Int]()

func binarySearch(_ array1: [Int], _ targetNum: Int ) -> Int {
    var startIdx = 0
    var endIdx = array1.count - 1
    
    while startIdx <= endIdx {
        let middle = (startIdx + endIdx) / 2
        if targetNum > S
        
    }
    
    return 0
}
