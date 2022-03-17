//
//  Day33.swift
//  BaekJoon
//
//  Created by Kyus'lee on 2022/03/17.
//

import Foundation


//Day34: BFS, DFS シリーズ　(1)
//BaekJoon Algorithm Study n. 14502 (研究室) 重要度: 🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖
// 説明: 0 -> 空いてるマス、　1 -> 壁、　2 -> ウイルスがあるマス
// 0であるところに、壁（１）を３つ立ててウイルスの拡散を最大限防ぐ -> 安全領域の数(マスの数）が最大になるようにする　-> BFSの典型的な問題
// このような問題はもう40分内で十分解けるようになった....　成長したことを実感できたし、やりがいを感じられた問題
//  🌈📮考察:   この問題において、visitedという訪問したかないかを判断するBool配列は使わない方がいいということに気づいた -> 理由: 入力したlaboratoryのデータで0になってるところを2に変えることで、再訪問することはなくなる. また、laboratoryを固定の配列として置いといて、laboratoryをコピーした毎回更新できるような配列を用いることで、十分だった
typealias LocateData = (row: Int, column: Int)
let data = readLine()!.split(separator: " ").map { Int(String($0))! }
let rowSize = data[0], columnSize = data[1]
var laboratory = [[Int]]()
let directionRow = [0, 0, -1, 1]
let directionColumn = [1, -1, 0, 0]
var virusLocation = [LocateData]()
var wallAvailable = [LocateData]()
var safeZoneCount = 0

for _ in 0..<rowSize {
    laboratory += [readLine()!.split(separator: " ").map { Int(String($0))! }]
}

for i in 0..<rowSize {
    for j in 0..<columnSize {
        if laboratory[i][j] == 2 {
            virusLocation.append((i, j))
        } else if laboratory[i][j] == 0 {
            wallAvailable.append((i, j))
        }
    }
}

var selectedCheck = [Bool](repeating: false, count: wallAvailable.count)

select_Wall(0, 0, [])
print(safeZoneCount)

func select_Wall(_ count: Int, _ index: Int, _ wallLocating: [LocateData]) {
    if count == 3 {
        safeZoneCount = max(safeZoneCount, bfs_virusSpread(wallLocating))
        return
    } else {
        for i in index..<wallAvailable.count {
            if !selectedCheck[i] {
                selectedCheck[i] = true
                select_Wall(count + 1, index + 1, wallLocating + [wallAvailable[i]])
                selectedCheck[i] = false
            }
        }
    }
}

func bfs_virusSpread(_ compare: [LocateData]) -> Int {
    var visited = Array(repeating: Array(repeating: false , count: columnSize), count: rowSize)
    var compareMap = laboratory
    var neededVisitQueue = virusLocation
    var temporaryCount = wallAvailable.count - 3 //3を引く理由: select_Wallで選んだ3つのところに今壁ができていると仮定したため、0の数で　−３しなければならない
    var index = 0

    for i in compare {
        compareMap[i.row][i.column] = 1
    }

    while index < neededVisitQueue.count {
        let (currentRow, currentColumn) = neededVisitQueue[index]

        for i in 0..<4 {
            let nextRow = currentRow + directionRow[i]
            let nextColumn = currentColumn + directionColumn[i]

            if nextRow < 0 || nextRow >= rowSize || nextColumn < 0 || nextColumn >= columnSize {
                continue
            }

            if compareMap[nextRow][nextColumn] == 0 && !visited[nextRow][nextColumn] {
                compareMap[nextRow][nextColumn] = 2
                visited[nextRow][nextColumn] = true
                neededVisitQueue.append((nextRow, nextColumn))
                temporaryCount -= 1
            }
        }
        index += 1
    }

    return temporaryCount
}

//もっと処理時間を減らせる効率いいコード
typealias Locate = (row: Int, column: Int)
let data = readLine()!.split(separator: " ").map { Int(String($0))! }
let (rowSize, columnSize) = (data[0], data[1])
// 東西南北
let directionRow = [0, 0, -1, 1]
let directionColumn = [1, -1, 0, 0]
var virus = [Locate]()
var safeZone = [Locate]()
var laboratory = [[Int]]()
var result = 0

//for文を２回使わないように、データを入力されるとともに、virusとsafeZoneに格納する
for i in 0..<rowSize {
    let input = readLine()!.split(separator: " ").map { Int(String($0))! }
    laboratory.append(input)

    for j in 0..<columnSize {
        if input[j] == 2 {
            virus.append((i, j))
        } else if input[j] == 0 {
            safeZone.append((i, j))
        }
    }
}

