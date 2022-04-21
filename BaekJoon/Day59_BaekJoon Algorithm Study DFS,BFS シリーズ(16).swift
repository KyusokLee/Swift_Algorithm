//
//  Day59.swift
//  BaekJoon
//
//  Created by Kyus'lee on 2022/04/20.
//

import Foundation

//Day 59 BFS, DFS シリーズ (16)
//BaekJoon Algorithm Study n.13549 (かくれんぼ3) 重要度: 🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖
let data = readLine()!.split(separator: " ").map { Int(String($0))! }
let subin = data[0], sister = data[1]
var minTime = Array(repeating: -1, count: 100001)

bfs_findingSister3(subin)
print(minTime[sister])

func bfs_findingSister3(_ start: Int) {
    var neededCheckQueue = [start]
    var index = 0
    minTime[start] = 0

    while index < neededCheckQueue.count {
        let curLocate = neededCheckQueue[index]

        if 0 <= curLocate * 2 && curLocate * 2 <= 100000 {
            // 最初に空間移動できる場所に着く時間を格納する
            if minTime[curLocate * 2] == -1 {
                // 訪問したことないとこだったら、Queueに格納し、minTimeも操作する
                neededCheckQueue.append(curLocate * 2)
                minTime[curLocate * 2] = minTime[curLocate]
            }
        }

        for next in [curLocate - 1, curLocate + 1] {
            if next < 0 || next >= 100001 {
                continue
            }

            if minTime[next] == -1 {
                // not visit
                minTime[next] = minTime[curLocate] + 1
                neededCheckQueue.append(next)
            }
        }

        index += 1
    }
}

//他の書き方
let len = 100000
let data = readLine()!.split(separator: " ").map{ Int(String($0))! }
let (subin, sister) = (data[0], data[1])
var answer = Int.max

bfs_findingSister3()
print(answer)

func bfs_findingSister3() {
    var time = Array(repeating: -1, count: len + 1)
    time[subin] = 0
    var neededVisitQueue = [subin]
    var index = 0

    while index < neededVisitQueue.count {
        let now = neededVisitQueue[index]
        index += 1

        if time[now] >= answer {
            continue
        }

        if now == sister {
            answer = min(answer, time[now])
            continue
        }
        
        for next in [now - 1, now + 1] {
            if (0...len).contains(next) {
                if time[next] == -1 {
                    time[next] = time[now] + 1
                    neededVisitQueue.append(next)
                } else if time[next] > time[now] + 1 {
                    time[next] = time[now] + 1
                    neededVisitQueue.append(next)
                }
            }
        }

        for next in [now * 2] {
            if (0...len).contains(next) {
                if time[next] == -1 {
                    // not visit
                    time[next] = time[now]
                    neededVisitQueue.append(next)
                } else if time[next] > time[now] {
                    time[next] = time[now]
                    neededVisitQueue.append(next)
                }
            }
        }
    }
}

// 方法2 : Dijkstra アルゴリズム, 0-1bfsアルゴリズムの活用

