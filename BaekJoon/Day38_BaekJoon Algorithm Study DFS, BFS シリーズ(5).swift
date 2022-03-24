//
//  Day38.swift
//  BaekJoon
//
//  Created by Kyus'lee on 2022/03/24.
//

import Foundation


// Day38: DFS、BFS シリーズ (5)

//BaekJoon Algorithm Study n.7569 (トマト)　重要度:🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖
//⚠️‼️３次元BFS　覚えておくこと

let data = readLine()!.split(separator: " ").map { Int(String($0))! }
let columnSize = data[0], rowSize = data[1], heightSize = data[2]
var field = [[[Int]]](repeating: [[Int]](repeating: [Int](), count: rowSize), count: heightSize)
let directionMove: [(height: Int, row: Int, column: Int)] = [(1, 0, 0), (-1, 0, 0), (0, 0, 1), (0, 0, -1), (0, 1, 0), (0, -1, 0)] //上下東西南北
var result = 0
var neededCheckQueue: [(height: Int, row: Int, column: Int, day: Int)] = []

for i in 0..<heightSize {
    for j in 0..<rowSize {
        let rowData = readLine()!.split(separator: " ").map { Int(String($0))! }
        field[i][j].append(contentsOf: rowData)
    }
}

for z in 0..<heightSize {
    for y in 0..<rowSize {
        for x in 0..<columnSize {
            if field[z][y][x] == 1 {
                neededCheckQueue.append((z, y, x, 0))
            }
        }
    }
}

bfs_CountingRipeningData()
var isPossible = true

loop: for z in 0..<heightSize {
    for y in 0..<rowSize {
        for x in 0..<columnSize {
            if field[z][y][x] == 0 {
                isPossible = false
                break loop
            }
        }
    }
}

if !isPossible {
    print(-1)
} else {
    print(result)
}

func bfs_CountingRipeningData() {
    var index = 0
    var resultDay = 0

    while index < neededCheckQueue.count {
        let (currentHeight, currentRow, currentColumn, dayCount) = neededCheckQueue[index]
        resultDay = dayCount

        for i in 0..<6 {
            let nextHeight = currentHeight + directionMove[i].height
            let nextRow = currentRow + directionMove[i].row
            let nextColumn = currentColumn + directionMove[i].column

            if nextHeight < 0 || nextHeight >= heightSize || nextRow < 0 || nextRow >= rowSize || nextColumn < 0 || nextColumn >= columnSize {
                continue
            }

            if field[nextHeight][nextRow][nextColumn] == 0 {
                field[nextHeight][nextRow][nextColumn] = 1
                neededCheckQueue.append((nextHeight, nextRow, nextColumn, dayCount + 1))
            }

        }
        index += 1
    }
    result = resultDay
}

//BaekJoon Algorithm Study n.1707 (二分グラフ) 重要度: 🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖
// 二分グラフの説明: 隣接するノード（頂点）同士が異なった色で塗れるようにし、全ての頂点を二つの色で塗ることができるグラフ
// つまり、隣接しているノード（辺で繋がっているノード）はお互い異なる色を持たなければならない
// 🔥Hard! 必ず、復習すること

let testCase = Int(readLine()!)!

for _ in 0..<testCase {
    if bipartiteGraph() {
        print("YES")
    } else {
        print("NO")
    }
}

func bipartiteGraph() -> Bool {
    var isPossible = true
    let data = readLine()!.split(separator: " ").map { Int(String($0))! }
    let nodes = data[0], edges = data[1]
    var edgeData = Array(repeating: [Int](), count: nodes)
    var visited = Array(repeating: 0, count: nodes) //初期値を0にしておいて、まだ訪問してないことを表す

    for _ in 0..<edges {
        let putEdge = readLine()!.split(separator: " ").map { Int(String($0))! }
        let node1 = putEdge[0] - 1, node2 = putEdge[1] - 1
        edgeData[node1].append(node2)
        edgeData[node2].append(node1) //問題文で重複の辺を与えることはないと設定されているため、重複か否かを判別する条件文を省略した
    }

    for i in 0..<nodes {
        if isPossible == false {
            break
        }

        //　そのノードに訪問したなら、continueする
        if visited[i] != 0 {
            continue
        }

        var neededCheckQueue = [i], index = 0
        visited[i] = 1  // 1 -> Red , -1 -> Black

    loop: while index < neededCheckQueue.count {
            let nowNode = neededCheckQueue[index]

            for next in edgeData[nowNode] {
                if visited[next] == 0 {
                    visited[next] = visited[nowNode] * -1
                    neededCheckQueue.append(next)
                } else if visited[next] == visited[nowNode] {
                    isPossible = false
                    break loop
                }
            }
        index += 1
        }
    }

    return isPossible
}

//BaekJoon Algorithm Study n.2146 (橋造り) 重要度: 🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖
// 🔥Very Hard🔥

let mapSize = Int(readLine()!)!
var map = [[Int]]()
let directionMove: [(row: Int, column: Int)] = [(0, 1), (0, -1), (1, 0), (-1, 0)] //東西南北
var bridgeDistance = 98765432, islandNum = 0
var visited = Array(repeating: Array(repeating: false, count: mapSize), count: mapSize)

for _ in 0..<mapSize {
    map += [readLine()!.split(separator: " ").map { Int(String($0))! }]
}

