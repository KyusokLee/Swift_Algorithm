//
//  Day21.swift
//  BaekJoon
//
//  Created by Kyus'lee on 2022/02/27.
//

import Foundation

//Day 20: 多様なアルゴリズムに慣れる　DP. (2)
//BaekJoon Algorithm Study n.1904 (01タイル) 重要度：🎖🎖🎖🎖🎖🎖
// ⚠️途中の段階
// Memoizationの活用
//この方法は、time over になってしまう
let readN = Int(readLine()!)!
var storage_array = Array(repeating: 0, count: 1000001)
print(fiboNum(readN))

func fiboNum(_ num: Int) -> Int {
    if num == 1 {
        storage_array[num] = 1
        return storage_array[num]
    } else if num == 2 {
        storage_array[num] = 2
        return storage_array[num]
    } else {
        storage_array[num] = fiboNum(num - 2) + fiboNum(num - 1)
        return storage_array[num]
    }
}

//方法２:Time over にならないコード
let readN = Int(readLine()!)!
var storage_array = Array(repeating: 0, count: readN + 1)
var index = 1

while index <= readN {
    if index == 1 {
        storage_array[index] = 1 % 15746
    } else if index == 2 {
        storage_array[index] = 2 % 15746
    } else {
        storage_array[index] = (storage_array[index - 1] + storage_array[index - 2]) % 15746
    }
    index += 1
}

print(storage_array[readN])

//方法３：配列を用いない、変数の値を変えるだけで完結する方法
// 🌈考察: 可能であれば、配列を使わない方法で解いてみよう


func fiboNum() -> Int {
    let num = Int(readLine()!)!
    var firstvalue = 1
    var secondvalue = 2

    switch num {
    case 1:
        return firstvalue
    case 2:
        return secondvalue
    default:
        var resultvalue = 0
        for _ in 3...num {
            resultvalue = (firstvalue + secondvalue) % 15746
            firstvalue = secondvalue
            secondvalue = resultvalue
        }
        return resultvalue
    }

}

print(fiboNum())

//BaekJoon Algorithm Study n.9461 (特殊な数列)

let testcaseNum = Int(readLine()!)!
for _ in 0..<testcaseNum {
    let number = Int(readLine()!)!
    var firstvalue = 1
    var secondvalue = 1

    switch number {
    case 1, 2, 3:
        return firstvalue
    default:
        return 3
    }

}

// 🌈考察；今回に関しては、入力例の範囲として100までだと設定されているため、配列を使った方がメモリ量を減らすことができたかもしれない
for _ in 0..<Int(readLine()!)! {
    let number = Int(readLine()!)!
    print(fiboNum2(number))
}

func fiboNum2(_ num: Int) -> Int {
    let target = num
    var firstValue = 1
    var secondValue = 1
    var thirdValue = 1

    switch target {
    case 1:
        return firstValue
    case 2:
        return secondValue
    case 3:
        return thirdValue
    default:
        var resultValue = 0
        for _ in 4...target {
            resultValue = firstValue + secondValue
            firstValue = secondValue
            secondValue = thirdValue
            thirdValue = resultValue
        }
        return resultValue
    }
}

//BaekJoon Algorithm Study n.1149 (RGB通り道) 重要度：🎖🎖🎖🎖🎖🎖🎖
//　🔥❗️Dynamic Programming の定番の問題でもあるから、ちゃんとスキルを学ぶこと
// 配列を２つ使った方法
let testCaseNum = Int(readLine()!)!
var colorCost = Array(repeating: Array(repeating: 0, count: 3), count: testCaseNum )
var minimumCost = Array(repeating: Array(repeating: 0, count: 3), count: testCaseNum )

for i in 0..<testCaseNum {
    let R_G_B = readLine()!.split(separator: " ").map { Int(String($0))! }
    let red = R_G_B[0], green = R_G_B[1], blue = R_G_B[2]

    colorCost[i] = [red, green, blue]
}
minimumCost[0][0] = colorCost[0][0]
minimumCost[0][1] = colorCost[0][1]
minimumCost[0][2] = colorCost[0][2]

