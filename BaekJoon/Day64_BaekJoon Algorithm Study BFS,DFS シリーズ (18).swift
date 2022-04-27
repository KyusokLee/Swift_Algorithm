//
//  Day64.swift
//  BaekJoon
//
//  Created by Kyus'lee on 2022/04/27.
//

import Foundation

//Day64 BFS,DFS シリーズ (18)
//BaekJoon n.1325 (効率的なハッキング)
//🎖DFS,BFS
// 時間超過になったコード
//swiftの言語では、この問題が指定した処理時間内に解くことができなかった --> この問題をswiftで解いた人がいない)
let data = readLine()!.split(separator: " ").map { Int(String($0))! }
let nodes = data[0], relationCounts = data[1]
var believeRelations = Array(repeating: [Int](), count: nodes + 1) //indexに格納された値らがそのindexのcomputerを信じるってことを意味
var canHackMaxNumber = ""
var maxCount = 0
var visited = Array(repeating: false, count: nodes + 1)

for _ in 0..<relationCounts {
    let believeData = readLine()!.split(separator: " ").map { Int(String($0))! }
    believeRelations[believeData[1]].append(believeData[0])
}

for i in 1...nodes {
    if !visited[i] {
        let findTarget = dfs_HackingEffective(i)
        if maxCount <= findTarget {
            maxCount = findTarget
            canHackMaxNumber += "\(i) "
        }
        visited[i] = false
    }
}

canHackMaxNumber.removeLast()
print(canHackMaxNumber)

func dfs_HackingEffective(_ findIdx: Int) -> Int {
    visited[findIdx] = true
    let nextCandidate = believeRelations[findIdx]
    var tempCount = believeRelations.count

    for i in nextCandidate {
        if !visited[i] {
            tempCount += dfs_HackingEffective(i)
            visited[i] = false
        }
    }

    return tempCount
}

//BaekJoon Algorithm Study n.2638 (チーズ)　重要度: 🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖
// チーズ内部に空気と接しない空間があるかどうかの探索と処理が大事である
let mapSize = readLine()!.split(separator: " ").map { Int(String($0))! }
let rowSize = mapSize[0], columnSize = mapSize[1]
let directionMove = [(0, 1), (0, -1), (1, 0), (-1, 0)] //東西南北
var map = [[Int]]()
var outerAir = Array(repeating: Array(repeating: false, count: columnSize), count: rowSize)
var cheeseList = [(Int, Int)]()
var minHour = 0

//データの格納
for i in 0..<rowSize {
    let putData = readLine()!.split(separator: " ").map { Int(String($0))! }
    for j in 0..<columnSize {
        if putData[j] == 1 {
            cheeseList.append((i, j))
        }
    }
    map.append(putData)
}

while true {
    minHour += 1
    bfs_findingOuterSpace()
    meltingCheese()
    if cheeseList.isEmpty {
        break
    }
}
print(minHour)

//外の空間の探し == (チーズに囲まれている空間を除いた0が格納されているマスの探し)
func bfs_findingOuterSpace() {
    outerAir = Array(repeating: Array(repeating: false, count: columnSize), count: rowSize)
    outerAir[0][0] = true
    var neededVisitQueue = [(0, 0)]
    var index = 0

    while index < neededVisitQueue.count {
        let (currentRow, currentColumn) = neededVisitQueue[index]

        for i in 0..<4 {
            let (nextRow, nextColumn) = (currentRow + directionMove[i].0, currentColumn + directionMove[i].1)

            if nextRow < 0 || nextRow >= rowSize || nextColumn < 0 || nextColumn >= columnSize || map[nextRow][nextColumn] != 0 || outerAir[nextRow][nextColumn] {
                continue
            }

            outerAir[nextRow][nextColumn] = true
            neededVisitQueue.append((nextRow, nextColumn))
        }
        index += 1
    }
}

// mapの端にチーズが入力されないことが問題の設定だったので、配列のindex of out rangeを考慮しない。
// 外の空間と２マス接触してるマスを消し、新しいcheeseListの生成
func meltingCheese() {
    let tempCheeseList = cheeseList
    cheeseList.removeAll()

    for (row, column) in tempCheeseList {
        var connectedToOuter = 0 // 外の空間と何個接しているかを表す変数
        for i in 0..<4 {
            let (nextRow, nextColumn) = (row + directionMove[i].0, column + directionMove[i].1)

            if outerAir[nextRow][nextColumn] {
                connectedToOuter += 1
            }

            if connectedToOuter >= 2 {
                map[row][column] = 0
                break
            }
        }

        if connectedToOuter < 2 {
            cheeseList.append((row, column))
        }
    }
}

// 時間超過になったコード
let putSize = readLine()!.split(separator: " ").map { Int(String($0))! }
let rowSize = putSize[0], columnSize = putSize[1]
let directionMove = [(0, 1), (0, -1), (1, 0), (-1, 0)] //東西南北
var visited = Array(repeating: Array(repeating: false, count: columnSize), count: rowSize)
var outerSpace = Array(repeating: Array(repeating: false, count: columnSize), count: rowSize)
var map = [[Int]]()
var cheeseList = [(Int, Int)]()
var minTime = 0

