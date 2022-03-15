//
//  Day7_Paiza_rank.A.swift
//  Paiza
//
//  Created by Kyus'lee on 2022/03/15.
//

import Foundation

//脱出ゲーム rank.A

let data = readLine()!.split(separator: " ").map { String($0) }
var rowSize = 0, columnSize = 0
if !conditionCheck(data[0], data[1]) {
    exit(0)
}

var visited = Array(repeating: Array(repeating: false, count: columnSize), count: rowSize)
var field = [[Character]]()
var startPoint = [(row: Int, column: Int)]()
let directionRow = [0, 0, -1, 1]
let directionColumn = [1, -1 , 0, 0]
var canExcape = false

for _ in 0..<rowSize {
    let rowData = readLine()!
    if !dataCheck(rowData) {
        exit(0)
    }

    field += [Array(rowData)]
}

for i in 0..<rowSize {
    for j in 0..<columnSize {
        if field[i][j] == "S" {
            startPoint.append((i, j))
        }
    }
}

if startPoint.count != 1 {
    exit(0)
}

dfs_escape(startPoint[0].row, startPoint[0].column)

if canExcape {
    print("YES")
} else {
    print("NO")
}

func dfs_escape(_ rowIndex: Int, _ columnIndex: Int) {
    visited[rowIndex][columnIndex] = true

    if rowIndex + 1 >= rowSize || rowIndex - 1 < 0 || columnIndex + 1 >= columnSize || columnIndex - 1 < 0 {
        canExcape = true
        return
    }

    for i in 0..<4 {
        let nextRow = rowIndex + directionRow[i]
        let nextColumn = columnIndex + directionColumn[i]

        if nextRow < 0 || nextRow >= rowSize || nextColumn < 0 || nextColumn >= columnSize {
            continue
        }

        if field[nextRow][nextColumn] == "." && !visited[nextRow][nextColumn] {
            dfs_escape(nextRow, nextColumn)
        }

    }
}

func conditionCheck(_ str1: String, _ str2: String) -> Bool {
    let isPossible = true

    if let convertedNum1 = Int(str1) {
        rowSize = convertedNum1
        if let convertedNum2 = Int(str2) {
            columnSize = convertedNum2
        } else {
            return false
        }
    } else {
        return false
    }

    return isPossible
}

func dataCheck(_ str: String) -> Bool {
    let isOkay = true

    if str.count != columnSize {
        return false
    }

    for i in str {
        if i != "#" && i != "." && i != "S" {
            return false
        }
    }

    return isOkay
}

//階段登り rank.A

let data1 = readLine()!
var stairs = 0
if !N_check(data1) {
    exit(0)
}

let A_B = readLine()!.split(separator: " ").map { String($0) }
var A = 0, B = 0
if !AB_check(A_B[0], A_B[1]) {
    exit(0)
}

let select = [A, B]
var result = 0
var visited = [Bool](repeating: false, count: stairs + 1)

climbing_Stairs(0)
print(result)

func climbing_Stairs(_ currentPoint: Int) {
    var neededVisitQueue = [currentPoint]
    var Index = 0
    var count = 0
    visited[currentPoint] = true

    while Index < neededVisitQueue.count {
        let currentStart = neededVisitQueue[Index]

        for i in 0..<2 {
            var nextLocation = currentStart + select[i]

            if stairs < nextLocation {
                nextLocation = stairs
                if !visited[nextLocation] {
                    neededVisitQueue.append(nextLocation)
                    visited[nextLocation] = true
                    count += 1
                }
            } else {
                if !visited[nextLocation] {
                    neededVisitQueue.append(nextLocation)
                    visited[nextLocation] = true
                    count += 1
                }
            }
        }

        Index += 1
    }

    result = stairs - count
}

func N_check(_ str: String) -> Bool {
    let isPossible = true

    if let intStair = Int(str) {
        stairs = intStair
        if stairs < 1 || stairs > 200000 {
            return false
        }
    } else {
        return false
    }

    return isPossible
}

func AB_check(_ str1: String, _ str2: String) -> Bool {
    let isPossible1 = true

    if let intA = Int(str1) {
        A = intA
        if A < 1 || A > 100 {
            return false
        } else {
            if let intB = Int(str2) {
                B = intB
                if B < 1 || B > 100 {
                    return false
                } else {
                    if A >= B {
                        return false
                    }
                }
            }
        }
    } else {
        return false
    }

    return isPossible1
}

