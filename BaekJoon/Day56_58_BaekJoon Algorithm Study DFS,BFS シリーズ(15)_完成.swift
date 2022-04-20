//
//  Day56_58_.swift
//  BaekJoon
//
//  Created by Kyus'lee on 2022/04/20.
//

import Foundation

//Day 56 ~ Day 58 BFS,DFS シリーズ(15) - 完成
//BaekJoon Algorithm Study n.12851 (かくれんぼ3) 重要度: 🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖
// 🔥Hard!!
// ⚠️途中の段階
// かくれんぼ4と似たような問題 (🌈考察: visited[目的地]の部分だけ再訪問できるように設計すること)
// 訪問した場所ももう一回訪問する必要がある問題
// 例は正しく実行されたが、反例があるようだ！
let data = readLine()!.split(separator: " ").map { Int(String($0))! }
let subin = data[0], sister = data[1]
var visited = Array(repeating: false, count: 100001)
var neededCheckQueue = [(subin, 0)]
var resultTime = 0

bfs_findingSister2(subin, sister)
print(resultTime)
print(neededCheckQueue.filter { $0 == (sister, resultTime) }.count)

func bfs_findingSister2(_ start: Int, _ destination: Int) {
    visited[start] = true
    var index = 0

    while index < neededCheckQueue.count {
        let (curLocate, time) = neededCheckQueue[index]
        if curLocate == destination {
            resultTime = time
            break
        }

        for i in [curLocate - 1, curLocate + 1, curLocate * 2] {
            let nextLocate = i

            if nextLocate < 0 || nextLocate >= 100001 || visited[nextLocate] {
                continue
            }

            neededCheckQueue.append((nextLocate, time + 1))
            visited[nextLocate] = true

            if nextLocate == destination {
                visited[nextLocate] = false
            }
        }
        index += 1
    }
}

// また、反例がでたコード
// BFS関数使用せず！
// ⚠️途中の段階
let data = readLine()!.split(separator: " ").map { Int(String($0))! }
let subin = data[0], sister = data[1]
var visited = Array(repeating: -1, count: 100001)
var neededCheckQueue = [(subin, 0)]
var minTime = 98765432
var index = 0
visited[subin] = 0

while index < neededCheckQueue.count {
    let (curLocate, time) = neededCheckQueue[index]

    if curLocate == sister {
        if minTime > time {
            minTime = time
        }
    }

    if time > minTime {
        break
    }

    for i in [curLocate - 1, curLocate + 1, curLocate * 2] {
        let nextLocate = i

        if nextLocate < 0 || nextLocate >= 100001 || visited[nextLocate] != -1 {
            continue
        }

        visited[nextLocate] = curLocate
        neededCheckQueue.append((nextLocate, time + 1))

        if nextLocate == sister {
            visited[nextLocate] = -1
        }
    }

    index += 1
}

print(minTime)
print(neededCheckQueue.filter { $0.0 == sister && $0.1 == minTime }.count)

//エラーが出ないコード
let data = readLine()!.split(separator: " ").map { Int(String($0))! }
let subin = data[0], sister = data[1]
var minTime = Array(repeating: -1, count: 100001)
var allCount = Array(repeating: 0, count: 100001)
var placeData = Array(repeating: (-1, 0), count: 100001) //　(最短時間, 到着した回数)

bfs_findingSister2(subin)
print(placeData[sister].0)
print(placeData[sister].1)

func bfs_findingSister2(_ start: Int) {
    var neededVisitQueue = [start]
    var index = 0
    placeData[start].0 = 0 //　start地点に着いた時間は、もちろん0秒でしょう
    placeData[start].1 = 1 // start地点に到着した回数は、１回であることがわかる

    while index < neededVisitQueue.count {
        let curLocate = neededVisitQueue[index]
        index += 1

        for nextLocate in [curLocate - 1, curLocate + 1, curLocate * 2] {
            if 0 <= nextLocate && nextLocate <= 100000 {
                if placeData[nextLocate].0 == -1 {
                    //まだ、visitedしていない場所であれば...
                    placeData[nextLocate].0 = placeData[curLocate].0 + 1 // その場所に到着する最短時間は、現在の位置から１秒たした時間
                    placeData[nextLocate].1 = placeData[curLocate].1 //そこに到着した回数は、現在位置に到着した回数と同値
                    neededVisitQueue.append(nextLocate)
                } else if placeData[nextLocate].0 == placeData[curLocate].0 + 1 {
                    //もう既に、visitedした場所であれば...
                    placeData[nextLocate].1 += placeData[curLocate].1
                    // neededVisitQueueに追加的に格納する必要はない! -> なぜなら、追加してしまうと、探索する範囲が大きくなり、与えられたデータの限界値が多いほど、時間がかかるため、非効率的である。
                }
            }
        }
    }
}

// もう少し、処理時間を短くできたコード
let data = readLine()!.split(separator: " ").map { Int(String($0))! }
let subin = data[0], sister = data[1]
var minTime = Array(repeating: -1, count: 100001) //最短時間
var visitCount = Array(repeating: 0, count: 100001) // 最短時間で訪問した回数

bfs_findingSister2(subin)
print("\(minTime[sister])\n\(visitCount[sister])")

func bfs_findingSister2(_ start: Int) {
    minTime[start] = 0 //　start地点に着いた時間は、もちろん0秒でしょう
    visitCount[start] = 1 // start地点に到着した回数は、１回であることがわかる
    var neededVisitQueue = [start]
    var index = 0
    
    while index < neededVisitQueue.count {
        let curLocate = neededVisitQueue[index]
        
        for nextLocate in [curLocate - 1, curLocate + 1, curLocate * 2] {
            if nextLocate < 0 || nextLocate >= 100001 {
                continue
            }
            
            if minTime[nextLocate] == -1 {
                // not Visit
                minTime[nextLocate] = minTime[curLocate] + 1
                visitCount[nextLocate] = visitCount[curLocate]
                neededVisitQueue.append(nextLocate)
            } else if minTime[nextLocate] == minTime[curLocate] + 1 {
                // has already visited
                visitCount[nextLocate] += visitCount[curLocate]
            }
        }
        index += 1
    }
}
