//
//  Day22.swift
//  BaekJoon
//
//  Created by Kyus'lee on 2022/02/28.
//

import Foundation

//Day 22: Week3: 一週間のアルゴリズムの整理と問題の復習
//BaekJoon Algorithm Study n.10844 (n. 分かりやすい階段数) 重要度: 🎖🎖🎖🎖🎖🎖🎖🎖🎖
// ‼️HARD‼️
//🔥あるパターンを分析することが大事　＞＞　ノートで計算してそのパターンを把握すること！！
// ⚠️途中の段階
let numberLength = Int(readLine()!)!
let mod = 1000000000
var degree_Count = [[Int]](repeating: Array(repeating:0, count: 10), count: numberLength + 1) //2重配列の初期設定
// 各配列のIndex degree1_Num[a][b]の設定：a = 桁数, b = 最後にくる数字の値 　(例えば、123, 343であれば、[2][3] [2][3]

guard numberLength != 1 else {
    print("9")
    exit(0)
}

//階段数になる数字に個数を格納した配列
for i in 1...9 {
    degree_Count[1][i] = 1
}

for i in 2...numberLength {
    for j in 0...9 {
        if j == 0 {
            degree_Count[i][j] = degree_Count[i - 1][j + 1] % mod
        } else if j == 9 {
            degree_Count[i][j] = degree_Count[i - 1][j - 1] % mod
        } else {
            degree_Count[i][j] = degree_Count[i - 1][j - 1] + degree_Count[i - 1][j + 1] % mod
        }
    }
}

print(degree_Count[numberLength].reduce(0, +) % mod)

// もっと効率的に処理時間を減らすコード
// 二重配列じゃなく、１次元の配列を用いてその配列を変える方法

let length_N = Int(readLine()!)!
var dp_Array = [0] + Array(repeating: 1, count: 9) //このような表現も可能である
let mod = 1000000000

for _ in 1..<length_N {
    let beforeCount = dp_Array // ここで、繰り返しが実行される度に、毎回更新される配列を指す変数を設ける
    //　つまり、上記で作った変数は、１個前の繰り返しで作られた配列を意味する
    dp_Array[0] = beforeCount[1] // 0で終わる階段数は、前の繰り返し（求める桁数より１個少ない桁数で1に終わる数字しか格納されない）
    dp_Array[9] = beforeCount[8]
    for i in 1...8 {
        dp_Array[i] = (beforeCount[i - 1] + beforeCount[i + 1]) % mod
    }
}

print(dp_Array.reduce(0, +) % mod)

// 📝❗️➡️ ここからが復習❗️
//BaekJoon Algorithm Study n.1012 (オーガニック白菜) 重要度：🎖🎖🎖🎖🎖🎖🎖🎖
//row: 行 (縦のサイズ)、　　column: 列 (横のサイズ)
let testCase1 = Int(readLine()!)!
var larvaCount = 0
let directionRow = [0, 0, -1, 1]
let directionColumn = [1, -1, 0, 0]
var mapSize1 = [[Bool]]()
var visited = [[Bool]]()

for _ in 0..<testCase1 {
    countingLarva()
    print(larvaCount)
    larvaCount = 0
}

func countingLarva() {
    let data = readLine()!.split(separator: " ").map { Int(String($0))! }
    let columnSize = data[0], rowSize = data[1], cabbages = data[2]
    mapSize1 = Array(repeating: Array(repeating: false, count: columnSize), count: rowSize)
    visited = Array(repeating: Array(repeating: false, count: columnSize), count: rowSize)

    for _ in 0..<cabbages {
        let haveCabbage = readLine()!.split(separator: " ").map { Int(String($0))! }
        let column = haveCabbage[0], row = haveCabbage[1]
        mapSize1[row][column] = true
    }

    for i in 0..<rowSize {
        for j in 0..<columnSize {
            if mapSize1[i][j] && !visited[i][j] {
                larvaCount += 1
                dfs1(startRow:i, startColumn: j, rowRange: rowSize, columnRange: columnSize)
            }
        }
    }
}

func dfs1(startRow: Int, startColumn: Int, rowRange: Int, columnRange: Int) {
    visited[startRow][startColumn] = true

    for i in 0..<4 {
        let nextRow = startRow + directionRow[i]
        let nextColumn = startColumn + directionColumn[i]

        if (0 <= nextRow && nextRow < rowRange) && (0 <= nextColumn && nextColumn < columnRange) {
            if mapSize1[nextRow][nextColumn] && !visited[nextRow][nextColumn] {
                dfs1(startRow: nextRow, startColumn: nextColumn, rowRange: rowRange, columnRange: columnRange)
            }
        }
    }
}

