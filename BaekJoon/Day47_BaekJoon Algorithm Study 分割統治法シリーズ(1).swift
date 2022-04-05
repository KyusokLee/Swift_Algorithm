//
//  Day 47.swift
//  BaekJoon
//
//  Created by Kyus'lee on 2022/04/05.
//

import Foundation

//Day 47 分割統治法シリーズ (1)
//🔥分割統治法の代表的な問題
//BaekJoon Algorithm Study n.2630 (色紙作り)
// 1は青い色を、 0は白い色を表す
//‼️🔥 必ず理解しておくこと！！！ 🔥‼️
typealias Color = (white: Int, blue: Int)
let paperSize = Int(readLine()!)!
var paper = [[Int]]()

for _ in 0..<paperSize {
    paper += [readLine()!.split(separator: " ").map { Int(String($0))! }]
}

let result = countColor(0, 0, paperSize)
print("\(result.white)\n\(result.blue)")

func countColor(_ rowStart: Int, _ columnStart: Int, _ size: Int) -> Color {
    print("row: \(rowStart) , column: \(columnStart)")
    if size == 1 {
        if paper[rowStart][columnStart] == 1 {
            return (0, 1)
        } else if paper[rowStart][columnStart] == 0 {
            return (1, 0)
        }
    }

    var white = 0, blue = 0
    let rowDivide = [rowStart, rowStart + size / 2]
    let columnDivide = [columnStart, columnStart + size / 2]

    for i in 0..<2 {
        for j in 0..<2 {
            let quadrant = countColor(rowDivide[i], columnDivide[j], size / 2)
            white += quadrant.white
            blue += quadrant.blue
        }
    }

    //チェックしたマスの中、白い色がなかったら　-> つまり、ここまでチェックしたマスは全部同じ色であったということになるため、if white　== 0 条件文を設けて、blue 色の紙を１に統合する
    if white == 0 {
        return (0, 1)
    }
    if blue == 0 {
        return (1, 0)
    }

    return (white, blue)
}

//BaekJoon Algorithm Study n.1780 (紙の個数) 重要度: 🎖🎖🎖🎖
// 分割統治法
typealias number =  (a: Int, b: Int, c: Int) // -1 -> a, 0 -> b, 1 -> c
let paperSize = Int(readLine()!)!
var paper = [[Int]]()

for _ in 0..<paperSize {
    paper += [readLine()!.split(separator: " ").map { Int(String($0))! }]
}

let result = cutAndCountNum(0, 0, paperSize)
print(result.a)
print(result.b)
print(result.c)

func cutAndCountNum(_ rowStart: Int, _ columnStart: Int, _ size: Int) -> number {
    if size == 1 {
        if paper[rowStart][columnStart] == -1 {
            return (1, 0, 0)
        } else if paper[rowStart][columnStart] == 0 {
            return (0, 1, 0)
        } else {
            return (0, 0, 1)
        }
    }

    var a = 0, b = 0, c = 0
    let newSize = size / 3

    for i in 0..<3 {
        for j in 0..<3 {
            let divideNine = cutAndCountNum(rowStart + newSize * i, columnStart + newSize * j, newSize)
            a += divideNine.a
            b += divideNine.b
            c += divideNine.c
        }
    }

    if b == 0 && c == 0 {
        return (1, 0, 0)
    } else if a == 0 && c == 0 {
        return (0, 1, 0)
    } else if a == 0 && b == 0 {
        return (0, 0, 1)
    }

    return (a, b, c)
}

//より効率いいコード
var paperSize = Int(readLine()!)!
var paper : [[Int]] = []
var result : [Int] = [0,0,0] // -1 , 0, 1 の順

for _ in 0..<paperSize {
    paper += [readLine()!.split(separator: " ").map { Int(String($0))! }]
}

divide(0, 0, paperSize)
print("\(result[0])\n\(result[1])\n\(result[2])")

func divide(_ row: Int , _ col: Int , _ size: Int) {

    if check(row, col, size) {
        result[paper[row][col] + 1] += 1
    } else {
        let newSize = size / 3
        for i in 0..<3 {
            for j in 0..<3 {
                divide(row + newSize * i, col + newSize * j, newSize)
            }
        }
    }
}

func check(_ row : Int , _ col : Int , _ size : Int) -> Bool {
    let start = paper[row][col]

    for i in row..<row + size {
        for j in col..<col + size {
            if paper[i][j] != start {
                return false
            }

        }
    }
    return true
}

//BaekJoon Algorithm Study n.1992 (QuadTree) 重要度: 🎖🎖🎖🎖🎖🎖
//分割統治法 , 再帰関数
let videoSize = Int(readLine()!)!
var video = [[Int]]()
var result = ""

for _ in 0..<videoSize {
    video += [readLine()!.map { Int(String($0))! }]
}

divide(0, 0, videoSize)
print(result)

func divide(_ row: Int, _ column: Int, _ size: Int) {
    if check(row, column, size) {
        result += "\(video[row][column])"
    } else {
        result += "("
        let newSize = size / 2

        for i in 0..<2 {
            for j in 0..<2 {
                divide(row + newSize * i, column + newSize * j, newSize)
            }
        }
        result += ")"
    }
}

