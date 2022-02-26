//
//  Day20.swift
//  BaekJoon
//
//  Created by Kyus'lee on 2022/02/26.
//

import Foundation

//Day 20: Class2 多様なアルゴリズムに慣れていこう(1) + DP(1)

//BaekJoon Algorithm Study n.1018 (chess盤塗り替え) 重要度：🎖🎖🎖🎖🎖🎖
// BruteForce Algorithm

let board_Size = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = board_Size[0], M = board_Size[1]
var board_data = [[String]]()
var min_reColor = 0
var result = [Int]()

//持っているboardのデータ入力
for _ in 0..<N {
    board_data.append(readLine()!.map { String($0) })
}
//chess boardの左上の頂点となり得るstart地点として選択可能な空間の設定
for startRow in 0..<N - 7 {
    for startColumn in 0..<M - 7 {
        var start_White = 0
        var start_Black = 0

        for i in startRow..<startRow + 8 {
            for j in startColumn..<startColumn + 8 {
                // 左上から奇数番目の要素を探索　（配列であるから、i + j が偶数であるかを探索する）
                // Bから始まったらi + j が偶数であるところにBがある (WだったらW)
                //            i + j が奇数であるところがWになる　（BたったらBになる）
                if (i + j) % 2 == 0 {
                    if board_data[i][j] != "B" {
                        start_Black += 1
                    }
                    if board_data[i][j] != "W" {
                        start_White += 1
                    }
                } else {
                    if board_data[i][j] != "W" {
                        start_Black += 1
                    }
                    if board_data[i][j] != "B" {
                        start_White += 1
                    }
                }
            }
        }
        min_reColor = start_Black < start_White ? start_Black : start_White
        result.append(min_reColor)
    }
}

print(result.min()!)

//// directionを用いた方法じゃなく、for文でbrute force アルゴリズムを解いた方がいいかも
//let directionRow = [1, -1, 0, 0]
//let directionColumn = [0, 0, -1, 1]

//BaekJoon Algorithm Study n.4949 (バランスのいい世界) 重要度：🎖🎖🎖🎖🎖🎖
// Stack, 文字列を利用する

while true {
    let readSentence = readLine()!
    // Checkを用いてtrueかどうかの判断をするコードを作成した方がコンパイルエラーにならなかった
    var check = true
    guard readSentence != "." else {
        exit(0)
    }

    var stackParenthesis = [Character]()

    for char in readSentence {
        if char == "(" || char == "[" {
            stackParenthesis.append(char)
        } else if char == ")" || char == "]" {
            if stackParenthesis.isEmpty {
                check = false
                break
            }
            if char == ")" && stackParenthesis.removeLast() != "(" {
                check = false
                break
            } else if char == "]" && stackParenthesis.removeLast() != "[" {
                check = false
                break
            }
        }
    }

    if !check {
        print("no")
    } else {
        if !stackParenthesis.isEmpty {
            print("no")
        } else {
            print("yes")
        }
    }
}

// 🔥Dynamic Programming (DP)　動的計画法　アルゴリズム🔥 - Level 1
//BaekJoon Algorithm Study n.1003 (フィボナッチ関数) 重要度：🎖🎖🎖🎖🎖🎖
// 再帰関数を使わない方法

let testCase = Int(readLine()!)!
var count_0_1: [(Int, Int)] = [(1, 0), (0, 1)]

for i in 2..<41 {
    count_0_1 += [(count_0_1[i - 2].0 + count_0_1[i - 1].0, count_0_1[i - 2].1 + count_0_1[i - 1].1)]
}

for _ in 0..<testCase {
    let fibo_Num = Int(readLine()!)!
    print("\(count_0_1[fibo_Num].0) \(count_0_1[fibo_Num].1)")
}

//BaekJoon Algorithm Study n.9184 (楽しい関数実行) 重要度：🎖🎖🎖🎖🎖🎖
// 再帰関数を使うタイプ

//この解き方は、時間オーバーになってしまう
//配列を用意して記憶しておく方法を使ってみよう！
var array: [[[Int]]] = Array(repeating: Array(repeating: Array(repeating: 0, count: 21), count: 21), count: 21)

while true {
    let testCase = readLine()!.split(separator: " ").map { Int(String($0))! }
    let num1 = testCase[0], num2 = testCase[1], num3 = testCase[2]

    guard (num1 != -1 || num2 != -1 || num3 != -1)  else {
        exit(0)
    }

    print("w(\(num1), \(num2), \(num3)) = \(solution_w(num1, num2, num3))")
}

func solution_w(_ a: Int,_ b: Int, _ c: Int) -> Int {

    if a <= 0 || b <= 0 || c <= 0 {
        return 1
    } else if a < 21 && b < 21 && c < 21 && array[a][b][c] != 0 {
        //この表現がないと、50 50 50みたいのは実行されない　Time over
        return array[a][b][c]
    } else if a > 20 || b > 20 || c > 20 {
        array[20][20][20] = solution_w(20, 20, 20)
        return array[20][20][20]
    } else if a < b && b < c {
        array[a][b][c] = solution_w(a, b, c - 1) + solution_w(a, b - 1, c) - solution_w(a, b - 1, c)
        return array[a][b][c]
    } else {
        array[a][b][c] = solution_w(a - 1, b, c) + solution_w(a - 1, b - 1, c) + solution_w(a - 1, b, c - 1) - solution_w(a - 1, b - 1, c - 1)
        return array[a][b][c]
    }
}

//BaekJoon Algorithm Study n.1463 (1にさせる) 重要度：🎖🎖🎖🎖🎖🎖🎖
// 方法１：Queueを用いた表現　＞＞　処理時間が結構かかってしまう。。
let readX = Int(readLine()!)!
var result = 0
making1(num: readX)

func making1(num: Int) {
    var selectWay = [(num, 0)]
    var index = 0

    while index <= selectWay.count {
        let (currentNum, count) = selectWay[index]

        if selectWay[index].0 == 1 {
            print(selectWay[index].1)
            exit(0)
        }

        var nextNum = 0
        if currentNum % 3 == 0 {
            nextNum = currentNum / 3
            selectWay.append((nextNum, count + 1))
        }
        if currentNum % 2 == 0 {
            nextNum = currentNum / 2
            selectWay.append((nextNum, count + 1))
        }
        nextNum = currentNum - 1
        selectWay.append((nextNum, count + 1))
        index += 1
    }
}

////方法２：処理時間を短くするコード
////⚠️配列を使うのはどうだ >> 処理時間遅い
//let number = Int(readLine()!)!
//var dpArray = Array(repeating: 0, count: 1000001)
//
//guard number != 1 else {
//    print("0")
//    exit(0)
//}
//
//for i in 2...number {
//    dpArray[i] =
//}

//方法３:再帰関数を用いたコード
// 再帰関数の分析をしっかりとすること
let number = Int(readLine()!)!

func dp(_ num: Int) -> Int {
    if num == 1 {
        return 0
    } else if num == 2 || num == 3 {
        return 1
    } else {
        return min(dp(num/2) + num % 2, dp(num/3) + num % 3) + 1
    }
}
print(dp(number))

//BaekJoon Algorithm Study n.1904 (01タイル) 重要度：🎖🎖🎖🎖🎖🎖
// ⚠️途中の段階