//BaekJoon Algorithm Study n.4963 （島の数) 重要度：🎖🎖🎖🎖🎖🎖🎖🎖

// 1: 陸地 0: 海

var islandCount = 0
var visited = [[Bool]]()
var mapData = [[Int]]()
let directionRow = [-1, -1, -1, 0, 1, 1, 1, 0]
let directionColumn = [-1, 0, 1, 1, 1, 0, -1, -1]
// 島の探索は、北西方向を皮切りに時計回り

while true {
    let mapSize = readLine()!.split(separator: " ").map { Int(String($0))! }
    let columnSize = mapSize[0], rowSize = mapSize[1]
    guard columnSize != 0 && rowSize != 0 else {
        exit(0)
    }

    findingIsland(rowRange: rowSize, columnRange: columnSize)
    print(islandCount)
    islandCount = 0
}

func findingIsland(rowRange: Int, columnRange: Int) {
    visited = Array(repeating: Array(repeating: false, count: columnRange), count: rowRange)
    mapData = [[Int]]()

    for _ in 0..<rowRange {
        let putMapData = readLine()!.split(separator: " ").map { Int(String($0))! }
        mapData += [putMapData]
    }

    for i in 0..<rowRange {
        for j in 0..<columnRange {
            if mapData[i][j] == 1 && !visited[i][j] {
                islandCount += 1
                dfs2(startRow: i, startColumn: j, rowLimit: rowRange, columnLimit: columnRange)
            }
        }
    }
}

func dfs2(startRow: Int, startColumn: Int, rowLimit: Int, columnLimit: Int) {
    visited[startRow][startColumn] = true

    for i in 0..<8 {
        let nextRow = startRow + directionRow[i]
        let nextColumn = startColumn + directionColumn[i]

        if (0 <= nextRow && nextRow < rowLimit) && (0 <= nextColumn && nextColumn < columnLimit) {
            if mapData[nextRow][nextColumn] == 1 && !visited[nextRow][nextColumn] {
                dfs2(startRow: nextRow, startColumn: nextColumn, rowLimit: rowLimit, columnLimit: columnLimit)
            }
        }
    }
}

//BaekJoon Algorithm Study n.2178 (迷路探索) (BFS問題）　問題等級：Silver 1　重要度：🎖🎖🎖🎖🎖🎖🎖🎖

let mapSize = readLine()!.split(separator: " ").map { Int(String($0))! }
let rowSize = mapSize[0], columnSize = mapSize[1]
var map = [[Int]]()
let directionRow = [0, 0, -1, 1]
let directionColumn = [1, -1, 0, 0]

for _ in 0..<rowSize {
    let mapData = readLine()!
    map += [mapData.map { Int(String($0))! }]
}

var countResult = map

bfs_countingMove()
print(countResult[rowSize - 1][columnSize - 1])

func bfs_countingMove() {
    var visitedQueue = Array(repeating: Array(repeating: false, count: columnSize), count: rowSize)
    var needVisitQueue = [(0,0)]
    var index = 0
    visitedQueue[0][0] = true
    
    //ここで、index <= needVisitQueue.countにしちゃうと、例えば、index = 15 needVisitQueue.count = 15の時、needVisitQueueは[14]まであるのに、needVisitQueue[index = (15)]は index out of rangeになるため、 index < needVisitQueueが正しいコードである
    while index < needVisitQueue.count {
        let (currentRow, currentColumn) = needVisitQueue[index]
        
        if currentRow == rowSize && currentColumn == columnSize {
            break
        }
        
        for i in 0..<4 {
            let nextRow = currentRow + directionRow[i]
            let nextColumn = currentColumn + directionColumn[i]
            
            if (0 <= nextRow && nextRow < rowSize) && (0 <= nextColumn && nextColumn < columnSize) {
                if map[nextRow][nextColumn] == 1 && !visitedQueue[nextRow][nextColumn] {
                    visitedQueue[nextRow][nextColumn] = true
                    countResult[nextRow][nextColumn] += countResult[currentRow][currentColumn]
                    needVisitQueue.append((nextRow, nextColumn))
                }
            }
        }
        index += 1
    }
}

// ➡️📮ここからは、明日の復習になる
//BaekJoon Algorithm Study n.1697 (隠れんぼ)　問題等級：Silver 1　重要度：🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖


//BaekJoon Algorithm Study n.2468 (安全な領域) 重要度：🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖



//BaekJoon Algoithm Study n.2164 (カードのルール２)


//BaekJoon Algorithm Study n.7568 (図体)　Brute Force 重要度: 🎖🎖🎖🎖🎖
