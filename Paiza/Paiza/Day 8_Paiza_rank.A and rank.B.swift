//
//  Day 8_Paiza_rank.A.swift
//  Paiza
//
//  Created by Kyus'lee on 2022/03/16.
//

import Foundation


//Day8 rank.A と　rank.B　１問ずつ

//試験の作成 rank.A
// 📝Dynamic + DFSのとてもいい問題  重要度: 🎖🎖🎖🎖🎖🎖🎖

//タイムオーバーになってしまったコード
let data = readLine()!
var N = 0
var pointSum = 0
var pointArr = [Int]()
var resultArray = [Int]()
resultArray.append(0)

if !N_check(data, &N) {
    exit(0)
}

for _ in 0..<N {
    let Quiz_point = readLine()!
    var intPoint = 0
    if !N_check(Quiz_point, &intPoint) {
        exit(0)
    }

    pointSum += intPoint

    guard pointSum <= 100 else {
        exit(0)
    }

    pointArr.append(intPoint)
}

var visited = [Bool](repeating: false, count: N)
dfs_select(0, 0)

var sortedArray = resultArray.sorted(by: <)

print(sortedArray.count)
while !sortedArray.isEmpty {
    print(sortedArray.removeFirst())
}

func dfs_select(_ depthCount: Int, _ point: Int) {
    if depthCount == N {
        if !resultArray.contains(point) {
            resultArray.append(point)
        }
        return
    }

    for i in 0..<pointArr.count {
        let addPoint = pointArr[i]
        if !visited[i] {
            visited[i] = true
            dfs_select(depthCount + 1, point + addPoint)
            if !resultArray.contains(point) {
                resultArray.append(point)
            }
            visited[i] = false
        }
    }
}

func N_check(_ str: String, _ change: inout Int) -> Bool {
    let isPossible = true

    if let intN = Int(str) {
        change = intN
        if change < 1 || change > 100 {
            return false
        }
    } else {
        return false
    }

    return isPossible
}

//方法２: さっきよりは、時間オーバーになるケースが減ったが、まだ時間オーバーになってしまう
let data = readLine()!
var N = 0
var pointSum = 0
var pointArr = [Int]()
var resultArray = [Int]()
resultArray.append(0)

if !N_check(data, &N) {
    exit(0)
}

for _ in 0..<N {
    let Quiz_point = readLine()!
    var intPoint = 0
    if !N_check(Quiz_point, &intPoint) {
        exit(0)
    }

    pointSum += intPoint

    guard pointSum <= 100 else {
        exit(0)
    }

    pointArr.append(intPoint)
}

var visited = [Bool](repeating: false, count: N)

for i in 1...N {
    dfs_select(0, 0, 0, i)
}

var sortedArray = resultArray.sorted(by: <)
print(sortedArray.count)

while !sortedArray.isEmpty {
    print(sortedArray.removeFirst())
}

func dfs_select(_ depthCount: Int, _ index: Int, _ point: Int, _ select: Int) {
    if depthCount == select {
        if !resultArray.contains(point) {
            resultArray.append(point)
        }
        return
    }

    for i in index..<pointArr.count {
        let addPoint = pointArr[i]
        if !visited[i] {
            visited[i] = true
            dfs_select(depthCount + 1, i + 1, point + addPoint, select)
            visited[i] = false
        }
    }
}

func N_check(_ str: String, _ change: inout Int) -> Bool {
    let isPossible = true

    if let intN = Int(str) {
        change = intN
        if change < 1 || change > 100 {
            return false
        }
    } else {
        return false
    }

    return isPossible
}

//方法３:時間オーバーにならないコード (Dynamic Programmingのアルゴリズムが必要となる)
let data = readLine()!
var N = 0
if !N_check(data, &N) {
    exit(0)
}
var pointSum = 0
var pointArr = [Int]()
var resultArray = [Bool](repeating: false, count: 101)
resultArray[0] = true
var sum = 0

for _ in 0..<N {
    let Quiz_point = readLine()!
    var intPoint = 0
    if !N_check(Quiz_point, &intPoint) {
        exit(0)
    }

    pointSum += intPoint

    guard pointSum <= 100 else {
        exit(0)
    }

    pointArr.append(intPoint)
}

