//
//  File.swift
//  BaekJoon
//
//  Created by Kyus'lee on 2022/05/14.
//

import Foundation
//Day 74 多様なアルゴリズム - (12)
//BaekJoon n.11053 (最長増加部分数列) 重要度: 🎖🎖🎖🎖🎖
// 🎖DP (LIS)
let size = Int(readLine()!)!
let array = readLine()!.split(separator: " ").map { Int(String($0))! }
var dp = Array(repeating: 1, count: size + 1)

for i in 1..<size {
    for j in 0..<i {
        if array[j] < array[i] {
            dp[i] = max(dp[i], dp[j] + 1)
        }
    }
}

print(dp.max()!)

//BaekJoon n.1932  (整数三角形) 重要度: 🎖🎖🎖🎖🎖🎖🎖
// 🎖DP
let size = Int(readLine()!)!
var arrayPyramid: [[Int]] = [[]]
var dp = Array(repeating: Array(repeating: 0, count: 501), count: 501) // (問題文のデータ上限値)

for _ in 0..<size {
    arrayPyramid.append(readLine()!.split(separator: " ").map { Int(String($0))! })
}

//arrayPyramid[0][0] は、現在 []の空列が入っている
dp[1][0] = arrayPyramid[1][0]
for i in stride(from: 2, through: size, by: 1) {
    for j in 0..<arrayPyramid[i].count {
        if j == 0 {
            // 左端
            dp[i][j] = dp[i - 1][j] + arrayPyramid[i][j]
        } else if j == arrayPyramid[i].count - 1 {
            // 右端
            dp[i][j] = dp[i - 1][j - 1] + arrayPyramid[i][j]
        } else if j < arrayPyramid[i].count - 1 {
            // 上記に当てはまらない　左端 ~ 右端の間にある値
            dp[i][j] = max(dp[i - 1][j - 1] + arrayPyramid[i][j], dp[i - 1][j] + arrayPyramid[i][j])
        }
    }
}

print(dp[size].max()!)

//BaekJoon n.1991  (ツリー巡回) 重要度: 🎖🎖🎖🎖🎖🎖🎖🎖🎖
// 🎖HARD Tree ❗️

// "A" == ASCII 65
// "." == ASCII 46
class TreeNode {
    let value: String
    var leftChild: TreeNode?
    var rightChild: TreeNode?

    init(_ value: String, _ left: TreeNode?, _ right: TreeNode?) {
        self.value = value
        self.leftChild = left
        self.rightChild = right
    }
}

func preOrder(current: TreeNode?) {
    guard let curr = current else {
        // nilの場合: return
        return
    }
    resultPreOrder.append(curr.value)

    preOrder(current: curr.leftChild)
    preOrder(current: curr.rightChild)
}

func inOrder(current: TreeNode?) {
    guard let curr = current else {
        return
    }
    inOrder(current: curr.leftChild)
    resultInOrder.append(curr.value)
    inOrder(current: curr.rightChild)
}

func postOrder(current: TreeNode?) {
    guard let curr = current else {
        return
    }
    postOrder(current: curr.leftChild)
    postOrder(current: curr.rightChild)

    resultPostOrder.append(curr.value)
}

extension TreeNode: CustomStringConvertible {
    var description: String {
        return [value].joined()
    }
}

let nodeNums = Int(readLine()!)!
var nodes = [TreeNode]() //nodesは、配列である
//-> しかし、出力すると、 このファイルが入っている  (プロジェクトの名前.TreeNode) が出てくる
// CustomStringConvertibleのプロトコルが必要だった

var resultPreOrder = [String]()
var resultInOrder = [String]()
var resultPostOrder = [String]()
let alphaArr = Array(65...90).map { String(Character(UnicodeScalar($0))) }
//入力された数字をUnicodeScalarにデータmappingしてそれをまた、文字（Character）に変更する文法

for i in 0..<nodeNums {
    nodes.append(TreeNode(alphaArr[i], nil, nil))
}

// UInt8 事態が Optinonal Typeであるため、次のmap では、 Int($0)!じやなく、Int($0)にした

for _ in 0..<nodeNums {
    let input = readLine()!.split(separator: " ").map { Character(String($0)).asciiValue! }.map { Int($0) - 65 }
    //UInt8に変換してまたInt型に変換
    //"."は、ASCII 46である

    if input[1] >= 0 {
        nodes[input[0]].leftChild = nodes[input[1]]
    }
    if input[2] >= 0 {
        nodes[input[0]].rightChild = nodes[input[2]]
    }
}

let root = nodes[0]

preOrder(current: root)
inOrder(current: root)
postOrder(current: root)

print(resultPreOrder.joined())
print(resultInOrder.joined())
print(resultPostOrder.joined())

//BaekJoon n.1629  (掛け算 (大数)) 重要度: 🎖🎖🎖🎖🎖
// 🎖数学 + 分割統治
let numData = readLine()!.split(separator: " ").map { Int(String($0))! }
let (A, B, C) = (numData[0], numData[1], numData[2])
print(dfs_mul(B))

func dfs_mul(_ num: Int) -> Int {
    if num == 0 {
        return 1
    }

    if num % 2 == 0 {
        let resultValue = dfs_mul(num / 2)
        return ((resultValue % C) * resultValue) % C
    } else {
        let resultValue = dfs_mul((num - 1) / 2)
        return ((((resultValue % C) * resultValue) % C) * A) % C
    }
}

//BaekJoon n.1039  (交換) 重要度: 🎖🎖🎖🎖🎖🎖🎖🎖
// 🎖BFS
// ⚠️途中の段階
let data = readLine()!.split(separator: " ").map { Int(String($0))! }
let targetNum = data[0], caseCount = data[1]
var checked = Array(repeating: Array(repeating: false, count: 11), count: 1000001)
var index = 0
