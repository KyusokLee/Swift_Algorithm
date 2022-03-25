//
//  Day39.swift
//  BaekJoon
//
//  Created by Kyus'lee on 2022/03/25.
//

import Foundation


// Day39: DFS、BFS シリーズ (6)
//BaekJoon Algorithm Study n.3055 (脱出) 重要度: 🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖
// 🔥Very Hard!!🔥
//　⚠️途中の段階⚠️
// 最小になる時間は、求めることができたが、どの経路で到着したかはまだ、実現できなかった

let data = readLine()!.split(separator: " ").map { Int(String($0))! }
let rowSize = data[0], columnSize = data[1]
var map = [[Character]]()
var hedgehogLocate: (row: Int, column: Int, minuteCount: Int) = (-1, -1, -1)
var beaverHouse = (-1, -1)
var waterLocate: [(row: Int, column: Int, minuteCount: Int)] = []
var result = 2501
let directionRow = [0, 0, 1, -1]
let directionColumn = [1, -1, 0, 0]

for i in 0..<rowSize {
    let putData = Array(readLine()!)

    if let hedgehog = putData.firstIndex(of: "S") {
        hedgehogLocate = (i, hedgehog, 0)
    }
    if let beaver = putData.firstIndex(of: "D") {
        beaverHouse = (i, beaver)
    }
    if putData.contains("*") {
        let waterIdx = putData.enumerated().filter { $0.1 == "*" }.map { $0.0 }
        for j in waterIdx {
            waterLocate.append((i, j, 0))
        }
    }
    map += [putData]
}

if bfs_findBeaverHouse(hedgehogLocate.row, hedgehogLocate.column) {
    print(result)
} else {
    print("KAKTUS")
}

func bfs_findBeaverHouse(_ rowStart: Int, _ columnStart: Int) -> Bool {
    var isPossible = false
    var index = 0
    var visited = Array(repeating: Array(repeating: false, count: columnSize), count: rowSize)
    var neededCheckQueue = [(rowStart, columnStart, 0)]
    var waterMinute = 0
    visited[rowStart][columnStart] = true

    waterMove(&waterLocate, &waterMinute)

    while index < neededCheckQueue.count {
        let (currentRow, currentColumn, minuteCount) = neededCheckQueue[index]

        if (currentRow, currentColumn) == beaverHouse {
            result = minuteCount
            isPossible = true
            break
        }

        if minuteCount == waterMinute {
            waterMove(&waterLocate, &waterMinute)
        }

        for i in 0..<4 {
            let nextRow = currentRow + directionRow[i]
            let nextColumn = currentColumn + directionColumn[i]

            if nextRow < 0 || nextRow >= rowSize || nextColumn < 0 || nextColumn >= columnSize || map[nextRow][nextColumn] == "*" || map[nextRow][nextColumn] == "X" {
                continue
            }

            if (map[nextRow][nextColumn] == "." && !visited[nextRow][nextColumn]) || (map[nextRow][nextColumn] == "D" && !visited[nextRow][nextColumn]) {
                visited[nextRow][nextColumn] = true
                neededCheckQueue.append((nextRow, nextColumn, minuteCount + 1))
            }
        }
        index += 1
    }

    return isPossible
}

func waterMove(_ hasWater: inout [(row: Int, column: Int, minuteCount: Int)], _ minute: inout Int) {
    var currentWaterFlow: [(row: Int, column: Int, minuteCount: Int)] = hasWater
    var newWaterFlow: [(row: Int, column: Int, minuteCount: Int)] = []

    while !currentWaterFlow.isEmpty {
        let removeOne = currentWaterFlow.removeFirst()

        for i in 0..<4 {
            let nextRow = removeOne.row + directionRow[i]
            let nextColumn = removeOne.column + directionColumn[i]

            if nextRow < 0 || nextRow >= rowSize || nextColumn < 0 || nextColumn >= columnSize || map[nextRow][nextColumn] == "X" || map[nextRow][nextColumn] == "D" {
                continue
            }

            if map[nextRow][nextColumn] == "." || map[nextRow][nextColumn] == "S" {
                map[nextRow][nextColumn] = "*"
                newWaterFlow.append((nextRow, nextColumn, removeOne.minuteCount + 1))
            }
        }
    }

    hasWater = newWaterFlow
    minute += 1
}