for i in pointArr {
    sum += i
    for j in stride(from: sum, through: 0, by: -1) {
        if resultArray[j] {
            resultArray[j + i] = true
        }
    }
}

let filterResult = resultArray.enumerated().filter { $1 }.map { $0.0 }
print(filterResult.count)
for i in filterResult {
    print(i)
}

func N_check(_ str: String, _ change: inout Int) -> Bool {
    let isPossible = true

    if let intN = Int(str) {
        change = intN
        if change < 1 || change > 100 {
            return false
        }
    } else {
        return false
    }

    return isPossible
}


//compactMapは、nilでありそうな値をOptionalなしで除いて返すメッソドである
//Apple 公式辞書
let possibleNumbers = ["1", "2", "three", "///4///", "5"]

let mapped: [Int?] = possibleNumbers.map { str in Int(str) }
// [1, 2, nil, nil, 5]

let compactMapped: [Int] = possibleNumbers.compactMap { str in Int(str) }
// [1, 2, 5]

let filterResult = resultArray.enumerated().filter { $1 }
print(filterResult)
 //[(offset: 0, element: true), (offset: 6, element: true), (offset: 14, element: true), (offset: 20, element: true), (offset: 25, element: true), (offset: 31, element: true), (offset: 39, element: true), (offset: 45, element: true), (offset: 55, element: true), (offset: 61, element: true), (offset: 69, element: true), (offset: 75, element: true), (offset: 80, element: true), (offset: 86, element: true), (offset: 94, element: true), (offset: 100, element: true)]が出力される

//enumerated()　練習

let practice1 = [1, 3, 5, 7, 9]
let enum1 = practice1.enumerated()
print(enum1) // EnumeratedSequence<Array<Int>>(_ base: [1, 3, 5, 7, 9])が出力される
//enumerated()は、連続的な indexと、　そのindexに格納されている値をtupleの形で扱うメッソドである

//Apple 公式辞書によると、

// func enumerated() -> EnumeratedSequence<Array<Element>> (配列の形で表せるものの後ろに.をつけることで実現できる)

for (n, c) in "Swift".enumerated() {
    print("\(n): '\(c)'")
}
// Prints "0: 'S'"
// Prints "1: 'w'"
// Prints "2: 'i'"
// Prints "3: 'f'"
// Prints "4: 't'"

//ここで、nはindex、　cは要素を意味

//チャット記録 rank.B
// 直しても反例があるようだ。。 >> 問題をちゃんと読まなかった。。。。問題文のどこにも英語小文字だけだと書いていないのに、ずっと小文字だけやっていた。。。

// 🌈⚠️考察: 問題文をちゃんと読み、分析を徹底的にすること‼️ + 余計なコードを増やさないこと！‼️

let data = readLine()!.split(separator: " ").map { String($0) }
var members = 0, groups = 0, messages = 0

if data.count != 3 {
    exit(0)
}

if !dataCheck1(data[0], data[1], data[2]) {
    exit(0)
}

var groupArray = [[Int]]()
if groups > 0 {
    for _ in 0..<groups {
        let groupData = readLine()!.split(separator: " ").map { String($0) }
        var groupmembers = 0
        if !groupDataCheck(groupData[0], &groupmembers) {
            exit(0)
        }
        
        if groupData.count - 1 != groupmembers {
            exit(0)
        } else {
            var perGroup = [Int]()
            for i in 1..<groupData.count {
                if let intI = Int(groupData[i]) {
                    if intI < 1 || intI > members {
                        exit(0)
                    }
                    if !perGroup.contains(intI) {
                        perGroup.append(intI)
                    } else {
                        exit(0)
                    }
                }
            }
            groupArray += [perGroup]
        }
    }
}

var alphabet_Array = [Character]()

for i in Character("a").asciiValue!...Character("z").asciiValue! {
    let alphabet = Character(UnicodeScalar(i))
    alphabet_Array.append(alphabet)
}