for i in 0..<rowSize {
    let putCheese = readLine()!.split(separator: " ").map { Int(String($0))! }
    for j in 0..<columnSize {
        if putCheese[j] == 1 {
            cheeseList.append((i, j))
        }
    }
    map += [putCheese]
}

bfs_outSpaceCheck()
while true {
    minTime += 1
    removeCheese()
    if cheeseList.isEmpty {
        break
    }
}
print(minTime)

func bfs_outSpaceCheck() {
    outerSpace[0][0] = true
    visited[0][0] = true
    var neededVisitQueue = [(0, 0)]
    var index = 0

    while index < neededVisitQueue.count {
        let (curRow, curColumn) = neededVisitQueue[index]

        for nextMove in directionMove {
            let (nextRow, nextColumn) = (curRow + nextMove.0, curColumn + nextMove.1)

            if nextRow < 0 || nextRow >= rowSize || nextColumn < 0 || nextColumn >= columnSize || visited[nextRow][nextColumn] || map[nextRow][nextColumn] != 0 {
                continue
            }

            visited[nextRow][nextColumn] = true
            neededVisitQueue.append((nextRow, nextColumn))
            outerSpace[nextRow][nextColumn] = true
        }

        index += 1
    }
}

func removeCheese() {
    var tempCheeseList = cheeseList
    var updateOuterSpace = [(Int, Int)]()

    for (curRow, curColumn) in cheeseList {
        var connectedCount = 0
        for nextMove in directionMove {
            let (nextRow, nextColumn) = (curRow + nextMove.0, curColumn + nextMove.1)

            if outerSpace[nextRow][nextColumn] {
                connectedCount += 1
            }

            if connectedCount == 2 {
                tempCheeseList.removeAll(where: { ($0, $1) == (curRow, curColumn)} )
                map[curRow][curColumn] = 0
                updateOuterSpace.append((curRow, curColumn))
                break
            }
        }
    }

    updateOuterSpace.forEach {
        outerSpace[$0.0][$0.1] = true
    }

    cheeseList = tempCheeseList
}

// 処理時間が効率的なコード
let putSize = readLine()!.split(separator: " ").map { Int(String($0))! }
let rowSize = putSize[0], columnSize = putSize[1]
let directionMove = [(0, 1), (0, -1), (1, 0), (-1, 0)] //東西南北
var map = [[Int]]()
var cheeseList = [(Int, Int)]()
var minTime = 0

for i in 0..<rowSize {
    let putCheese = readLine()!.split(separator: " ").map { Int(String($0))! }
    for j in 0..<columnSize {
        if putCheese[j] == 1 {
            cheeseList.append((i, j))
        }
    }
    map += [putCheese]
}

while true {
    minTime += 1
    bfs_outSpaceCheck()
    if cheeseList.isEmpty {
        break
    }
}
print(minTime)

func bfs_outSpaceCheck() {
    // mapの端にチーズが入力されないことが問題の設定だったので、配列のindex of out rangeを考慮しない。
    // そのため、 row: 0, column: 0 から探索を始める
    // outerSpaceは、訪問したかの真偽を保存する配列であると同時にTrueになっているマスが外の空間であることを意味する
    var outerSpace = Array(repeating: Array(repeating: false, count: columnSize), count: rowSize)
    var neededVisitQueue = [(0, 0)]
    var index = 0
    outerSpace[0][0] = true
    
    while index < neededVisitQueue.count {
        let (curRow, curColumn) = neededVisitQueue[index]
        
        for nextMove in directionMove {
            let (nextRow, nextColumn) = (curRow + nextMove.0, curColumn + nextMove.1)
            
            if nextRow < 0 || nextRow >= rowSize || nextColumn < 0 || nextColumn >= columnSize || outerSpace[nextRow][nextColumn] || map[nextRow][nextColumn] != 0 {
                continue
            }
            
            outerSpace[nextRow][nextColumn] = true
            neededVisitQueue.append((nextRow, nextColumn))
        }
        
        index += 1
    }
    
    removeCheese(&outerSpace)
}

func removeCheese(_ visitedCheck: inout [[Bool]]) {
    let tempCheeseList = cheeseList
    cheeseList.removeAll() //cheeseのListを全部決して、新しく更新していく仕組み
    
    for (curRow, curColumn) in tempCheeseList {
        var connectedCount = 0
        for nextMove in directionMove {
            let (nextRow, nextColumn) = (curRow + nextMove.0, curColumn + nextMove.1)
            
            if visitedCheck[nextRow][nextColumn] {
                connectedCount += 1
            }
            
            if connectedCount == 2 {
                map[curRow][curColumn] = 0
                break
            }
        }
        
        if connectedCount < 2 {
            cheeseList.append((curRow, curColumn))
        }
    }
}