// 全てのケースについて、3つの壁を設けてから、安全領域の最大値を求める (Brute Force アルゴリズムを用いる)
for i in 0..<safeZone.count - 2 {
    for j in i + 1..<safeZone.count - 1 {
        for k in j + 1..<safeZone.count {
            var compareGraph = laboratory
            compareGraph[safeZone[i].row][safeZone[i].column] = 1
            compareGraph[safeZone[j].row][safeZone[j].column] = 1
            compareGraph[safeZone[k].row][safeZone[k].column] = 1

            let area = bfs_virusSpread(&compareGraph, virus)
            result = max(result, area)
        }
    }
}

print(result)

// 安全領域のサイズを求める
func getArea(_ graph: [[Int]]) -> Int {
    var total = 0

    for i in 0..<rowSize {
        for j in 0..<columnSize {
            if graph[i][j] == 0 {
                total += 1
            }
        }
    }

    return total
}

// BFS アルゴリズムを用いてウイルスを拡散させる
func bfs_virusSpread(_ graph: inout [[Int]], _ virus: [Locate]) -> Int {
    var virusQueue = virus

    while !virusQueue.isEmpty {
        let node = virusQueue.removeFirst()
        let (curRow, curColumn) = (node.0, node.1)

        for i in 0..<4 {
            let nextRow = curRow + directionRow[i]
            let nextColumn = curColumn + directionColumn[i]

            if nextRow < 0 || nextRow >= rowSize || nextColumn < 0 || nextColumn >= columnSize {
                continue
            }

            if graph[nextRow][nextColumn] == 0 {
                graph[nextRow][nextColumn] = 2
                virusQueue.append((nextRow, nextColumn))
            }
        }
    }

    return getArea(graph)
}

//上記のコードを少し変え、再帰関数を使ったコード
// 🌈📮考察: やはり、再帰関数を使うと、処理時間がすごく増えることにきづいた
typealias Locate = (row: Int, column: Int)
let data = readLine()!.split(separator: " ").map { Int(String($0))! }
let (rowSize, columnSize) = (data[0], data[1])
// 東西南北
let directionRow = [0, 0, -1, 1]
let directionColumn = [1, -1, 0, 0]
var virus = [Locate]()
var safeZone = [Locate]()
var laboratory = [[Int]]()
var result = 0

//for文を２回使わないように、データを入力されるとともに、virusとsafeZoneに格納する
for i in 0..<rowSize {
    let input = readLine()!.split(separator: " ").map { Int(String($0))! }
    laboratory.append(input)
    
    for j in 0..<columnSize {
        if input[j] == 2 {
            virus.append((i, j))
        } else if input[j] == 0 {
            safeZone.append((i, j))
        }
    }
}

// 全てのケースについて、3つの壁を設けてから、安全領域の最大値を求める (Brute Force アルゴリズムを用いる)
var selectedCheck = [Bool](repeating: false, count: safeZone.count)

select_Wall(0, 0, [])
print(result)

func select_Wall(_ count: Int, _ index: Int, _ wallLocating: [Locate]) {
    if count == 3 {
        var compareMap = laboratory
        for i in wallLocating {
            compareMap[i.row][i.column] = 1
        }
        result = max(result, bfs_virusSpread(&compareMap, virus))
        return
    } else {
        for i in index..<safeZone.count {
            if !selectedCheck[i] {
                selectedCheck[i] = true
                select_Wall(count + 1, index + 1, wallLocating + [safeZone[i]])
                selectedCheck[i] = false
            }
        }
    }
}

// BFS アルゴリズムを用いてウイルスを拡散させる
func bfs_virusSpread(_ graph: inout [[Int]], _ virus: [Locate]) -> Int {
    var virusQueue = virus
    
    while !virusQueue.isEmpty {
        let node = virusQueue.removeFirst()
        let (curRow, curColumn) = (node.0, node.1)
        
        for i in 0..<4 {
            let nextRow = curRow + directionRow[i]
            let nextColumn = curColumn + directionColumn[i]
            
            if nextRow < 0 || nextRow >= rowSize || nextColumn < 0 || nextColumn >= columnSize {
                continue
            }
            
            if graph[nextRow][nextColumn] == 0 {
                graph[nextRow][nextColumn] = 2
                virusQueue.append((nextRow, nextColumn))
            }
        }
    }
    
    return getArea(graph)
}

// 安全領域のサイズを求める
func getArea(_ graph: [[Int]]) -> Int {
    var total = 0
    
    for i in 0..<rowSize {
        for j in 0..<columnSize {
            if graph[i][j] == 0 {
                total += 1
            }
        }
    }
    
    return total
}
