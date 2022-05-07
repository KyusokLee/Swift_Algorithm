//
//  Day70.swift
//  BaekJoon
//
//  Created by Kyus'lee on 2022/05/07.
//

import Foundation
//Day 70 多様なアルゴリズム - (8)
//BaekJoon n.17626 (Four Squares) 重要度: 🎖🎖🎖🎖🎖🎖🎖🎖
// 🎖‼️ DP , Brute Force
let number = Int(readLine()!)!
let inf = 987654321
var dp = Array(repeating: inf, count: 50001)
var index = 1
dp[1] = 1

while true {
    if index * index > 50000 {
        break
    }
    dp[index * index] = 1
    index += 1
}

for i in 1..<number + 1 {
    for j in 1...Int(sqrt(Double(i))) {
        dp[i] = min(dp[i], dp[i - j * j] + dp[j * j])
    }
}

print(dp[number])

//もっと効率的なコード
//　とてもいい問題　DP
let number = Int(readLine()!)!
var dp = [Int](repeating: 0, count: number + 1)
dp[1] = 1

for i in 2..<number + 1 {
    var minValue = Int.max // infiniteの表現
    var j = 1
    
    while j * j <= i {
        minValue = min(minValue, dp[i - j * j])
        j += 1
    }
    dp[i] = minValue + 1
}

print(dp[number])
