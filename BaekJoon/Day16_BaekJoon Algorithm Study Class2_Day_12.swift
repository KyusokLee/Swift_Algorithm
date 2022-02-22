//
//  Day 16.swift
//  BaekJoon
//
//  Created by Kyus'lee on 2022/02/22.
//

import Foundation

//Day 16: DFS, BFSのアルゴリズムの整理と問題 (4)
//➡️昨日の復習

//BaekJoon Algorithm Study n.2178 (迷路探索) (BFS問題）　問題等級：Silver 1　重要度：🎖🎖🎖🎖🎖🎖🎖🎖
// (🔥😳🌈やっと、、silver1までくるとは、、これからも楽しく頑張ってみよう！）
// ⚠️途中の段階!! もう一度、どのように設計すればいいのか考えること！完全にスキルを使いこなせ流ようにしよう⭐️

let data_read = readLine()!.split(separator: " ").map { Int(String($0))! }
let row = data_read[0] //行
let column = data_read[1] //列
var distance = Array(repeating: Array(repeating: 0, count: column), count: row)
let directionX = [1, -1, 0, 0]  //xの方角：東 西 南 北 (南と北にはxが動くことはないので、0に設定)
let directionY = [0, 0, -1, 1]  //yの方角：東 西 南 北 (東と西にはyが動くことはないので、0に設定)
var maze = [[Int]]()
var count_Route = 1

for _ in 0..<row {
    maze.append(readLine()!.map { Int(String($0))! })
}

bfs_finding_route(y: row - 1, x: column - 1, yRange: row - 1, xRange: column - 1) //配列は0から始まるため、-1する
print(distance[row - 1][column - 1])

func bfs_finding_route(y: Int, x: Int, yRange: Int, xRange: Int) {
    let start = 0
    var visited = [[Bool]](repeating:Array(repeating: false, count: x + 1), count: y + 1)
    var needVisitQueue = Array<(Int, Int)>()
    needVisitQueue.append((start, start))
    distance[0][0] = 1
    visited[0][0] = true

    while !needVisitQueue.isEmpty {
        let pop_one = needVisitQueue.removeFirst()
        let y = pop_one.0
        let x = pop_one.1

        for i in 0..<4 {
            let nextY = y + directionY[i]
            let nextX = x + directionX[i]

            if (0 <= nextY && nextY <= yRange) && (0 <= nextX && nextX <= xRange) {
                if maze[nextY][nextX] == 1 && !visited[nextY][nextX] {
                    visited[nextY][nextX] = true
                    distance[nextY][nextX] = distance[y][x] + 1
                    needVisitQueue.append((nextY, nextX))
                }
            }
        }
    }
}

//‼️🌈考察:　distance　(距離)を表すコードの表現方法について、学ぶことができた。今度、このような問題、もしくは距離を導入しなければならない問題に遭遇した時、この表現方法を活かしていこう🔥

//BaekJoon Algorithm Study n.2667 (団地番号付け) (DFS問題）　問題等級：Silver 1　重要度：🎖🎖🎖🎖🎖🎖🎖🎖
//⚠️すべてを関数の定義内にまとめ込み、その中で動作するようにコードを作成しないこと
//⚠️思考を広く柔軟にする習慣をつけよう
// 🌈９割以上、自力で解いたので気持ちいい⭕️🥰

let map_size = Int(readLine()!)!
var map = [[Int]]()
let directionX = [1, -1, 0, 0] //東西南北
let directionY = [0, 0, -1, 1] //東西南北
var visited = [[Bool]](repeating: Array(repeating: false, count: map_size), count: map_size)
var house_District = [Int]() // 配列の特性を考えて、団地の番号が１だったら、[0]を指す
var number_District = 0
var house_count = 0

//家がmapの座標上、どこにあるかを入力
for _ in 0..<map_size {
    map.append(readLine()!.map { Int(String($0))! })
}

//家があるとこを見つけ、DFS探索を実施
for i in 0..<map_size {
    for j in 0..<map_size {
        if !visited[i][j] && map[i][j] == 1 {
            number_District += 1
            house_count = 1
            DFS_numbering(row: i, column: j, rowRange: map_size - 1, columnRange: map_size - 1)
            house_District.append(house_count)
            house_count = 0
        }
    }
}

house_District.sort()

print(number_District)
for i in 0..<house_District.count {
    print(house_District[i])
}

func DFS_numbering(row: Int, column: Int, rowRange: Int, columnRange: Int) {
    visited[row][column] = true

    for i in 0..<4 {
        let nextRow = row + directionY[i]
        let nextColumn = column + directionX[i]

        if (0 <= nextRow && nextRow <= rowRange) && (0 <= nextColumn && nextColumn <= columnRange) {
            if map[nextRow][nextColumn] == 1 && !visited[nextRow][nextColumn] {
                house_count += 1
                DFS_numbering(row: nextRow, column: nextColumn, rowRange: rowRange, columnRange: columnRange)
            }
        }

    }
}

//BaekJoon Algorithm Study n.1697 (隠れんぼ)　問題等級：Silver 1　重要度：🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖
//最短経路を求めるのと同じだから、BFS探索が望ましい
// ⚠️❗️🎖 DIFFICULT  かなり難しい問題 🎖
// ⚠️‼️途中の段階

let location_data = readLine()!.split(separator: " ").map { Int(String($0))! }
let subin = location_data[0]
let sister = location_data[1]
var currentVisitQueue: [(Int, Int)] = [(subin, 0)]
var idx = 0
var time = 0

print(BFS_findSister(currentLocation: subin, destination: sister))

func BFS_findSister(currentLocation: Int, destination: Int) -> Int {
    var visited = [Int]()
    let currentVisit = currentLocation
    var isFound = false
    var time_count = 0
    
    if currentLocation == destination {
        print(time)
        exit(0)
    } else {
        while true {
            let (currentVisit, time) = currentVisitQueue[idx]
            idx += 1
            var nextVisit = 0
            
            for i in 0..<3 {
                if i == 0 { nextVisit = currentVisit - 1 }
                else if i == 1 { nextVisit = currentVisit + 1 }
                else { nextVisit = currentVisit * 2 }
                
                if nextVisit < 0 || nextVisit > 100000 || visited.contains(nextVisit) {
                    continue
                }
                
                if nextVisit == destination {
                    isFound = true
                    break
                }
                
                visited.append(nextVisit)
                currentVisitQueue.append((nextVisit, time + 1))
                time_count = time
            }
            if isFound {
                break
            }
        }
    }
    
    return time_count + 1
}

//Queueの定義とそのQueueを用いて解いた方法
