//
//  Day10.swift
//  Paiza
//
//  Created by Kyus'lee on 2022/03/28.
//

import Foundation


//Day10 rank.A　１問
//RGBの個数 rank.A
let data = readLine()!.split(separator: " ").map { String($0) }
var rowSize = 0, columnSize = 0
if !conditionCheck() {
    exit(0)
}

var map = [[Character]]()
for _ in 0..<rowSize {
    let putData = Array(readLine()!)
    if !conditionCheck2(putData) {
        exit(0)
    }
    
    map += [putData]
}

var RGB = Array(repeating: 0, count: 3)
let directionRow = [0, 0, 1, -1]
let directionColumn = [1, -1, 0, 0]
var visited = Array(repeating: Array(repeating: false, count: columnSize), count: rowSize)

for i in 0..<rowSize {
    for j in 0..<columnSize {
        if !visited[i][j] {
            bfs_RGB(i, j, map[i][j])
        }
    }
}

print(RGB.map { String($0) }.joined(separator: " "))

func bfs_RGB(_ rowStart: Int, _ columnStart: Int, _ targetColor: Character) {
    var index = 0
    var neededCheckQueue: [(row: Int, column: Int)] = [(rowStart, columnStart)]
    visited[rowStart][columnStart] = true
    
    while index < neededCheckQueue.count {
        let (currentRow, currentColumn) = neededCheckQueue[index]
        
        for i in 0..<4 {
            let nextRow = currentRow + directionRow[i]
            let nextColumn = currentColumn + directionColumn[i]
            
            if nextRow < 0 || nextRow >= rowSize || nextColumn < 0 || nextColumn >= columnSize || visited[nextRow][nextColumn] || map[nextRow][nextColumn] != targetColor {
                continue
            }
            
            visited[nextRow][nextColumn] = true
            neededCheckQueue.append((nextRow, nextColumn))
        }
        index += 1
    }
    
    switch targetColor {
    case "R":
        RGB[0] += 1
    case "G":
        RGB[1] += 1
    case "B":
        RGB[2] += 1
    default:
        exit(0)
    }
}

func conditionCheck() -> Bool {
    
    if let intRow = Int(data[0]) {
        if intRow < 1 || intRow > 1000 {
            return false
        } else {
            if let intColumn = Int(data[1]) {
                if intColumn < 1 || intColumn > 1000 {
                    return false
                } else {
                    rowSize = intRow
                    columnSize = intColumn
                }
            }
        }
    } else {
        return false
    }

    return true
}

func conditionCheck2(_ check: [Character]) -> Bool {
    for i in check {
        if i == "R" || i == "G" || i == "B" {
            continue
        } else {
            return false
        }
    }
    
    return true
}
