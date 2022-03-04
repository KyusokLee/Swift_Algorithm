//
//  Day 26.swift
//  BaekJoon
//
//  Created by Kyus'lee on 2022/03/04.
//

import Foundation

//Day 26: BackTracking 練習 (1) + 具現 (3) + DP(3)
// 🌱Back Tracking
//BaekJoon Algorithm Study n.15649 (NとM (1))  重要度:🎖🎖🎖🎖🎖🎖
//⚠️再帰関数を使わなければいけないということは分かっていたが、反例ができてしまった
// ‼️反例が出ないように、しっかりと問題分析することとdebugすることはとても重要であることを覚えてこう

let data = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = data[0], M = data[1]
var resultArray = [Int]()

recur_Select()

func recur_Select() {
    if resultArray.count == M {
        print(resultArray.map { String($0) }.joined(separator: " "))
        return
    }

    for i in 1...N {
        if !resultArray.contains(i) {
            resultArray.append(i)
            recur_Select()
            resultArray.removeLast()
        }
    }
}

//より効率いいコードを作成してみよう
let data = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = data[0], M = data[1]
var checked = Array(repeating: false, count: N + 1)
var result = ""

dfs_select(depth: 0, number: "")
print(result)

func dfs_select(depth: Int, number: String) {
    if depth == M {
        // M個選んだら、resultに +＝で加えて改行を行う
        result += "\(number)\n"
        return
    }

    for i in 1...N {
        if !checked[i] {
            checked[i] = true
            dfs_select(depth: depth + 1, number: number + "\(i) ")
            // 再帰関数を行った後、checkを解除することが非常に重要である
            checked[i] = false
        }
    }
}

//🌱具現アルゴリズム
//BaekJoon Algorithm Study n.1475 (部屋番号)
//dictionaryを使おうとしたが、うまく表現できなかった
//今回の問題に関しては、removeLastを使って[９]を消すよりは、直接[9] = 0に変える方法が処理時間がより早かった

let roomNum = readLine()!
var result_Array = Array(repeating: 0, count: 10)

for i in roomNum {
    result_Array[Int(String(i))!] += 1
}

result_Array[6] = (result_Array[6] + result_Array[9] + 1) / 2
result_Array[9] = 0

print(result_Array.max()!)

//BaekJoon Algorithm Study n.11576 (Base Conversion)
let data = readLine()!.split(separator: " ").map { Int(String($0))! }
let future = data[0], current = data[1]
let future_digit = Int(readLine()!)!
let future_number = readLine()!.split(separator: " ").map { Int(String($0))! }
var sort_futureNum = [Int]()
var sort_currentNum = [Int]()
var decimal_result = 0

for i in future_number.reversed() {
    sort_futureNum.append(i)
}

for i in 0..<sort_futureNum.count {
    if i == 0 {
        decimal_result = 1 * sort_futureNum[i]
    } else {
        decimal_result += sort_futureNum[i] * Int(pow(Double(future), Double(i)))
    }
}

calculate(notation: current, num: decimal_result)
print(sort_currentNum.map { String($0) }.joined(separator: " "))

func calculate(notation: Int, num: Int) {
    var temp = num

    while temp != 0 {
        let put = temp % notation
        temp /= notation
        sort_currentNum.insert(put, at: 0)
    }
}

//BaekJoon Algorithm Study n.14891 (歯車) 重要度　:🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖
// 🔥Very Difficult🔥
// ➡️⚠️必ず、復習すること！‼️
// 📮📝この問題の解き方やアルゴリズムをちゃんと分析し、使いこなせるようにすること！

var wheelArray = [[Int]]()
var resultSum = 0
var pole = [(left: Int, right: Int)](repeating: (6, 2), count: 4)
var moveInit = [Bool](repeating: false, count: 4)
var isMoved = moveInit

//🔥⚠️再帰関数の表現が難しかった。。。‼️
func turningWheel(wheelIndex: Int, direction: Int) {
    isMoved[wheelIndex] = true
    let (left, right) = pole[wheelIndex]
    
    if wheelIndex - 1 >= 0 && !isMoved[wheelIndex - 1] {
        let (_ , rightIndex) = pole[wheelIndex - 1]
        if wheelArray[wheelIndex][left] != wheelArray[wheelIndex - 1][rightIndex] {
            turningWheel(wheelIndex: wheelIndex - 1, direction: direction * (-1))
        }
    }
    if wheelIndex + 1 < 4 && !isMoved[wheelIndex + 1] {
        let (leftIndex, _) = pole[wheelIndex + 1]
        if wheelArray[wheelIndex][right] != wheelArray[wheelIndex + 1][leftIndex] {
            turningWheel(wheelIndex: wheelIndex + 1, direction: direction * (-1))
        }
    }
    
    if direction == 1 {
        // 歯車が時計回りする。時計回りするため、pole[wheelIndex]が表すindexは 1ずつずれていく
        pole[wheelIndex].left = (pole[wheelIndex].left + 7) % 8
        pole[wheelIndex].right = (pole[wheelIndex].right + 7) % 8
    } else if direction == -1 {
        // 歯車が反時計回りする。反時計回りするため、pole[wheelIndex]が表すindexは 1ずつずれていく
        pole[wheelIndex].left = (pole[wheelIndex].left + 1) % 8
        pole[wheelIndex].right = (pole[wheelIndex].right + 1) % 8
    }
}

for _ in 0..<4 {
    wheelArray.append(readLine()!.map { Int(String($0))! })
}

let turnCount = Int(readLine()!)!
for _ in 0..<turnCount {
    let turnData = readLine()!.split(separator: " ").map { Int(String($0))! }
    let wheelNum = turnData[0], turnDirection = turnData[1]
    
    turningWheel(wheelIndex: wheelNum - 1, direction: turnDirection)
    isMoved = moveInit
}

for i in 0..<4 {
    let direction_12clock = (pole[i].left + 2) % 8
    if wheelArray[i][direction_12clock] == 1 {
        resultSum += Int(pow(Double(2), Double(i)))
    }
}

print(resultSum)
