//
//  Day31_BaekJoon.swift
//  BaekJoon
//
//  Created by Kyus'lee on 2022/03/12.
//

import Foundation

//Day31 Week4 ~ 5: 一週間の復習 (1)
//BaekJoon Algorithm Study n.7576 (トマト) Fisrt Gold 重要度：🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖
let fieldSize = readLine()!.split(separator: " ").map { Int(String($0))! }
let columnSize = fieldSize[0], rowSize = fieldSize[1]
var field = [[Int]]()
let directionRow = [0, 0, -1, 1]
let directionColumn = [1, -1, 0, 0]
var resultDay = 0
var ripenedTomatoQueue: [((row: Int, column: Int ), day: Int)] = []
var isAllripend = true

for _ in 0..<rowSize {
    field += [readLine()!.split(separator: " ").map { Int(String($0))! }]
}

for i in 0..<rowSize {
    for j in 0..<columnSize {
        if field[i][j] == 1 {
            ripenedTomatoQueue.append(((i, j), 0))
        }
    }
}

bfs_checkingDay()

loop: for i in 0..<rowSize {
    for j in 0..<columnSize {
        if field[i][j] == 0 {
            isAllripend = false
            break loop
        }
    }
}

if isAllripend {
    print(resultDay)
} else {
    print(-1)
}

func bfs_checkingDay() {
    var Index = 0
    var dayCount = 0

    while Index < ripenedTomatoQueue.count {
        let ((currentRow, currentColumn), day) = ripenedTomatoQueue[Index]

        for i in 0..<4 {
            let nextRow = currentRow + directionRow[i]
            let nextColumn = currentColumn + directionColumn[i]

            if nextRow < 0 || nextRow >= rowSize || nextColumn < 0 || nextColumn >= columnSize {
                continue
            }

            if field[nextRow][nextColumn] == 0 {
                ripenedTomatoQueue.append(((nextRow, nextColumn), day + 1))
                field[nextRow][nextColumn] = 1
            }
        }
        Index += 1
        dayCount = day
    }

    resultDay = dayCount
}

//BaekJoon Algorithm Study n.15686 (チキン配達) 重要度：🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖
let data = readLine()!.split(separator: " ").map { Int(String($0))! }
let mapSize = data[0], chickenHouseCount = data[1]
var map = [[Int]]()
var houseLocation: [(row: Int, column: Int)] = []
var chickenHouseLocation: [(row: Int, column: Int)] = []
var result = 98765432

for _ in 0..<mapSize {
    map += [readLine()!.split(separator: " ").map { Int(String($0))! }]
}

for i in 0..<mapSize {
    for j in 0..<mapSize {
        if map[i][j] == 1 {
            houseLocation.append((i, j))
        } else if map[i][j] == 2 {
            chickenHouseLocation.append((i, j))
        }
    }
}

selectChickenHouse([], 0)
print(result)

func selectChickenHouse(_ select: [(Int, Int)], _ Index: Int) {
    if select.count == chickenHouseCount {
        result = min(result, chickenDistanceMin(select))
    } else {
        for i in Index..<chickenHouseLocation.count {
            selectChickenHouse(select + [chickenHouseLocation[i]], i + 1)
        }
    }
}

func chickenDistanceMin(_ compare: [(Int, Int)]) -> Int {
    var compareDistance = 0

    for house in houseLocation {
        var compareOne = 98765432
        for chicken in compare {
            let distance = countingDistance(house, chicken)
            compareOne = min(compareOne, distance)
        }
        compareDistance += compareOne
    }

    return compareDistance
}

func countingDistance (_ data1: (Int, Int), _ data2: (Int, Int)) -> Int {
    return abs(data1.0 - data2.0) + abs(data1.1 - data2.1)
}

//BaekJoon Algorithm Study n.5585 (お釣り) 重要度：🎖🎖🎖🎖
var redundancy = 1000 - Int(readLine()!)!
let moneyArray = [500, 100, 50, 10, 5, 1]
var result = 0

for i in moneyArray {
    while redundancy >= i {
        redundancy -= i
        result += 1
    }
}

print(result)

//BaekJoon Algorithm Study n.1100 (白いマス)
var board = [[Character]]()
var count = 0

for _ in 0..<8 {
    board += [Array(readLine()!)]
}

for i in 0..<board.count {
    for j in 0..<board.count {
        if (i + j) % 2 == 0 {
            if board[i][j] == "F" {
                count += 1
            }
        }
    }
}

print(count)

//BaekJoon Algorithm Study n.1676 (factorial ０の個数)
let N = Int(readLine()!)!
print(N / 5 + N / 25 + N / 125)
