//
//  Atcoder Beginner Contest 235.swift
//  AtCoder
//
//  Created by Kyus'lee on 2022/04/29.
//

import Foundation
//AtCoder Beginner Contest 235
// ⚠️途中の段階
//Atcoder n.235 - A

var input = Array(readLine()!)
var sum = Int(input.map { String($0) }.reduce("", +))!

for _ in 0..<2 {
    let remove = input.removeFirst()
    input.append(remove)
    sum += Int(input.map { String($0) }.reduce("", +))!
}

print(sum)

//Atcoder n.235 - B
let input = readLine()!.split(separator: " ").map { Int(String($0))! }
let rowSize = input[0], columnSize = input[1]
var newMap = Array(repeating: Array(repeating: 0, count: rowSize), count: columnSize)
var result = ""

for i in 0..<rowSize {
    let putData = readLine()!.split(separator: " ").map { Int(String($0))! }
    for j in 0..<putData.count {
        newMap[j][i] = putData[j]
    }
}

for i in 0..<columnSize {
    result += newMap[i].map { String($0) }.joined(separator: " ")
    result += "\n"
}
result.removeLast()
print(result)

//Atcoder n.235 - C
