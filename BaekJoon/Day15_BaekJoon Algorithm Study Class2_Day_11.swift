//
//  Day14_BaekJoon Algorithm Study Class2 Day_10.swift
//  BaekJoon
//
//  Created by Kyus'lee on 2022/02/21.
//

import Foundation

//Day 15: DFS, BFSのアルゴリズムの整理と問題 (3)
//➡️昨日の復習

//BaekJoon Algorithm Study n.1012 (オーガニック白菜) 重要度：🎖🎖🎖🎖🎖🎖🎖🎖
//‼️HARD: 隣接リストとDFSをうまく使うこと、そして処理時間に注意してコードを設計しよう🔥

let testNum = Int(readLine()!)!
var directionX = [1, -1, 0, 0] // xの方角：東 西 南 北 (南と北にはxが動くことはないので、0に設定)
var directionY = [0, 0, -1, 1] // yの方角：東 西 南 北 (東と西にはyが動くことはないので、0に設定)
var visited = [[Bool]]()
var field = [[Int]]()
var larvaNum = 0

for _ in 0..<testNum {
    findLarva()
    print(larvaNum)
}

func DFS(x: Int, y: Int, xRange: Int, yRange: Int) {
    visited[x][y] = true
    for i in 0..<4 {
        let nextX = x + directionX[i]
        let nextY = y + directionY[i]

        if (0 <= nextX && nextX <= xRange) && (0 <= nextY && nextY <= yRange) {
            if field[nextX][nextY] == 1 && !visited[nextX][nextY] {
                DFS(x: nextX, y: nextY, xRange: xRange, yRange: yRange)
            }
        }
    }
}

func findLarva() {
    larvaNum = 0
    let data_cabbage = readLine()!.split(separator: " ").map { Int(String($0))! }
    let width = data_cabbage[0], height = data_cabbage[1], numbers = data_cabbage[2]
    field = Array(repeating: Array(repeating: 0, count: height), count: width)
    visited = [[Bool]](repeating: Array(repeating: false, count: height), count: width)

    //白菜が植えられた場所の設定
    for _ in 0..<numbers {
        let location = readLine()!.split(separator: " ").map { Int(String($0))! }
        field[location[0]][location[1]] = 1
    }

    //横のfor文を外部に、縦のfor文を内部に設定し、ミミズを投入
    for i in 0..<width {
        for j in 0..<height {
            if field[i][j] == 1 && !visited[i][j] {
                larvaNum += 1
                DFS(x: i, y: j, xRange: width - 1, yRange: height - 1)
            }
        }
    }
}

//BaekJoon Algorithm Study n.4963 （島の数) 重要度：🎖🎖🎖🎖🎖🎖🎖🎖
// ‼️⚠️斜めの要素の実現が難しい
var islandNum = 0
// xの方角：選択した座標を真ん中の位置に置いたと仮定した際の、北西座標から時計回りの座標に移動できるようにする方向値設定
let directionX = [-1, -1, -1, 0, 1, 1, 1, 0]
// yの方角：選択した座標を真ん中の位置に置いたと仮定した際の、北西座標から時計回りの座標に移動できるようにする方向値設定
let directionY = [-1, 0, 1, 1, 1, 0, -1, -1]

var visited = [[Bool]]()
var map = [[Int]]()

while true {
    let read_Case = readLine()!.split(separator: " ").map {Int(String($0))!}
    let width = read_Case[0], height = read_Case[1]
    finding_Island(width: width, height: height)
    print(islandNum)
}

// row: 行　column: 列
func DFS(row: Int, column: Int, rowRange: Int, columnRange: Int) {
    visited[row][column] = true

    for i in 0..<8 {
        let nextX = row + directionX[i]
        let nextY = column + directionY[i]

        if (0 <= nextX && nextX <= rowRange) && (0 <= nextY && nextY <= columnRange) {
            if map[nextX][nextY] == 1 && !visited[nextX][nextY] {
                DFS(row:nextX, column: nextY, rowRange: rowRange, columnRange: columnRange)
            }
        }
    }
}

func finding_Island(width: Int, height: Int) {
    guard width != 0 || height != 0 else { exit(0) }

    islandNum = 0
    visited = [[Bool]](repeating: Array(repeating: false, count: width), count: height)
    map = [[Int]](repeating: Array(repeating: 0, count: width), count: height)
    //今回は入力の例が 3 2 の場合　→  1 1 1, 1 1 1のような入力を受け取るので、内部の配列の数を行を意味、その中の要素数を列に設定
    //島の位置を設定 (入力の例題を見ると、縦の数ほど入力を受ける。また、横の数ほど、spaceを用いて数字の入力が可能となっている)
    for i in 0..<height {
        let island_read = readLine()!.split(separator: " ").map { Int(String($0))! }
        //行ごとのデータが入力される
        map[i] = island_read
    }

    //‼️🌈考察:　ここのfor文でもmap[i][j] == 1 && !visited[i][j]の調査をする理由は、DFSでvisitedにcheckをしてDFSの再帰関数が終わり、またここに戻ったとしても、ただのmap[i][j] == 1だけだと、islandNumが余計に+1足される。この演算を安全にするために、visitedのチェックをして関数を呼び出すこと！
    for i in 0..<height {
        for j in 0..<width {
            if map[i][j] == 1 && !visited[i][j] {
                islandNum += 1
                DFS(row: i, column: j, rowRange: height - 1, columnRange: width - 1)
            }
        }
    }
}

//BaekJoon Algorithm Study n.2178 (迷路探索) (BFS問題）　問題等級：Silver 1　重要度：🎖🎖🎖🎖🎖🎖🎖🎖
// (🔥😳🌈やっと、、silver1までくるとは、、これからも楽しく頑張ってみよう！）
// ⚠️途中の段階!! もう一度、どのように設計すればいいのか考えること！完全にスキルを使いこなせ流ようにしよう⭐️

let data_read = readLine()!.split(separator: " ").map { Int(String($0))! }
let row = data_read[0]
let column = data_read[1]
let directionX = [1, -1, 0, 0]  //xの方角：東 西 南 北 (南と北にはxが動くことはないので、0に設定)
let directionY = [0, 0, -1, 1]  //yの方角：東 西 南 北 (東と西にはyが動くことはないので、0に設定)
var maze = [[Int]]()
var count_Route = 0

for _ in 0..<row {
    maze.append(readLine()!.map { Int(String($0))! })
}

bfs_finding_route(y: row - 1, x: column - 1, yRange: row - 1, xRange: column - 1) //配列は0から始まるため、-1する
print(count_Route)

func bfs_finding_route(y: Int, x: Int, yRange: Int, xRange: Int) {
    let start = 0
    count_Route = 1
    var visited = [[Bool]](repeating:Array(repeating: false, count: x + 1), count: y + 1)
    var needVisitQueue = Array<(Int, Int)>()
    needVisitQueue.append((start, start))
    
    while !needVisitQueue.isEmpty {
        let pop_one = needVisitQueue.removeFirst()
        let y = pop_one.0
        let x = pop_one.1
        
        for i in 0..<4 {
            let nextY = y + directionY[i]
            let nextX = x + directionX[i]
            
            if (0 <= nextY && nextY <= xRange) && (0 <= nextX && nextX <= yRange) {
                if maze[nextY][nextX] == 1 && !visited[nextY][nextX] {
                    count_Route += 1
                    visited[nextY][nextX] = true
                    needVisitQueue.append((nextY, nextX))
                }
            }
        }
    }
}
