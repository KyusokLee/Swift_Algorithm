//
//  day62.swift
//  BaekJoon
//
//  Created by Kyus'lee on 2022/04/24.
//

import Foundation

//Day 62: アルゴリズム復習 - (2)
//BaekJoon n.13913 (かくれんぼ4)
//🎖BFS
let data = readLine()!.split(separator: " ").map { Int(String($0))! }
let subin = data[0], sister = data[1]
var visited = Array(repeating: -1, count: 100001)

bfs_findingSister4()

func bfs_findingSister4() {
    visited[subin] = 0
    var neededVisitQueue = [subin] // 現在の位置
    var index = 0

    while index < neededVisitQueue.count {
        let currentLocation = neededVisitQueue[index]

        if currentLocation == sister {
            var beforeRouteIdx = sister
            var routeArray = [sister]

            while beforeRouteIdx != subin {
                routeArray.append(visited[beforeRouteIdx])
                beforeRouteIdx = visited[beforeRouteIdx]
            }
            print(routeArray.count - 1) //最短経路で着いた時間の出力
            print(routeArray.reversed().map { String($0) }.joined(separator: " ")) //たどり着いた経路を出力
        }

        for nextLocate in [currentLocation - 1, currentLocation + 1, currentLocation * 2] {
            if nextLocate < 0 || nextLocate >= 100001 || visited[nextLocate] != -1 {
                continue
            }

            visited[nextLocate] = currentLocation
            neededVisitQueue.append(nextLocate)
        }

        index += 1
    }
}

//BaekJoon n.12851 (かくれんぼ2)
//🎖BFS (訪問した場所への再訪問が可能なアルゴリズム) _ Has Visited_Available to visit again and check
let data = readLine()!.split(separator: " ").map { Int(String($0))! }
let subin = data[0], sister = data[1]
var minTime = Array(repeating: -1, count: 100001) // indexの場所に着いた時間を格納する
var visitedCount = Array(repeating: 0, count: 100001) // indexの場所に訪問した回数

bfs_findingSister2()
print("\(minTime[sister])\n\(visitedCount[sister])")

func bfs_findingSister2() {
    minTime[subin] = 0
    visitedCount[subin] = 1
    var neededVisitQueue = [subin] // (現在の位置、着いた時間)のTuple型
    var index = 0

    while index < neededVisitQueue.count {
        let currentLocate = neededVisitQueue[index]

        for nextLocate in [currentLocate - 1, currentLocate + 1, currentLocate * 2] {
            if nextLocate < 0 || nextLocate >= 100001 {
                continue
            }

            if minTime[nextLocate] == -1 {
                //まだ、訪問してないところへ移動しようとする場合
                minTime[nextLocate] = minTime[currentLocate] + 1
                visitedCount[nextLocate] = visitedCount[currentLocate]
                neededVisitQueue.append(nextLocate)
            } else if minTime[nextLocate] == minTime[currentLocate] + 1 {
                //訪問したところへ移動しようとする場合 + 次に訪問しようとする場所が最短時間で行ける場合
                visitedCount[nextLocate] += visitedCount[currentLocate]
            }
        }

        index += 1
    }
}

//BaekJoon n.1937 (よくばりパンダ)
//🎖DFS
let mapSize = Int(readLine()!)!
var map = [[Int]]()
var dp = Array(repeating: Array(repeating: 0, count: mapSize), count: mapSize)
let directionMove = [(0, 1), (0, -1), (1, 0), (-1, 0)] //東西南北
var maxMove = 0

//データの格納
for _ in 0..<mapSize {
    map += [readLine()!.split(separator: " ").map { Int(String($0))! }]
}

for i in 0..<mapSize {
    for j in 0..<mapSize {
        maxMove = max(maxMove, dfs_PandaMove(i, j)) //maxMoveをdfsアルゴリズムを用いて更新していく
    }
}

print(maxMove)

func dfs_PandaMove(_ row: Int, _ column: Int) -> Int {
    //もし、すでにdpの値を更新した場所であれば、下記の探索を行わずにそのままreturnするのがよい -> なぜ？ : 指定した場所から移動できる最大マスの数をすでに値に格納したため、そのままreturnしても値の変化は生じない
    if dp[row][column] > 0 {
        return dp[row][column]
    }
    
    dp[row][column] = 1
    for i in directionMove {
        let (nextRow, nextColumn) = (row + i.0, column + i.1)
        if nextRow < 0 || nextRow >= mapSize || nextColumn < 0 || nextColumn >= mapSize {
            continue
        }
        
        if map[row][column] < map[nextRow][nextColumn] {
            //選択肢は複数であるため、maxメソッド用いたdfsアルゴリズムを使って、現在の位置から行ける最大のマスを求める
            // dfs_PandaMove(nextRow, nextColumn) + 1する理由は、現在位置も数えるため (dp配列を0に初期化したから)
            dp[row][column] = max(dp[row][column], dfs_PandaMove(nextRow, nextColumn) + 1)
        }
    }
    
    return dp[row][column]
}
