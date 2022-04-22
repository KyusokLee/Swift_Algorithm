//
//  day60.swift
//  BaekJoon
//
//  Created by Kyus'lee on 2022/04/22.
//

import Foundation

//Day 60: BfS, DFS シリーズ(17)
//BaekJoon Algorithm Study n.5014 (StartLink) 重要度: 🎖🎖🎖🎖🎖🎖🎖🎖
let data = readLine()!.split(separator: " ").map { Int(String($0))! }
let buildingStairs = data[0], currentLocate = data[1], targetFloor = data[2]
let buttons = [data[3], -1 * data[4]] //Upbutton, Downbutoon

let result = bfs_Elevator()
print(result == -1 ? "use the stairs" : result)

func bfs_Elevator() -> Int {
    var visited = [Bool](repeating: false, count: buildingStairs + 1)
    var neededVisitQueue: [(floor: Int, buttonCount: Int)] = [(currentLocate, 0) ]
    var index = 0
    visited[currentLocate] = true

    while index < neededVisitQueue.count {
        let (currentFloor,  count) = neededVisitQueue[index]

        if currentFloor == targetFloor {
            return count
        }

        for i in buttons {
            let nextFloor = currentFloor + i

            if nextFloor <= 0 || nextFloor > buildingStairs || visited[nextFloor] {
                continue
            }
            visited[nextFloor] = true
            neededVisitQueue.append((nextFloor, count + 1))
        }

        index += 1
    }

    return -1
}

//関数の中で完結するようにしたコード
func solution_Elevator() {
    let data = readLine()!.split(separator: " ").map { Int(String($0))! }
    let floorLimited = data[0], currentFloor = data[1], targetFloor = data[2]
    let buttons = [data[3], -data[4]]

    let result = bfs_Elevator()
    print(result != -1 ? result: "use the stairs")

    func bfs_Elevator() -> Int {
        var visited = [Bool](repeating: false, count: floorLimited + 1)
        var neededVisitQueue = [(currentFloor, 0)]
        var index = 0
        visited[currentFloor] = true

        while index < neededVisitQueue.count {
            let (currentLocate, buttonCount) = neededVisitQueue[index]

            if currentLocate == targetFloor {
                return buttonCount
            }

            for i in buttons {
                let nextFloor = currentLocate + i

                if nextFloor <= 0 || nextFloor > floorLimited || visited[nextFloor] {
                    continue
                }

                visited[nextFloor] = true
                neededVisitQueue.append((nextFloor, buttonCount + 1))
            }
            index += 1
        }
        return -1
    }
}
solution_Elevator()

//もっと効率的なコード
let data = readLine()!.split(separator: " ").map { Int(String($0))! }
let floorUpperBound = data[0], startFloor = data[1], targetFloor = data[2]
let buttons = [data[3], -data[4]]
var canArrive = false

bfs_Elevator()

func bfs_Elevator() {
    var visited = [Bool](repeating: false, count: 1000001)
    var neededVisitQueue = [(startFloor, 0)]
    var index = 0
    visited[startFloor] = true

    while index < neededVisitQueue.count {
        let (currentFloor, buttonCount) = neededVisitQueue[index]

        if currentFloor == targetFloor {
            canArrive = true
            print(buttonCount)
            break
        }

        for i in buttons {
            let nextFloor = currentFloor + i

            if nextFloor <= 0 || nextFloor > floorUpperBound || visited[nextFloor] {
                continue
            }

            visited[nextFloor] = true
            neededVisitQueue.append((nextFloor, buttonCount + 1))
        }
        index += 1
    }

    if !canArrive {
        print("use the stairs")
    }
}

//BaekJoon Algorithm Study n.2589 (宝島) 重要度: 🎖🎖🎖🎖🎖🎖🎖🎖
// Brute Force + BFS Algorithm
//🌈考察: 全域変数(グローバル変数)を用いて毎回resultの値を更新するより、関数の中で完結するようにするのがメモリ量と処理時間両方とも効率的だった

let data = readLine()!.split(separator: " ").map { Int(String($0))! }
let rowSize = data[0], columnSize = data[1]
var map = [[Character]]()
let directionMove = [(0, 1), (0, -1), (1, 0), (-1, 0)] // 東西南北

//mapのデータを格納する
for _ in 0..<rowSize {
    map += [Array(readLine()!)]
}

print(settingStartPoint())

//全ての陸地(L)からstartする経路を探索し、bfs_TreasureIslance関数を呼び出して最長距離を探してreturnする
func settingStartPoint() -> Int {
    var result = 0
    for i in 0..<rowSize {
        for j in 0..<columnSize {
            // Lがあるところを完全探索する
            if map[i][j] == "L" {
                result = max(result, bfs_TreasureIsland(i, j))
            }
        }
    }
    
    return result
}

//BFSアルゴリズムを用いた最長距離探し
func bfs_TreasureIsland(_ rowStart: Int, _ columnStart: Int) -> Int {
    var neededVisitQueue = [(rowStart, columnStart)]
    var distance = Array(repeating: Array(repeating: -1, count: columnSize), count: rowSize) // それぞれの場所に着く時間を-1として初期化 , また、-1であることはまだ、訪問したことない場所であることを示す
    var index = 0
    var tempDistance = 0 //start地点に指定した場所から距離を測る
    distance[rowStart][columnStart] = 0
    
    while index < neededVisitQueue.count {
        let (currentRow, currentColumn) = neededVisitQueue[index]
        
        for i in 0..<4 {
            let (nextRow, nextColumn) = (currentRow + directionMove[i].0, currentColumn + directionMove[i].1)
            
            if nextRow < 0 || nextRow >= rowSize || nextColumn < 0 || nextColumn >= columnSize {
                continue
            }
            
            if distance[nextRow][nextColumn] != -1 || map[nextRow][nextColumn] == "W" {
                continue
            }
            
            neededVisitQueue.append((nextRow, nextColumn))
            distance[nextRow][nextColumn] = distance[currentRow][currentColumn] + 1
            tempDistance = max(tempDistance, distance[nextRow][nextColumn]) //距離が最大となるように更新
        }
        index += 1
    }
    
    return tempDistance
}
