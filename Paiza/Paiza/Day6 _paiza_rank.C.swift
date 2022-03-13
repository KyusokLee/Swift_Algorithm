//
//  Day6 _paiza.swift
//  Paiza
//
//  Created by Kyus'lee on 2022/03/13.
//

import Foundation

//ゲームの画像 rank.C
// 焦りながらやってて間違えた問題
// 問題をちゃんと分析すること！
let data = readLine()!.split(separator: " ").map { Int(String($0))! }
let ySize = data[0], xSize = data[1]
var result = 0
if !conditionCheck(ySize, xSize) {
    exit(0)
}

let dy_dx = readLine()!.split(separator: " ").map { Int(String($0))! }
let dy = dy_dx[0], dx = dy_dx[1]
if !conditionCheck2(dy, dx) {
    exit(0)
}

result = abs(ySize * dx) + abs(xSize * dy) - abs(dy * dx)
print(result)

func conditionCheck(_ row: Int, _ column: Int) -> Bool {
    let isTrue = true
    if row < 1 || row > 10000 {
        return false
    }
    if column < 1 || row > 10000 {
        return false
    }
    
    return isTrue
}

func conditionCheck2(_ compareRow: Int, _ compareColumn: Int) -> Bool {
    let isAlsoTrue = true
    
    if compareRow < -1 * ySize || compareRow > ySize {
        return false
    }
    if compareColumn < -1 * xSize || compareColumn > xSize {
        return false
    }
    
    return isAlsoTrue
}

//回転寿司のメロン　rank.C

