//
//  Day 12.swift
//  Paiza
//
//  Created by Kyus'lee on 2022/04/06.
//

import Foundation

//お菓子の詰め合わせ rank.A
// 出力結果が間違っているところがあったコード
// 単純にお釣りが最小になるときを選ぶのではなく、itemの個数がmaxになることを優先する必要があった
// 🔥かなり考えが難しい問題🔥

//例 1
//5 20
//10
//5
//5
//20
//9      -> maxCount : 3つのアイテムを選べる　最小のお釣り: 0

//例 2
//5 20
//1
//1
//19
//1
//1      -> maxCount : 4つのアイテムを選べる　最小のお釣りは4つのアイテムを選んだ時になる: 20 - 4 = 16

//例 3
//5 20
//20
//5
//5
//5
//5      -> maxCount : 4つのアイテムを選べる　最小のお釣りは、4つのアイテムを選んだ時になる:　20 - 20 = 0 (1つのアイテムを選んだ時ではなく、４つのアイテムを選んだときのお釣り)
//typealias Result = (itemCount: Int, money: Int)
//let data = readLine()!.split(separator: " ").map { String($0) }
//var items = 0, maxMoney = 0
//var itemArray = [Int]()
//guard conditionCheck1() else {
//    exit(0)
//}
//
//var result = maxMoney
//var dp = [[Result]](repeating: [Result](repeating: (0, 0), count: maxMoney + 1), count: items)
//
//for _ in 0..<items {
//    let itemData = readLine()!
//    var intData = 0
//    if !conditionCheck2(itemData, &intData) {
//        exit(0)
//    }
//
//    itemArray.append(intData)
//}
//
//var maxCount = 0
//var maxMoneyValue = 0
//var maxCountIdx1 = 0
//var maxCountIdx2 = 0
//
//for i in 0..<items {
//    for j in 1..<maxMoney + 1 {
//        if i == 0 {
//            if j >= itemArray[i] {
//                dp[i][j] = (1, itemArray[i])
//            }
//        } else {
//            if j < itemArray[i] {
//                dp[i][j] = dp[i - 1][j]
//            } else {
//                if itemArray[i] == j {
//                    dp[i][j] = (max(dp[i - 1][j].itemCount, 1), itemArray[i])
//                    maxCount = max(maxCount, dp[i][j].itemCount)
//                    continue
//                }
//
//                if dp[i - 1][j].money + itemArray[i] > j {
//                    if dp[i][j - itemArray[i]].money + itemArray[i] == j {
//                        dp[i][j].itemCount = max(dp[i][j - itemArray[i]].itemCount + 1, dp[i - 1][j].itemCount)
//                        dp[i][j].money = dp[i - 1][j].money
//                        maxCount = max(maxCount, dp[i][j].itemCount)
//                        continue
//                    }
////                    if dp[i][j - 1].itemCount > dp[i - 1][j].itemCount {
////                        dp[i][j].itemCount = dp[i][j - 1].itemCount
////                    }
//                    dp[i][j] = (dp[i - 1][j].itemCount, max(dp[i - 1][j].money, itemArray[i] + dp[i - 1][j - itemArray[i]].money))
//                } else if dp[i - 1][j].money + itemArray[i] == j {
//                    dp[i][j] = (dp[i - 1][j].itemCount + 1, max(dp[i - 1][j].money, itemArray[i] + dp[i - 1][j - itemArray[i]].money))
//                } else {
//                    dp[i][j] = (dp[i - 1][j].itemCount + 1, max(dp[i - 1][j].money, itemArray[i] + dp[i - 1][j - itemArray[i]].money))
//                }
//                maxCount = max(maxCount, dp[i][j].itemCount)
//                maxMoneyValue = max(maxMoneyValue, dp[i][j].money)
//                if dp[i][j].itemCount == maxCount {
//                    maxCountIdx1 = i
//                    maxCountIdx2 = j
//                }
//            }
//        }
//    }
//}
//
//for i in 0..<items {
//    print(dp[i])
//    print()
//}
//print(maxCount)
//print("i: \(maxCountIdx1), j: \(maxCountIdx2)")
//print(dp[maxCountIdx1][maxCountIdx2])
//let filteringDP = dp[items - 1].filter { $0.itemCount == maxCount }.sorted(by: { $0.money > $1.money })
//print(filteringDP)
////print(maxMoney - filteringDP[0].money)
//
//func conditionCheck1() -> Bool {
//    if let intItem = Int(data[0]) {
//        if intItem < 1 || intItem > 20 {
//            return false
//        } else {
//            if let intMoney = Int(data[1]) {
//                if intMoney <= 0 || intMoney > 5000 {
//                    return false
//                } else {
//                    items = intItem
//                    maxMoney = intMoney
//                }
//            }
//        }
//    } else {
//        return false
//    }
//
//    return true
//}
//
//func conditionCheck2(_ check: String, _ mutate: inout Int) -> Bool {
//    if let intCheck = Int(check) {
//        if intCheck <= 0 || intCheck > 5000 {
//            return false
//        } else {
//            mutate = intCheck
//        }
//    } else {
//        return false
//    }
//
//    return true
//}

//DFSを用いた方法
// 出力結果が１個間違ってる
// 🌈考察 >> DFSを用いると時間超過になると思い、DPで解いたが、DFSの方がより効率的だった
// 反例がなんだかわからない。。
typealias Result = (itemCount: Int, money: Int)
let data = readLine()!.split(separator: " ").map { String($0) }
var items = 0, maxMoney = 0
var itemArray = [Int]()
guard conditionCheck1() else {
    exit(0)
}

for _ in 0..<items {
    let itemData = readLine()!
    var intData = 0
    if !conditionCheck2(itemData, &intData) {
        exit(0)
    }

    itemArray.append(intData)
}

itemArray.sort()
var maxCount = 0
var visited = Array(repeating: false, count: items)
var resultArr = [(Int, Int)]()

for i in 0..<items {
    dfs_combination(0, 0, i + 1, 0)
}

print(maxMoney - resultArr.last!.1)

func dfs_combination(_ depth: Int, _ index: Int, _ count: Int, _ sum: Int) {
    if depth == count {
        if maxCount <= count {
            resultArr.append((count, sum))
        }
        maxCount = max(maxCount, count)
        return
    }
    
    for i in index..<items {
        if !visited[i] {
            if sum + itemArray[i] <= maxMoney {
                visited[i] = true
                dfs_combination(depth + 1, index + 1, count, sum + itemArray[i])
                visited[i] = false
            }
        }
    }
}

func conditionCheck1() -> Bool {
    if let intItem = Int(data[0]) {
        if intItem < 1 || intItem > 20 {
            return false
        } else {
            if let intMoney = Int(data[1]) {
                if intMoney <= 0 || intMoney > 5000 {
                    return false
                } else {
                    items = intItem
                    maxMoney = intMoney
                }
            } else {
                return false
            }
        }
    } else {
        return false
    }
    
    return true
}

func conditionCheck2(_ check: String, _ mutate: inout Int) -> Bool {
    if let intCheck = Int(check) {
        if intCheck <= 0 || intCheck > 5000 {
            return false
        } else {
            mutate = intCheck
        }
    } else {
        return false
    }
    
    return true
}
