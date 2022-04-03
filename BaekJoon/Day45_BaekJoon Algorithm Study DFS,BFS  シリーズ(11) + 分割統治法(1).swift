//
//  Day45.swift
//  BaekJoon
//
//  Created by Kyus'lee on 2022/04/03.
//

import Foundation

//Day 45: DFS,BFS シリーズ(11)
//BaekJoon Algorithm Study n.2573

let data = readLine()!.split(separator: " ").map { Int(String($0))! }
let rowSize = data[0], columnSize = data[1]
var map = [[Int]]()
let directionRow = [0, 0, 1, -1]
let directionColumn = [1, -1, 0, 0]
var result = 0
var visited = Array(repeating: Array(repeating: false, count: columnSize), count: rowSize)

for _ in 0..<rowSize {
    map += [readLine()!.split(separator: " ").map { Int(String($0))! }]
}

var years = 0
var isDivided = false

while true {
    var tmpMap = map
    var IcebergCount = 1

loop: for i in 0..<rowSize {
        for j in 0..<columnSize {
            if map[i][j] != 0 && !visited[i][j] {
                if IcebergCount > 1 {
                    isDivided = true
                    break loop
                }
                dfs_Iceberg(i, j, years, &tmpMap)
                map = tmpMap
                IcebergCount += 1
            }
        }
    }

    if !isDivided {
        visited = Array(repeating: Array(repeating: false, count: columnSize), count: rowSize)
        years += 1
    }

    if noMoreIceberg() {
        if !isDivided {
            print(0)
            break
        }
    }

    if isDivided {
        print(years)
        break
    }
}

func noMoreIceberg() -> Bool {
    for i in 0..<rowSize {
        for j in 0..<columnSize {
            if map[i][j] != 0 {
                return false
            }
        }
    }

    return true
}

func dfs_Iceberg(_ rowStart: Int, _ columnStart: Int, _ year: Int, _ changeMap: inout [[Int]]) {
    visited[rowStart][columnStart] = true
    if map[rowStart][columnStart] > 0 {
        for i in 0..<4 {
            let nextR = rowStart + directionRow[i]
            let nextC = columnStart + directionColumn[i]

            if nextR < 0 || nextR >= rowSize || nextC < 0 || nextC >= columnSize {
                continue
            }
            if map[nextR][nextC] == 0 {
                if changeMap[rowStart][columnStart] > 0 {
                    changeMap[rowStart][columnStart] -= 1
                } else {
                    continue
                }
            }
        }
    }

    for i in 0..<4 {
        let nextRow = rowStart + directionRow[i]
        let nextColumn = columnStart + directionColumn[i]

        if nextRow < 0 || nextRow >= rowSize || nextColumn < 0 || nextColumn >= columnSize {
            continue
        }

        if map[nextRow][nextColumn] != 0 && !visited[nextRow][nextColumn] {
            dfs_Iceberg(nextRow, nextColumn, year, &changeMap)
        }
    }
}

//BaekJoon Algorithm Study n.1967 （ツリーの直径）　重要度: 🎖🎖🎖🎖🎖🎖🎖🎖🎖
// 🔥Hard アイデアを考えるのが難しかった問題!🔥
// Idea:  1. まず、ノード1がtreeの根だと想定し、そのノードから深さが最も深いノードを選択する。そのノードがきっと直径を２点のうちの１点である。
//        2. １で求めた点から最も長さが長い点を選べばいい! 今回は深さではなく、辺の重さの和が最も長い点を選べばいい。
//        3. １と２で求めた点がtreeの直径となり、その値がこの問題の解である。

let nodes = Int(readLine()!)!
var trees = Array(repeating: [(Int, Int)](), count: nodes)

for _ in 0..<nodes - 1 {
    let putData = readLine()!.split(separator: " ").map { Int(String($0))! - 1 }
    trees[putData[0]].append((putData[1], putData[2] + 1))
    trees[putData[1]].append((putData[0], putData[2] + 1))
}
var visited = Array(repeating: false, count: nodes)
var lengthFromNode = 0
var finalNode = 0

dfs(0, 0)
visited = Array(repeating: false, count: nodes)
lengthFromNode = 0
dfs(finalNode, 0)
print(lengthFromNode)


// ここで、深さを別途で計算しない理由 >>> dfs自体が繋がってる辺だけを探るため、探索の基準のノードから自動的に最も深さが深いとこまで探ることになる
// また、深さが深くても、必ずしもその長さ(treeの直径)が最も長いとは限らないため、重さを基準に探る方が正しいと思った
func dfs(_ node: Int, _ length: Int) {
    visited[node] = true
    if lengthFromNode < length {
        lengthFromNode = length
        finalNode = node
    }

    for i in trees[node] {
        if !visited[i.0] {
            dfs(i.0, length + i.1)
        }
    }
}

//❗️- - - - 📮 分割統治法のアルゴリズム 📚 - - - -❗️
// 🔥分割統治法には、Quick Sort　と　Merge Sortがある

//⭐️ - - - -📝 Quick Sortのアルゴリズム - - - - ⭐️
func quickSort(_ array: [Int]) -> [Int] {
    guard let first = array.first, array.count > 1 else { return array }
 
    let pivot = first
    let left = array.filter { $0 < pivot }
    let right = array.filter { $0 > pivot }
    
    return quickSort(left) + [pivot] + quickSort(right)
}


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
    
    if white == 0 {
        return (0, 1)
    }
    if blue == 0 {
        return (1, 0)
    }
    
    return (white, blue)
}
