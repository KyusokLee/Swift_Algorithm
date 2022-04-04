//
//  Day 47.swift
//  BaekJoon
//
//  Created by Kyus'lee on 2022/04/04.
//

import Foundation

//Day46 DP分析(1) Knapsack アルゴリズム 0/1アルゴリズム
//BaekJoon Algorithm Study n.12865 (平凡なナップサック)　重要度: 🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖
//　アイテムの個数だけLoop文を繰り返す
typealias W_V = (weight: Int, value: Int)
let data = readLine()!.split(separator: " ").map { Int(String($0))! }
let items = data[0], maxWeight = data[1]
var itemData = [W_V]()
var dp = Array(repeating: Array(repeating: 0, count: maxWeight + 1), count: items)
// ここでdp配列は、ナップサックを0からナップサックが耐える重さの限度まで、１ずつ増やした各indexの重さを耐えるナップサックにしておいた配列
// つまり、 dp[0][0] = 0回目のナップサックが耐えられる重さが0である  ..> ここで、0回目というのは、持っているアイテムの数の分、loopを回す回数の順番である
//       dp[0][1] = 0回目のナップサックが耐えられる重さが1である
//       dp[1][7] = 1回目のナップサックが耐えられる重さが7である
//       dp[3][7] = 持っているアイテムの数の分、loopを回して問題文で与えられたmaxWeightとなるため、ここに格納された値がそのまま解答となる

for _ in 0..<items {
    let putData = readLine()!.split(separator: " ").map { Int(String($0))! }
    itemData.append((putData[0], putData[1]))
}

for i in 0..<items {
    for j in 1..<maxWeight + 1 {
        //１回目のアイテムである場合
        if i == 0 {
            //　現在の重さが入れようとするアイテムの重さより大きかったら、そのアイテムのvalueがそのまま最大値となる
            if j >= itemData[i].weight {
                dp[i][j] = itemData[i].value
            }
        } else {
            //2回目のアイテムからはこのように考慮すること!
            if j < itemData[i].weight {
                dp[i][j] = dp[i - 1][j]
            } else {
                //　現在の重さが入れようとするアイテムの重さより大きかったら、
                //  ->  max(現在のアイテムの価値(value) + (今考慮する重さ - 現在のアイテムの重さ)での価値、現在まで今の重さでの最大値)
                dp[i][j] = max(dp[i - 1][j], itemData[i].value + dp[i - 1][j - itemData[i].weight])
            }
        }
    }
}
print(dp)
print(dp[items - 1][maxWeight])

//より効率的なコード
// dp配列を２重配列じゃなく、単一配列として作成する方法
typealias W_V = (weight: Int, value: Int)
let data = readLine()!.split(separator: " ").map { Int(String($0))! }
nonFractionalBag(data)

func nonFractionalBag (_ n: [Int]) {
    let (itemNum, maxWeight) = (n[0] , n[1])
    var itemData = [W_V]()
    
    for _ in 0..<itemNum {
        let putData = readLine()!.split(separator: " ").map{ Int(String($0))! }
        itemData.append((putData[0], putData[1]))
    }
    
    var dp =  Array(repeating: 0, count: maxWeight + 1)

    for i in 0..<itemNum {
        for j in stride(from: maxWeight, to: 0, by: -1) {
            if j >= itemData[i].weight {
                dp[j] = max(dp[j], itemData[i].value + dp[j - itemData[i].weight])
            }
        }
    }

    print(dp[maxWeight])
}