func check(_ row: Int, _ column: Int, _ size: Int) -> Bool {
    let compare = video[row][column]

    for i in row..<row + size {
        for j in column..<column + size {
            if video[i][j] != compare {
                return false
            }
        }
    }

    return true
}

//BaekJoon Algorithm Study n.1074 (Z) 重要度: 🎖🎖🎖🎖🎖🎖
//分割統治法 , 再帰関数
// 注意: 時間超過にならないように設計する際、注意すること
// 🔥Hard!!🔥

// 時間超過になってしまったコード
let data = readLine()!.split(separator: " ").map { Int(String($0))! }
let size = data[0], targetRow = data[1], targetColumn = data[2]
let mapSize = Int(pow(2.0, Double(size)))
var visitCount = -1, findTarget = false

divideAndVisit(0, 0, mapSize, (targetRow, targetColumn))
print(visitCount)

func divideAndVisit(_ row: Int, _ column: Int, _ size: Int, _ target: (Int, Int)) {
    if size == 2 {
        if check(row, column, size) {
            findTarget = true
            return
        } else {
            return
        }
    } else {
        let newSize = size / 2
        for i in 0..<2 {
            for j in 0..<2 {
                if !findTarget {
                    divideAndVisit(row + newSize * i, column + newSize * j, newSize, target)
                } else {
                    return
                }
            }
        }
    }
}

func check(_ row: Int, _ column: Int, _ size: Int) -> Bool {
    let targetLocate = (targetRow, targetColumn)

    for i in row..<row + size {
        for j in column..<column + size {
            visitCount += 1
            if (i, j) == targetLocate {
                return true
            }
        }
    }

    return false
}

//時間超過にならないコード
let data = readLine()!.split(separator: " ").map { Int(String($0))! }
let mapSize = data[0], rowSize = data[1], columnSize = data[2], targetNum = (rowSize, columnSize)

var count = 0
solve(Int(pow(2, Double(mapSize))), 0, 0)

func solve(_ size: Int, _ row: Int, _ column: Int) -> Void {

    if size == 2 {
        if (row, column) == targetNum {
            print(count)
            return
        }
        count += 1
        if (row, column + 1) == targetNum {
            print(count)
            return
        }
        count += 1
        if (row + 1, column) == targetNum {
            print(count)
            return
        }
        count += 1
        if (row + 1, column + 1) == targetNum {
            print(count)
            return
        }
        count += 1
        return
    } else {
        if rowSize < row + size / 2, columnSize < column + size / 2 {
            solve(size / 2, row, column)
        } else if rowSize < row + size / 2, columnSize < (column + size / 2) + size / 2 {
            count += (size / 2) * (size / 2)
            solve(size / 2, row, column + size / 2)
        } else if rowSize < (row + size / 2) + size / 2, columnSize < column + size / 2 {
            count += (size / 2) * (size / 2) * 2
            solve(size / 2, row + size / 2, column)
        } else {
            count += (size / 2) * (size / 2) * 3
            solve(size / 2, row + size / 2, column + size / 2)
        }
    }
}

//もっと処理時間が早いコード
// ⚠️まだ、完全に理解してないコード ‼️
// - - - - 🔥後で、必ず分析し吸収すること🔥 - - - -

let data = readLine()!.split(separator: " ").map { Int(String($0))! }
let mapSize = data[0], rowSize = data[1], columnSize = data[2]
var answer = 0

find(0, 0, Int(pow(Double(2), Double(mapSize))), Int(pow(Double(2), Double(mapSize))))
print(answer)

//Y : row , X : columnを意味
func find(_ minY: Int,_ minX: Int, _ maxY: Int, _ maxX: Int) {
    if (rowSize >= minY && rowSize <= minY + (maxY - minY - 1) / 2) && (columnSize >= minX && columnSize <= minX + (maxX - minX - 1) / 2) {
        if maxY - minY == 2 {
            return
        } else {
            find(minY, minX, minY + (maxY - minY) / 2, minX + (maxX - minX) / 2)
        }
    } else if (rowSize >= minY && rowSize <= minY + (maxY - minY - 1) / 2) && (columnSize >= minX + (maxX - minX) / 2 && columnSize <= maxX - 1) {
        if maxY - minY == 2 {
            answer += 1
            return
        } else {
            answer += (maxY - minY) * (maxY - minY) / 4
            find(minY, minX + (maxX - minX) / 2, minY + (maxY - minY) / 2, maxX)
        }
    } else if (rowSize >= minY + (maxY - minY) / 2 && rowSize <= maxY - 1) && (columnSize >= minX && columnSize <= minX + (maxX - minX - 1) / 2) {
        if maxY - minY == 2 {
            answer += 2
            return
        } else {
            answer += (maxY - minY) * (maxY - minY) * 2 / 4
            find(minY + (maxY - minY) / 2, minX, maxY, minX + (maxX - minX) / 2)
        }
    } else if (rowSize >= minY + (maxY - minY) / 2 && rowSize <= maxY - 1) && (columnSize >= minX + (maxX - minX) / 2 && columnSize <= maxX - 1) {
        if maxY - minY == 2 {
            answer += 3
            return
        } else {
            answer += (maxY - minY) * (maxY - minY) * 3 / 4
            find(minY + (maxY - minY) / 2, minX + (maxX - minX) / 2, maxY, maxX)
        }
    }
}