//BaekJoon Algorithm Study n.9019 (DSLR) 重要度: 🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖
// 🔥Very Hard!‼️
// Xcode上では、ちゃんと動くけど、BaekJoon Testerでは、RunTime Error になったコード
func solution() {
    let commander = ["D", "S", "L", "R"]
    let testCase = Int(readLine()!)!

    for _ in 0..<testCase {
        var printResult = ""
        var index = 0
        var visited = Array(repeating: false, count: 10000)
        var neededCheckQueue: [(numA: Int, result: String)] = []
        let putData = readLine()!.split(separator: " ").map { Int(String($0))! }
        let A = putData[0], B = putData[1]
        neededCheckQueue.append((A, ""))

        while index < neededCheckQueue.count {
            let (currentNum, currentResult) = neededCheckQueue[index]
            if currentNum == B {
                printResult = currentResult
                break
            }

            for i in commander {
                switch i {
                case "D":
                    let nextNum = currentNum * 2 % 10000
                    if !visited[nextNum] {
                        visited[nextNum] = true
                        neededCheckQueue.append((nextNum, currentResult + "D"))
                    }
                case "S":
                    var nextNum = currentNum - 1
                    if nextNum == 0 {
                        nextNum = 9999
                    }
                    if !visited[nextNum] {
                        visited[nextNum] = true
                        neededCheckQueue.append((nextNum, currentResult + "S"))
                    }
                case "L":
                    let nextNum = (currentNum % 1000) * 10 + currentNum / 1000
                    if !visited[nextNum] {
                        visited[nextNum] = true
                        neededCheckQueue.append((nextNum, currentResult + "L"))
                    }
                case "R":
                    let nextNum = (currentNum % 10) * 1000 + currentNum / 10
                    if !visited[nextNum] {
                        visited[nextNum] = true
                        neededCheckQueue.append((nextNum, currentResult + "R"))
                    }
                default:
                    break
                }
            }
            index += 1
        }

        print(printResult)
    }
}

solution()

// 方法２: Intにして、結果をまたStringに変換するコード
// 1 = D, 2 = S, 3 = L, 4 = Rを返すように設定した
// 🌈📝 -- 考察 --
// 追加的にStringに結果を送り続けるより
// Intにして送る方が早かった

func solution() {
    let testCase = Int(readLine()!)!

    for _ in 0..<testCase {
        var printResult = ""
        var index = 0
        var visited = Array(repeating: false, count: 10000)
        var neededCheckQueue: [(Int, Int)] = []
        let putData = readLine()!.split(separator: " ").map { Int(String($0))! }
        let A = putData[0], B = putData[1]
        neededCheckQueue.append((A, 0))
        visited[A] = true

        while index < neededCheckQueue.count {
            let (currentNum, currentResult) = neededCheckQueue[index]
            if currentNum == B {
                for i in String(currentResult) {
                    switch i {
                    case "1":
                        printResult += "D"
                    case "2":
                        printResult += "S"
                    case "3":
                        printResult += "L"
                    case "4":
                        printResult += "R"
                    default:
                        break
                    }
                }
                break
            } else {
                let D = currentNum * 2 % 10000
                let S = currentNum == 0 ? 9999 : currentNum - 1
                let L = (currentNum % 1000) * 10 + currentNum / 1000
                let R = (currentNum % 10) * 1000 + currentNum / 10

                if !visited[D] {
                    visited[D] = true
                    neededCheckQueue.append((D, currentResult * 10 + 1))
                }

                if !visited[S] {
                    visited[S] = true
                    neededCheckQueue.append((S, currentResult * 10 + 2))
                }

                if !visited[L] {
                    visited[L] = true
                    neededCheckQueue.append((L, currentResult * 10 + 3))
                }

                if !visited[R] {
                    visited[R] = true
                    neededCheckQueue.append((R, currentResult * 10 + 4))
                }
            }
            index += 1
        }

        print(printResult)
    }
}

solution()

// ⭐️‼️必修問題: BFSを用いて、単純に最短の時間を表すだけではなく、経路も一緒に求める問題
//BaekJoon Algorithm Study n.13913 (かくれんぼ -(4)) 重要度: 🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖
// 🔥Very Very Hard‼️🔥
//順列アルゴリズムを用いることが可能でありそう！！
//⚠️途中の段階⚠️

var visited = Array(repeating: false, count: 100001)
var dp = Array(repeating: -1, count: 100001)
let data = readLine()!.split(separator: " ").map { Int(String($0))! }
let subin = data[0], sister = data[1]
var neededCheckQueue: [(locate: Int, time: Int)] = [(subin, 0)]
var result = 0, time = 0
visited[subin] = true
dp[subin] = 0

bfs_findingSister4()

var filterArray = dp.enumerated().filter { $0.1 != -1 && $0.1 < result }.map { ($0.1, $0.0) }.sorted(by: { $0.0 < $1.0 })
filterArray.append((result, sister))
while true {
    var routeArray = [Int]()
    
    if time == result && routeArray.last == sister {
        print(result)
        print(routeArray.map { String($0) }.joined(separator: " "))
        exit(0)
    }
    
    for i in 0...result {
        let choose = filterArray.filter {$0.0 == i}
        
        for j in choose {
            routeArray.append(j.1)
            
        }
        
        
    }
    
    
    
    
}


print(result)
print(filterArray)


func bfs_findingSister4() {
    var index = 0
    
    while index < neededCheckQueue.count {
        let (currentLocate, timeCount) = neededCheckQueue[index]
        
        if currentLocate == sister {
            result = timeCount
            break
//            var resultArray = [Int]()
//
//            for j in 0..<result {
//                var routeArray = [subin]
//                var moveLocate = subin
//
//                for k in []
//
//            }
        }
        
        
        for i in [currentLocate - 1, currentLocate + 1, currentLocate * 2] {
            if i < 0 || i >= 100000 {
                continue
            }
            
            if !visited[i] && dp[i] == -1 {
                visited[i] = true
                dp[i] = timeCount + 1
                neededCheckQueue.append((i, timeCount + 1))
            }
        }
        index += 1
    }
    
}