for i in 1..<testCaseNum {
    minimumCost[i][0] = min(minimumCost[i - 1][1], minimumCost[i - 1][2]) + colorCost[i][0]
    minimumCost[i][1] = min(minimumCost[i - 1][0], minimumCost[i - 1][2]) + colorCost[i][1]
    minimumCost[i][2] = min(minimumCost[i - 1][0], minimumCost[i - 1][1]) + colorCost[i][2]
}

print(minimumCost[testCaseNum - 1].min()!)

// 配列を1つ使った方法
let testCase = Int(readLine()!)!
var costArray = [[Int]]()
for _ in 0..<testCase {
    costArray.append(readLine()!.split(separator: " ").map { Int($0)! })
}

for i in 1..<testCase {
    costArray[i][0] = min(costArray[i - 1][1], costArray[i - 1][2]) + costArray[i][0]
    costArray[i][1] = min(costArray[i - 1][0], costArray[i - 1][2]) + costArray[i][1]
    costArray[i][2] = min(costArray[i - 1][0], costArray[i - 1][1]) + costArray[i][2]
}

print(costArray[testCase - 1].min()!)

//🌈考察 : +=　演算を使うよりは、 = の後に　＋演算を使った方がより処理時間が短くなった

//BaekJoon Algorithm Study n.2579 (階段登り) DP 重要度：🎖🎖🎖🎖🎖🎖🎖🎖🎖
//　考えが難しい
// 📮‼️⚠️Dynamic Programming (動的計画法)は非常に問題の分析とあるパターンを把握してコードで実現するのが大事である‼️
let stairCount = Int(readLine()!)!
var stairPoints = Array(repeating:0, count: stairCount + 1)
// 2重配列の設定： [連続に階段を踏んだか　、　連続で踏んでないか]
var getPointsArray = Array(repeating: Array(repeating: 0, count: 2), count: stairCount + 1)
var index = 0
var stepCount = 0
//階段ごとの点数設定
for i in 1...stairCount {
    stairPoints[i] = Int(readLine()!)!
}

guard stairCount != 1 else {
    print(stairPoints[1])
    exit(0)
}
guard stairCount != 2 else {
    print(stairPoints[1] + stairPoints[2])
    exit(0)
}
guard stairCount != 3 else {
    print(max(stairPoints[1] + stairPoints[3], stairPoints[2] + stairPoints[3]))
    exit(0)
}

// 階段をskipするシステムではなく、現在登った階段に至る経緯を全部調べるシステム
//初期の設定（１番目の階段）は、階段を連続的に登ったかにかかわらず、
getPointsArray[1][0] = stairPoints[1]
getPointsArray[1][1] = stairPoints[1]
getPointsArray[2][0] = stairPoints[1] + stairPoints[2]
getPointsArray[2][1] = stairPoints[2]

for i in 3...stairCount {
    getPointsArray[i][0] = getPointsArray[i - 1][1] + stairPoints[i]
    getPointsArray[i][1] = max(getPointsArray[i - 2][0], getPointsArray[i - 2][1]) + stairPoints[i]
}

print(max(getPointsArray[stairCount][0], getPointsArray[stairCount][1]))


//間違ったコード設計
//while true {
//    let (point, num) = getPointsArray[index]
//
//    if num == stairCount {
//        print(getPointsArray.last!.0)
//        break
//    }
//
//    let select = [num + 1, num + 2]
//
//    if stairPoints[select[0]] >= stairPoints[select[1]] && stepCount != 2 {
//        stepCount += 1
//        getPointsArray.append((point + stairPoints[select[0]], select[0]))
//    } else {
//        if stairPoints[select[0]] + stairPoints[select[1]] > stairPoints[select[1]] {
//            stepCount += 2
//            getPointsArray.append((point + stairPoints[select[0]] + stairPoints[select[1]], select[0] + 1))
//        } else if stairPoints[select[0]] + stairPoints[select[1]] < stairPoints[select[1]] {
//            stepCount = 1
//            getPointsArray.append((point + stairPoints[select[1]], select[1]))
//        }
//    }
//
//    index += 1
//}

//BaekJoon Algorithm Study n.10844 (n. 分かりやすい階段数) 重要度: 🎖🎖🎖🎖🎖🎖🎖🎖🎖
// ‼️HARD‼️
//🔥あるパターンを分析することが大事　＞＞　ノートで計算してそのパターンを把握すること！！
// ⚠️途中の段階
let numberLength = Int(readLine()!)!
