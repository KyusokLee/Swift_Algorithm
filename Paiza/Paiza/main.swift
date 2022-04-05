//
//  main.swift
//  Paiza
//
//  Created by Kyus'lee on 2022/02/16.
//

import Foundation


////⚠️Paizaの問題を解くときに注意すること：　＞＞　paizaでは、条件の設定が厳しいため、ちゃんと問題文の条件のみが入力されるように自分で設計しなければいけない‼️
////ライブスケジュール問題 Rank.C
//
//let bandA_live = Int(readLine()!)!
//var live_schedule = Array(repeating: Array(repeating: "x", count: 2), count: 31)
//var index = 0
//
//for _ in 0..<bandA_live {
//    let liveA_day = Int(readLine()!)!
//    live_schedule[liveA_day - 1][0] = "A"
//}
//
//let bandB_live = Int(readLine()!)!
//for _ in 0..<bandB_live {
//    let liveB_day = Int(readLine()!)!
//    live_schedule[liveB_day - 1][1] = "B"
//}
//
//for day in live_schedule {
//    if day == ["A", "B"] {
//        if day[index] == "A" {
//            print(day[index])
//            index = 1
//        } else if day[index] == "B" {
//            print(day[index])
//            index = 0
//        }
//    } else if day == ["A", "x"] {
//        print(day[0])
//    } else if day == ["x", "B"] {
//        print(day[1])
//    } else {
//        print("x")
//    }
//}
//
////カラオケ大会 Rank.B
//let data = readLine()!.split(separator: " ").map { Int(String($0))! }
//var point_array = Array(repeating: Array(repeating: 0, count: data[1]), count: data[0])
//var standard_array = [Int]()
//var max_score = 0
//
//
//for _ in 0..<data[1] {
//    standard_array += [Int(readLine()!)!]
//}
//
//for i in 0..<data[0] {
//    for j in 0..<data[1] {
//        point_array[i][j] = Int(readLine()!)!
//    }
//}
//
//for i in point_array {
//    grading(i)
//}
//
//print(max_score)
//
//func grading(_ points: [Int]) {
//    var max_compare = 100
//
//    for i in 0..<points.count {
//        if abs(points[i] - standard_array[i]) <= 5 {
//            continue
//        } else if 5 < abs(points[i] - standard_array[i]) && abs(points[i] - standard_array[i]) <= 10 {
//            max_compare -= 1
//        } else if 10 < abs(points[i] - standard_array[i]) && abs(points[i] - standard_array[i]) <= 20 {
//            max_compare -= 2
//        } else if 20 < abs(points[i] - standard_array[i]) && abs(points[i] - standard_array[i]) <= 30 {
//            max_compare -= 3
//        } else if 30 < abs(points[i] - standard_array[i]) {
//            max_compare -= 5
//        }
//    }
//
//    if max_score < max_compare {
//        max_score = max_compare
//    }
//}

////楽しい暗号解読 rank.B
////カフェが閉まったため、時間内に解けなかった...
//let data = Array(readLine()!.split(separator: " ").map { String($0) })
//var check = [Character]()
//
//guard conditionCheck() else {
//    exit(0)
//}
//
//let testNum = Int(data[0])!, sentence = Array(data[1])
//var alphabet_Array = [Character]()
//
//for i in Character("a").asciiValue!...Character("z").asciiValue! {
//    let alphabet = Character(UnicodeScalar(i))
//    alphabet_Array.append(alphabet)
//}
//
//let fullString = readLine()!
//var compare = fullString.split(separator: " ").map { String($0) }
//let compare_firstOne = Array(compare[0])[0]
//
//if fullString.count < 1 || fullString.count > 1000 ||  compare_firstOne == " " {
//    exit(0)
//}
//
//for _ in 0..<testNum {
//    for i in 0..<compare.count {
//        if !compareCheck(compare[i]) {
//            exit(0)
//        }
//
//        compare[i] = changing(compare[i])
//    }
//}
//
//print(compare.joined(separator: " "))
//
//func conditionCheck() -> Bool {
//    let noPossible = true
//
//    if Int(data[0])! < 0 || Int(data[0])! > 100 {
//        return false
//    }
//
//    if data[1].count != 26 {
//        return false
//    }
//
//    for i in data[1] {
//        if !check.contains(i) {
//            check.append(i)
//        } else {
//            return false
//        }
//    }
//
//    return noPossible
//}
//
//func compareCheck(_ str: String) -> Bool {
//    let noPossible = true
//
//    for i in str {
//        if i != " " && !alphabet_Array.contains(i) {
//            return false
//        }
//    }
//
//    return noPossible
//}
//
//func changing(_ str: String) -> String {
//    let toChange = Array(str)
//    var newString = ""
//    var index = 0
//
//    for i in 0..<toChange.count {
//        if sentence.contains(toChange[i]) {
//            index = sentence.firstIndex(of: toChange[i])!
//            newString += String(alphabet_Array[index])
//        }
//    }
//
//    return newString
//}

//お菓子の詰め合わせ rank.A
// 出力結果が間違っているところがあったコード
// 単純にお釣りが最小になるときを選ぶのではなく、itemの個数がmaxになることを優先する必要があった
//⚠️まだ、途中の段階!!!

typealias Result = (itemCount: Int, money: Int)
let data = readLine()!.split(separator: " ").map { String($0) }
var items = 0, maxMoney = 0
var itemArray = [Int]()
guard conditionCheck1() else {
    exit(0)
}

var result = maxMoney
var dp = [[Result]](repeating: [Result](repeating: (0, 0), count: maxMoney + 1), count: items)

for _ in 0..<items {
    let itemData = readLine()!
    var intData = 0
    if !conditionCheck2(itemData, &intData) {
        exit(0)
    }

    itemArray.append(intData)
}

var maxCount = 0

for i in 0..<items {
    for j in 1..<maxMoney + 1 {
        if i == 0 {
            if j >= itemArray[i] {
                dp[i][j] = (1, itemArray[i])
            }
        } else {
            if j < itemArray[i] {
                dp[i][j] = dp[i - 1][j]
            } else {
                if dp[i - 1][j].money + itemArray[i] >= j {
                    dp[i][j] = (dp[i - 1][j].itemCount, max(dp[i - 1][j].money, itemArray[i] + dp[i - 1][j - itemArray[i]].money))
                    maxCount = max(maxCount, dp[i][j].itemCount)
                } else {
                    dp[i][j] = (dp[i - 1][j].itemCount + 1, max(dp[i - 1][j].money, itemArray[i] + dp[i - 1][j - itemArray[i]].money))
                    maxCount = max(maxCount, dp[i][j].itemCount)
                }
            }
        }
    }
}
print(dp)
let filteringDP = dp[items - 1].filter { $0.itemCount == maxCount }.sorted(by: { $0.money > $1.money })
if filteringDP.count == 1 {
    print(maxMoney - filteringDP[0].money)
} else {
    print(maxMoney - dp[items - 1][maxMoney].money)
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
