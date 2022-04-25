//
//  Day63.swift
//  BaekJoon
//
//  Created by Kyus'lee on 2022/04/25.
//

import Foundation

//BaekJoon n.1325 (効率的なハッキング)
//🎖DFS,BFS
//   ⚠️途中の段階
let data = readLine()!.split(separator: " ").map { Int(String($0))! }





//復習1: 入力されたn桁の整数を入れ替えて最も小さし整数にする -> 出力
var data = readLine()!.map { Int(String($0))! }
while data.first! == 0 {
    data.removeFirst()
}

var sortedData = data.sorted(by: <)
var first = ""
var resultData = ""

guard sortedData.count > 1 else {
    print(sortedData.first!)
    exit(0)
}

while sortedData.first! == 0 {
    let removeOne = String(sortedData.removeFirst())
    resultData += removeOne
}

var finalResult = sortedData.map { String($0) }
finalResult.insert(resultData, at: 1)
print(finalResult.reduce("", +))

//復習2: 入力値によるFizzBuzz問題
//⚠️途中の段階