for i in Character("A").asciiValue!...Character("Z").asciiValue! {
    let alphabet = Character(UnicodeScalar(i))
    alphabet_Array.append(alphabet)
}

let arabia_Array = Array(0...9).map { Character(String($0)) }

var members_windows = Array(repeating: [], count: members)
let enterKey = "--"
var memberNum_Send = 0, commander = 0, memberNum_Receive = 0, ismessage = ""

for _ in 0..<messages {
    let messageData = readLine()!.split(separator: " ").map { String($0) }
    if messageData.count != 4 {
        exit(0)
    }
    
    if !messageDataCheck(messageData[0], messageData[1], messageData[2], messageData[3]) {
        exit(0)
    }
    
    if commander == 0 {
        members_windows[memberNum_Send - 1].append(ismessage)
        members_windows[memberNum_Receive - 1].append(ismessage)
    } else if commander == 1 {
        for i in groupArray[memberNum_Receive - 1] {
            members_windows[i - 1].append(ismessage)
        }
    }
}

for i in 0..<members_windows.count {
    if members_windows[i].isEmpty {
        if i != members_windows.count - 1 {
            print()
            print(enterKey)
        } else {
            print()
        }
        continue
    } else {
        for j in members_windows[i] {
            print(j)
        }
        if i != members_windows.count - 1 {
            print(enterKey)
        }
    }
}

func dataCheck1(_ str1: String, _ str2: String, _ str3: String) -> Bool {
    let isPossible = true
    
    if let intStr1 = Int(str1) {
        if intStr1 < 1 || intStr1 > 100 {
            return false
        } else {
            members = intStr1
        }
        if let intStr2 = Int(str2) {
            if intStr2 < 0 || intStr2 > 100 {
                return false
            } else {
                groups = intStr2
            }
            if let intStr3 = Int(str3) {
                if intStr3 < 1 || intStr3 > 500 {
                    return false
                } else {
                    messages = intStr3
                }
            } else {
                return false
            }
        } else {
            return false
        }
    } else {
        return false
    }
    
    return isPossible
}

func groupDataCheck(_ str1: String, _ resultInt: inout Int) -> Bool {
    let isAvailable = true
    
    if let intStr1 = Int(str1) {
        if intStr1 < 1 || intStr1 > members {
            return false
        } else {
            resultInt = intStr1
        }
    } else {
        return false
    }
    
    return isAvailable
}

func messageDataCheck(_ str1: String, _ str2: String, _ str3: String, _ content: String) -> Bool {
    let isOkay = true
    
    if let intStr1 = Int(str1) {
        if intStr1 < 1 || intStr1 > members {
            return false
        } else {
            if let intStr2 = Int(str2) {
                if intStr2 != 0 && intStr2 != 1 {
                    return false
                } else {
                    if intStr2 == 0 {
                        if let intStr3 = Int(str3) {
                            if (1 <= intStr3 && intStr3 <= members) && (intStr1 != intStr3) {
                                for i in content {
                                    if !alphabet_Array.contains(i) && !arabia_Array.contains(i) {
                                        return false
                                    }
                                }
                                if content.count < 1 || content.count > 100 {
                                    return false
                                }
                                memberNum_Send = intStr1
                                commander = intStr2
                                memberNum_Receive = intStr3
                                ismessage = content
                            } else {
                                return false
                            }
                        } else {
                            return false
                        }
                        
                    } else if intStr2 == 1 {
                        if let intStr3_1 = Int(str3) {
                            if (1 <= intStr3_1 && intStr3_1 <= groups) && (groupArray[intStr3_1 - 1].contains(intStr1)) {
                                for i in content {
                                    if !alphabet_Array.contains(i) && !arabia_Array.contains(i) {
                                        return false
                                    }
                                }
                                if content.count < 1 || content.count > 100 {
                                    return false
                                }
                                memberNum_Send = intStr1
                                commander = intStr2
                                memberNum_Receive = intStr3_1
                                ismessage = content
                            } else {
                                return false
                            }
                        }
                    }
                }
            }
        }
    } else {
        return false
    }
    
    return isOkay
}
