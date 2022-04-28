//
//  dasd.swift
//  BaekJoon
//
//  Created by Kyus'lee on 2022/04/28.
//

import Foundation

//Day65 多様なアルゴリズム
//BaekJoon n.9095 (1,2,3足し算) 重要度: 🎖🎖🎖🎖🎖
// 🎖DP アルゴリズム
// どうやって足すかの個数を求める問題
let cases = Int(readLine()!)!
var dp = Array(repeating: 0, count: 12)
dp[1] = 1 // 1 = 1 １個
dp[2] = 2 // 2 = 1 + 1, 2 の2個
dp[3] = 4 // 3 = 1 + 1 + 1, 1 + 2, 2 + 1, 3 の4個

for i in 4..<12 {
    dp[i] = dp[i - 1] + dp[i - 2] + dp[i - 3]
}

for _ in 0..<cases {
    let putCase = Int(readLine()!)!
    print(dp[putCase])
}

//BaekJoon n.1107 (リモコン) 重要度: 🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖
//🎖 Brute Force アルゴリズム HARD🔥
// 現在のチャンネルは　ch.100である
// アイデアがすぐでなかった.. もう一度解いてみる価値があるいい問題
// 絶対値の差が +, - ボタンだけを押して求められる結果の最大値となる
let targetChannel = Int(readLine()!)!
let breakButtonCounts = Int(readLine()!)!
var breakButtonsArray = [Int]()
if breakButtonCounts != 0 {
    breakButtonsArray = readLine()!.split(separator: " ").map { Int(String($0))! }
}

var minButtons = abs(targetChannel - 100)
check_Recursive(0)
print(minButtons)

func check_Recursive(_ curNum: Int) {
    if curNum.digit >= 6 {
        return
    }

    for i in 0...9 {
        if !breakButtonsArray.contains(i) {
            let compare = curNum * 10 + i
            if compare == 0 {
                minButtons = min(minButtons, abs(targetChannel - compare) + 1)
            } else {
                minButtons = min(minButtons, abs(targetChannel - compare) + compare.digit)
                check_Recursive(compare)
            }
        }
    }
}

extension Int {
    var digit: Int {
        var num = self
        var count = 0
        while num > 0 {
            num /= 10
            count += 1
        }
        return count
    }
}

//もっと効率的なコード
let targetChannel = Int(readLine()!)!
let breakButtonCounts = Int(readLine()!)!
var breakButtonArray = [Int]()

if breakButtonCounts != 0 {
    breakButtonArray = readLine()!.split(separator: " ").map { Int(String($0))! }
}
var minPushCounts = abs(targetChannel - 100) // ここで絶対値の差は、+, -のボタンだけでチャンネルを変えるとき、押したボタンの回数を意味する

for i in 0...1000000 {
    //問題文では、targetChannelになりえる数の上限は1000000であると指定されているが、上からくるパータンも考えなきゃいけない
    // example:     targetNum = 500000とする
    //              ９と0のボタンが壊れるとする
    //              この場合 +, - だけでチャンネルを変えるとすると、abs(488888 - 500000) より、 abs(511111 - 500000)の方が小さいため 上からくるパータン  (500000を超えた数字からの探索)を考慮しなければいけない
    // 要するに、全探索の必要があるということ
    // このアルゴリズムは、Brute Force のとてもいい問題
    let compare = check(i)
    // abs(targetChannel - i) が意味するのは targetChannel　と現在探索している数字との差を意味
    //   つまり、直接ボタンを押してtargetChannel にたどりついた場合 -> 0になる
    //   上記の場合じゃない時は、直接押してたどりつく番号　+ +, -のボタンを押した回数の組み合わせになる
    if compare > 0 {
        minPushCounts = min(minPushCounts, abs(targetChannel - i) + compare)
    }
}
print(minPushCounts)

//リモコンを押した回数
func check(_ num: Int) -> Int {
    var compareNum = num
    if compareNum == 0 {
        if breakButtonArray.contains(0) {
            return 0
        } else {
            return 1
        }
    }

    var count = 0
    while compareNum > 0 {
        if breakButtonArray.contains(compareNum % 10) {
            // ここで、compareNum % 10が指すのは、最後の桁の数字を表す 1002だったら、2 -> 0 -> 0 -> 1 になる
            // 使えないボタンの配列に当てはまる場合、入力された全体の数字は使えるボタンだけではいけないため、return 0 (０回押したことを返す)
            return 0
        }
        //入力された桁数が番号を直接押してチャンネルを変えたことを意味するから、このように数字を10ずつ割って、その割った回数を返す関数にした
        // 例えば、入力値が1002である場合、1002 は4桁であるから、1002 ->(1回) 100 -> (2回) 10 -> (3回) 1 -> (4回) 0 --> return 4になる
        compareNum /= 10
        count += 1
    }

    return count
}

//BaekJoon n.13023 (ABCDE) 重要度: 🎖🎖🎖🎖🎖🎖
//🎖 DFS HARD!🔥
// この問題のポイントは、入力された数の全ての人々が一つで線で繋がるかないかを求める問題である。
// ⚠️途中の段階
let data = readLine()!.split(separator: " ").map { Int(String($0))! }
let peopleNums = data[0], relations = data[1]
var relationsArray = Array(repeating: [Int](), count: peopleNums)
var isAvailable = false

for _ in 0..<relations {
    let putRelationData = readLine()!.split(separator: " ").map { Int(String($0))! }
    relationsArray[putRelationData[0]].append(putRelationData[1])
    relationsArray[putRelationData[1]].append(putRelationData[0])
}

print(relationsArray)

for i in 0..<peopleNums {
    var checked = Array(repeating: false, count: peopleNums)
    dfs_checkPeople(i, &checked)
    if isAvailable {
        print(checked)
        break
    }
    print(checked)
}
print(isAvailable ? 1 : 0)

func dfs_checkPeople(_ num: Int, _ visited: inout [Bool]) {
    visited[num] = true

    for i in relationsArray[num] {
        if !visited[i] {
            dfs_checkPeople(i, &visited)
        }
    }
    if !visited.contains(false) {
        isAvailable = true
        return
    }

}
