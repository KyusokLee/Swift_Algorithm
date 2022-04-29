//
//  day66.swift
//  BaekJoon
//
//  Created by Kyus'lee on 2022/04/29.
//

import Foundation

// Day66 多様なアルゴリズム - (4)
//BaekJoon n.13023 (ABCDE) 重要度: 🎖🎖🎖🎖🎖🎖
//🎖 DFS HARD!🔥
// この問題のポイントは、入力された人々の中で、一つの線で他の４人の友達関係をつなげることができる関係を持つグループがあるかないかを求める問題
// 🔥POINT : 全ての人を一つの線で繋げられなくてもかまわない！ -> ある人から線を引き始めて最大他の4人までつなげる関係さえあれば、入力されたグループにはABCDEといったグループがあるということになる　ー＞　正解
// Example) 7人がいるとする
// 0 - 1 - 2 - 3 - 4  --->  0からスタートして線一本で繋がった人の関係を経由し、他の4人と繋がることができる。
// 0 - 1 - 3 - 0 - 2 - 4　---> 3からスタートして線一本で繋がった人の関係を経由し、他の4人と繋がることができる。　 3 - 1 - 0 - 2 - 4
// 🔥dfsのlevelが4つまで探索するのが肝心である問題!

let data = readLine()!.split(separator: " ").map { Int(String($0))! }
let peopleNums = data[0], relations = data[1]
var relationsArray = Array(repeating: [Int](), count: peopleNums)
var isAvailable = false

for _ in 0..<relations {
    let putRelationData = readLine()!.split(separator: " ").map { Int(String($0))! }
    relationsArray[putRelationData[0]].append(putRelationData[1])
    relationsArray[putRelationData[1]].append(putRelationData[0])
}

for i in 0..<peopleNums {
    var visited = Array(repeating: false, count: peopleNums)
    dfs_checkPeople(0, i, &visited)
    if isAvailable {
        break
    }
}

print(isAvailable ? 1 : 0)

func dfs_checkPeople(_ depth: Int, _ num: Int, _ checked: inout [Bool]) {
    if depth == 4 {
        isAvailable = true
        return
    }

    checked[num] = true
    for i in relationsArray[num] {
        if !checked[i] {
            dfs_checkPeople(depth + 1, i, &checked)
            checked[i] = false
        }
    }
}

//BaekJoon n.11726 (2 x n タイル) 重要度: 🎖🎖🎖🎖🎖🎖
//🎖 DP
// ⚠️途中の段階
let data = Int(readLine()!)!



//復習2: 入力値によるFizzBuzz問題
// 入力例1: 2:two 3:three 7:seven 4:four 21
// 出力例1: threeseven
// 入力例2: 2:two 3:three 7:seven 4:four 29
// 出力例2: 29
// 入力例3: 2:two 3:three 7:seven 4:four 28
// 出力例3: twotwoseven

let data = readLine()!.split(separator: " ")
let targetNum = Int(data.last!)!
var dictionaryFizzBuzz = [Int: String]()
var result = ""

for i in 0..<data.count - 1 {
    let compareStr = data[i]
    if let intNum = compareStr.first!.wholeNumberValue {
        let dicStr = compareStr.split(separator: ":")
        dictionaryFizzBuzz[intNum] = String(dicStr.last!)
    }
}

var sortedDictionary = dictionaryFizzBuzz.sorted{ $0.0 < $1.0 }

if fizzbuzzCheck(targetNum) {
    print(result)
} else {
    print(targetNum)
}

func fizzbuzzCheck(_ num: Int) -> Bool {
    var isFind = false
    var compareNum = num

    while compareNum > 0 {
        for i in sortedDictionary {
            if compareNum % i.key == 0 {
                result += i.value
                compareNum /= i.key
                break
            } else {
                continue
            }
        }

        if compareNum == 1 {
            isFind = true
            break
        } else if compareNum == num {
            return false
        }
    }

    return isFind
}
