//
//  Day 26.swift
//  BaekJoon
//
//  Created by Kyus'lee on 2022/03/04.
//

import Foundation

//Day 26: BackTracking ç·´ç¿ (1) + å·ç¾ (3) + DP(3)
// ð±Back Tracking
//BaekJoon Algorithm Study n.15649 (Nã¨M (1))  éè¦åº¦:ðððððð
//â ï¸åå¸°é¢æ°ãä½¿ããªããã°ãããªãã¨ãããã¨ã¯åãã£ã¦ããããåä¾ãã§ãã¦ãã¾ã£ã
// â¼ï¸åä¾ãåºãªãããã«ããã£ããã¨åé¡åæãããã¨ã¨debugãããã¨ã¯ã¨ã¦ãéè¦ã§ãããã¨ãè¦ãã¦ãã

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

//ããå¹çããã³ã¼ããä½æãã¦ã¿ãã
let data = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = data[0], M = data[1]
var checked = Array(repeating: false, count: N + 1)
var result = ""

dfs_select(depth: 0, number: "")
print(result)

func dfs_select(depth: Int, number: String) {
    if depth == M {
        // Måé¸ãã ããresultã« +ï¼ã§å ãã¦æ¹è¡ãè¡ã
        result += "\(number)\n"
        return
    }

    for i in 1...N {
        if !checked[i] {
            checked[i] = true
            dfs_select(depth: depth + 1, number: number + "\(i) ")
            // åå¸°é¢æ°ãè¡ã£ãå¾ãcheckãè§£é¤ãããã¨ãéå¸¸ã«éè¦ã§ãã
            checked[i] = false
        }
    }
}

//ð±å·ç¾ã¢ã«ã´ãªãºã 
//BaekJoon Algorithm Study n.1475 (é¨å±çªå·)
//dictionaryãä½¿ããã¨ãããããã¾ãè¡¨ç¾ã§ããªãã£ã
//ä»åã®åé¡ã«é¢ãã¦ã¯ãremoveLastãä½¿ã£ã¦[ï¼]ãæ¶ãããã¯ãç´æ¥[9] = 0ã«å¤ããæ¹æ³ãå¦çæéãããæ©ãã£ã

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

//BaekJoon Algorithm Study n.14891 (æ­¯è») éè¦åº¦ã:ððððððððððð
// ð¥Very Difficultð¥
// â¡ï¸â ï¸å¿ããå¾©ç¿ãããã¨ï¼â¼ï¸
// ð®ðãã®åé¡ã®è§£ãæ¹ãã¢ã«ã´ãªãºã ãã¡ããã¨åæããä½¿ãããªããããã«ãããã¨ï¼

var wheelArray = [[Int]]()
var resultSum = 0
var pole = [(left: Int, right: Int)](repeating: (6, 2), count: 4)
var moveInit = [Bool](repeating: false, count: 4)
var isMoved = moveInit

//ð¥â ï¸åå¸°é¢æ°ã®è¡¨ç¾ãé£ããã£ããããâ¼ï¸
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
        // æ­¯è»ãæè¨åããããæè¨åããããããpole[wheelIndex]ãè¡¨ãindexã¯ 1ãã¤ããã¦ãã
        pole[wheelIndex].left = (pole[wheelIndex].left + 7) % 8
        pole[wheelIndex].right = (pole[wheelIndex].right + 7) % 8
    } else if direction == -1 {
        // æ­¯è»ãåæè¨åããããåæè¨åããããããpole[wheelIndex]ãè¡¨ãindexã¯ 1ãã¤ããã¦ãã
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
