//
//  Day2 _ paiza_rank.B.swift
//  Paiza
//
//  Created by Kyus'lee on 2022/03/10.
//

import Foundation

//山の頂上を探せ Rank.B
let mapSize = Int(readLine()!)!
var mapData = [[Int]]()
let directionRow = [0, 0, -1, 1]
let directionColumn = [1, -1, 0, 0]
var mountain_top = [Int]()

for _ in 0..<mapSize {
    mapData += [readLine()!.split(separator: " ").map { Int(String($0))! }]
}

for i in 0..<mapSize {
    for j in 0..<mapSize {
        if Find_Top(i, j) {
            mountain_top.append(mapData[i][j])
        }
    }
}

mountain_top.sort(by: >)

for i in 0..<mountain_top.count {
    print(mountain_top[i])
}

func Find_Top(_ rowStart: Int, _ columnStart: Int) -> Bool {
    let compareValue = mapData[rowStart][columnStart]
    var isTop = true

    for i in 0..<4 {
        let nextRow = rowStart + directionRow[i]
        let nextColumn = columnStart +  directionColumn[i]

        if nextRow < 0 || nextRow >= mapSize || nextColumn < 0 || nextColumn >= mapSize {
            continue
        }

        let compareRound = mapData[nextRow][nextColumn]

        if compareValue <= compareRound {
            isTop = false
        }
    }

    return isTop
}