//dfsを用いて、島ごとに番号づけを行う
for i in 0..<mapSize {
    for j in 0..<mapSize {
        if map[i][j] == 1 && !visited[i][j] {
            islandNum += 1
            dfs_islandCount(i, j, islandNum)
        }
    }
}

//ここのどこかで間違ってる気がする
for i in 1...islandNum {
    for j in 0..<mapSize {
        for k in 0..<mapSize {
            if map[j][k] == i {
                for t in 0..<4 {
                    let nextRow = j + directionMove[t].row
                    let nextColumn = k + directionMove[t].column

                    if nextRow < 0 || nextRow >= mapSize || nextColumn < 0 || nextColumn >= mapSize || map[nextRow][nextColumn] != 0 {
                        continue
                    }

                    if map[nextRow][nextColumn] == 0 && !visited[nextRow][nextColumn] {
                        visited[nextRow][nextColumn] = true
                        let tempDistance = bfs_MakingBridge(nextRow, nextColumn, i)
                        bridgeDistance = min(bridgeDistance, tempDistance)
                    }
                }
            }
        }
    }
}

print(bridgeDistance)

func dfs_islandCount(_ rowStart: Int, _ columnStart: Int, _ islandNumber: Int) {
    visited[rowStart][columnStart] = true
    if map[rowStart][columnStart] != islandNumber {
        map[rowStart][columnStart] = islandNumber
    }

    for i in 0..<4 {
        let nextRow = rowStart + directionMove[i].row
        let nextColumn = columnStart + directionMove[i].column

        if nextRow < 0 || nextRow >= mapSize || nextColumn < 0 || nextColumn >= mapSize {
            continue
        }

        if !visited[nextRow][nextColumn] && map[nextRow][nextColumn] == 1 {
            dfs_islandCount(nextRow, nextColumn, islandNumber)
        }
    }
}

func bfs_MakingBridge(_ rowStart: Int, _ columnStart: Int, _ fromIslandNum: Int) -> Int {
    let tempCountDist = 98765432
    var neededCheckQueue = [(rowStart, columnStart, 1)]
    var index = 0
    var tempVisited = Array(repeating: Array(repeating: false, count: mapSize), count: mapSize)
    tempVisited[rowStart][columnStart] = true

    while index < neededCheckQueue.count {
        let (currentRow, currentColumn, bridgeCount) = neededCheckQueue[index]

        if map[currentRow][currentColumn] != 0 && map[currentRow][currentColumn] != fromIslandNum {
            return bridgeCount - 1
        }

        for i in 0..<4 {
            let nextRow = currentRow + directionMove[i].row
            let nextColumn = currentColumn + directionMove[i].column

            if nextRow < 0 || nextRow >= mapSize || nextColumn < 0 || nextColumn >= mapSize {
                continue
            }

            if map[nextRow][nextColumn] != fromIslandNum && !tempVisited[nextRow][nextColumn] {
                tempVisited[nextRow][nextColumn] = true
                neededCheckQueue.append((nextRow, nextColumn, bridgeCount + 1))
            }
        }
        index += 1
    }

    return tempCountDist
}

//BaekJoon Algorithm Study n.3055 (脱出) 重要度: 🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖
// 🔥Very Hard!!🔥
//　⚠️途中の段階⚠️

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
    visited[rowStart][columnStart] = true
    
    while index < neededCheckQueue.count {
        let (currentRow, currentColumn, minuteCount) = neededCheckQueue[index]
        
        if (currentRow, currentColumn) == beaverHouse {
            result = minuteCount
            isPossible = true
            break
        }
        
        waterMove(&waterLocate)
        
        for i in 0..<4 {
            let nextRow = currentRow + directionRow[i]
            let nextColumn = currentColumn + directionColumn[i]
            
            if nextRow < 0 || nextRow >= rowSize || nextColumn < 0 || nextColumn >= columnSize || map[nextRow][nextColumn] == "*" || map[nextRow][nextColumn] == "X" {
                continue
            }
            
            if (map[nextRow][nextColumn] == "." && !visited[nextRow][nextColumn]) || map[nextRow][nextColumn] == "D" {
                visited[nextRow][nextColumn] = true
                neededCheckQueue.append((nextRow, nextColumn, minuteCount + 1))
            }
        }
        index += 1
    }
    
    return isPossible
}

func waterMove(_ hasWater: inout [(row: Int, column: Int, minuteCount: Int)]) {
    var currentWaterFlow: [(row: Int, column: Int, minuteCount: Int)] = hasWater
    var newWaterFlow: [(row: Int, column: Int, minuteCount: Int)] = []
    
    while !currentWaterFlow.isEmpty {
        let removeOne = currentWaterFlow.removeFirst()
        
        for i in 0..<4 {
            let nextRow = removeOne.row + directionRow[i]
            let nextColumn = removeOne.column + directionColumn[i]
            
            if nextRow < 0 || nextRow >= rowSize || nextColumn < 0 || nextColumn >= columnSize || map[nextRow][nextColumn] == "X" {
                continue
            }
            
            if map[nextRow][nextColumn] == "." || map[nextRow][nextColumn] == "D" {
                map[nextRow][nextColumn] = "*"
                newWaterFlow.append((nextRow, nextColumn, removeOne.minuteCount + 1))
            }
        }
    }
    
    hasWater = newWaterFlow
}

//　⚠️‼️ enumerated と　filter　と　mapを用いてindexを求める方法
var testArray = ["*", "S", "D", "*"]
let x = testArray.enumerated().filter {$0.1 == "*" }.map { $0.0 }
print(x)
