//
//  Day 55.swift
//  BaekJoon
//
//  Created by Kyus'lee on 2022/04/14.
//

import Foundation

//Day55 DFS, BFS シリーズ(14)
//BaekJoon Algorithm Study n.1389 (Kebin-bacon'sの6段階法則) 重要度: 🎖🎖🎖🎖🎖🎖🎖
// Floyd-Wharshall (Greedy Algorithm の１つ)を用いた方法
//⚠️途中の段階
let data = readLine()!.split(separator: " ").map { Int(String($0))! }
let users = data[0], totalRelations = data[1]
let inf = 98765432
var relationNode = Array(repeating: Array(repeating: inf, count: users), count: users)
var result = (0, inf)

for _ in 0..<totalRelations {
    let putRelation = readLine()!.split(separator: " ").map { Int(String($0))! - 1 }
    if relationNode[putRelation[0]][putRelation[1]] != 1 {
        relationNode[putRelation[0]][putRelation[1]] = 1
        relationNode[putRelation[1]][putRelation[0]] = 1
    }
}

floydWharshall()
relationNode.forEach { person in
    let personSum = person.filter { $0 != inf }.reduce(0, +)
    if personSum < result.1 {
        result.1 = personSum
        result.0 = relationNode.firstIndex(of: person)! + 1
    }
}

print(result.0)

func floydWharshall() {
    for midPerson in 0..<users {
        for from in 0..<users {
            for to in 0..<users {
                if from == to || from == midPerson || to == midPerson {
                    continue
                }
                relationNode[from][to] = min(relationNode[from][to], relationNode[from][midPerson] + relationNode[midPerson][to])

            }
        }
    }
}

//BaekJoon Algorithm Study n.2583 (領域求め) 重要度: 🎖🎖
typealias Data = (row: Int, column: Int, sum: Int)
let data = readLine()!.split(separator: " ").map { Int(String($0))! }
let rowSize = data[0], columnSize = data[1], rectangleCount = data[2]
var map = Array(repeating: Array(repeating: false, count: columnSize), count: rowSize)
let directionRow = [0, 0, 1, -1] //東西南北
let directionColumn = [1, -1, 0, 0]
var squares = 0
var rectangleArea = [Int]()

for _ in 0..<rectangleCount {
    let putSquare = readLine()!.split(separator: " ").map { Int(String($0))! }
    makeSquare(rowSize - 1 - putSquare[1], putSquare[0], rowSize - putSquare[3], putSquare[2] - 1)
}

for i in 0..<rowSize {
    for j in 0..<columnSize {
        if !map[i][j] {
            squares += 1
            bfs(i, j)
        }
    }
}

print(squares)
print(rectangleArea.sorted(by: <).map { String($0) }.joined(separator: " "))

func bfs(_ rowStart: Int, _ columnStart: Int) {
    map[rowStart][columnStart] = true
    var areaSum = 0
    var tempSum = 1
    var neededCheckQueue: [Data] = [(rowStart, columnStart, tempSum)]

    while !neededCheckQueue.isEmpty {
        let removeOne: Data = neededCheckQueue.removeFirst()
        areaSum = removeOne.sum

        for i in 0..<4 {
            let nextRow = removeOne.row + directionRow[i]
            let nextColumn = removeOne.column + directionColumn[i]

            if nextRow < 0 || nextRow >= rowSize || nextColumn < 0 || nextColumn >= columnSize || map[nextRow][nextColumn] {
                continue
            }

            map[nextRow][nextColumn] = true
            tempSum += 1
            neededCheckQueue.append((nextRow, nextColumn, tempSum))
        }
    }

    rectangleArea.append(areaSum)
}

func makeSquare(_ leftRow: Int, _ leftColumn: Int, _ rightRow: Int, _ rightColumn: Int) {
    for i in rightRow...leftRow {
        for j in leftColumn...rightColumn {
            if !map[i][j] {
                map[i][j] = true
            }
        }
    }
}

//BaekJoon Algorithm Study n.16234 (人口移動) 重要度: 🎖🎖🎖🎖🎖🎖🎖🎖🎖
// while文を用いたbfsアルゴリズム
let data = readLine()!.split(separator: " ").map { Int(String($0))! }
let mapSize = data[0], lowerLimit = data[1], upperLimit = data[2]
var map = [[Int]]()
let directionRow = [0, 0, 1, -1] //東西南北
let directionColumn = [1, -1, 0, 0]
var moveDayCount = 0

for _ in 0..<mapSize {
    map += [readLine()!.split(separator: " ").map { Int(String($0))! }]
}

while true {
    var visited = Array(repeating: Array(repeating: false, count: mapSize), count: mapSize)
    var union = [[(Int, Int)]]()
    
    for i in 0..<mapSize {
        for j in 0..<mapSize {
            if !visited[i][j] {
                bfs_makeUnion(i, j, &visited, &union)
            }
        }
    }
    
    if union.count == 0 {
        break
    } else {
        for i in union {
            peopleMove(i)
        }
        moveDayCount += 1
    }
}

print(moveDayCount)

func bfs_makeUnion(_ row: Int, _ column: Int, _ tempVisited: inout [[Bool]], _ tempUnion: inout [[(Int, Int)]]) {
    var haveUnion = false
    var neededCheckQueue = [(row, column)]
    var index = 0
    tempVisited[row][column] = true
    
    while index < neededCheckQueue.count {
        let (currentRow, currentColumn) = neededCheckQueue[index]
        
        for i in 0..<4 {
            let nextRow = currentRow + directionRow[i]
            let nextColumn = currentColumn + directionColumn[i]
            
            if nextRow < 0 || nextRow >= mapSize || nextColumn < 0 || nextColumn >= mapSize || tempVisited[nextRow][nextColumn] {
                continue
            }
            
            if lowerLimit <= abs(map[currentRow][currentColumn] - map[nextRow][nextColumn]) && abs(map[currentRow][currentColumn] - map[nextRow][nextColumn]) <= upperLimit {
                if !haveUnion {
                    haveUnion = true
                }
                tempVisited[nextRow][nextColumn] = true
                neededCheckQueue.append((nextRow, nextColumn))
            }
        }
        
        index += 1
    }
    
    if haveUnion {
        tempUnion.append(neededCheckQueue)
        return
    }
}

func peopleMove(_ group: [(Int, Int)]) {
    var totalPeople = 0
    
    for i in group {
        totalPeople += map[i.0][i.1]
    }
    
    group.forEach { changePeople in
        map[changePeople.0][changePeople.1] = totalPeople / group.count
    }
}
