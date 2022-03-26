//
//  Day40.swift
//  BaekJoon
//
//  Created by Kyus'lee on 2022/03/26.
//

import Foundation

// Day40: DFS、BFS シリーズ (7)

// ⭐️‼️必修問題: BFSを用いて、単純に最短の時間を表すだけではなく、経路も一緒に求める問題
//BaekJoon Algorithm Study n.13913 (かくれんぼ -(4)) 重要度: 🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖
// 🔥Very Very Hard‼️🔥
//順列アルゴリズムを用いることが可能でありそう！！
//DFSで経路を探索すると、Time Over になってしまう

var visited = Array(repeating: false, count: 100001)
var dp = Array(repeating: -1, count: 100001)
let data = readLine()!.split(separator: " ").map { Int(String($0))! }
let subin = data[0], sister = data[1]
var neededCheckQueue: [(locate: Int, time: Int)] = [(subin, 0)]
var result = 0, time = 0
visited[subin] = true
dp[subin] = 0

bfs_findingSister4()

var filterArray = dp.enumerated().filter { $0.1 != -1 && $0.1 < result }.map { ($0.1, $0.0) }.sorted(by: { $0.0 < $1.0 })
filterArray.append((result, sister))

while true {
    var routeArray = [Int]()

    if time == result && routeArray.last == sister {
        print(result)
        print(routeArray.map { String($0) }.joined(separator: " "))
        exit(0)
    }

    for i in 0...result {
        let choose = filterArray.filter {$0.0 == i}

        for j in choose {
            routeArray.append(j.1)

        }


    }
}


print(result)
print(filterArray)

func dfs_route() {



}

func bfs_findingSister4() {
    var index = 0

    while index < neededCheckQueue.count {
        let (currentLocate, timeCount) = neededCheckQueue[index]

        if currentLocate == sister {
            result = timeCount
            break
        }

        for i in [currentLocate - 1, currentLocate + 1, currentLocate * 2] {
            if i < 0 || i >= 100000 {
                continue
            }

            if !visited[i] && dp[i] == -1 {
                visited[i] = true
                dp[i] = timeCount + 1
                neededCheckQueue.append((i, timeCount + 1))
            }
        }
        index += 1
    }
}

//他の人のコード参考
// ‼️必ず、復習しておくこと！‼️
// 🔥必須アルコリズム: 🔥
let inp = readLine()!.split(separator: " " ).map{Int(String($0))!}
let Subin = inp[0], Sister = inp[1]
let MX = 100000
var dp2 = Array(repeating: -1, count: MX + 1) //前の位置を格納する配列
dp2[Subin] = 0 // 最初のスタート点の前は、ないため0にした
var neededCheckQueue2 = [Subin]
var index = 0

while index < neededCheckQueue2.count {
    let currentLocation = neededCheckQueue2[index]

    //⚠️ここのアルゴリズムが難しかった‼️
    if currentLocation == Sister {
        //必ず、妹の位置からスタートする必要がある。 --> 理由: dp2の配列は、前にどんな経路を経て現在位置(indexが位置を表す)に着いたか前の経路を格納しておいた
//        そのため、妹がいるところまで達することができたということは、最短経路で着いたということであるため、そこに格納された位置を逆に遡ればSubinがいるところまで案内してくれるはず。すなわち、逆追跡するというアルゴリズムである。
        var ans = [Sister]
        var beforeLocate = Sister

        while beforeLocate != Subin {
            ans.append(dp2[beforeLocate])
            beforeLocate = dp2[beforeLocate]
        }

        print(ans)
        var str = ""
        ans.reversed().forEach {
            str += String($0) + " "
        }
        str.removeLast()
        print(ans.count-1)
        print(str)
        print(dp2)
        break
    }

    let chooseList = [currentLocation + 1, currentLocation - 1, currentLocation * 2]

    chooseList.forEach {
        if (0...MX).contains($0) && dp2[$0] == -1 {
            dp2[$0] = currentLocation
            neededCheckQueue2.append($0)
        }
    }
    index += 1
}

// ******** 📝完成版 *********
//🌈‼️考察今回に関しては、私が今まで解いてきた方法と違い、neededCheckQueueをtuple形跡で設定し、その中で最短時間を探すというアルゴリズムではなく、routeVisitedだけを更新しながら、sisterの位置に着いたら、逆追跡するというアルゴリズムを使った
//       訪問するかどうかの配列を必ずBoolタイプだけで作ろうとする習慣を捨てよう！
//       もちろんBool タイプがデータ処理やメモリ使用時に節約できるというメリットはあるが、必要によってはBool タイプではなく
//       Int タイプの配列を作ろうとするアルゴリズムの設計が必須である。
let data = readLine()!.split(separator: " ").map { Int(String($0))! }
let subin = data[0], sister = data[1]
var routeVisited = Array(repeating: -1, count: 100001)
var neededCheckQueue = [subin]

bfs_findingSister4()

func bfs_findingSister4() {
    routeVisited[subin] = 0
    var index = 0

    while index < neededCheckQueue.count {
        let currentLocate = neededCheckQueue[index]

        if currentLocate == sister {
            var backTrackArray = [sister]
            var beforeLocate = sister

            while beforeLocate != subin {
                backTrackArray.append(routeVisited[beforeLocate]) //先に配列に格納しないと、beforeLocate が先にsubinになる可能性があり得る
                beforeLocate = routeVisited[beforeLocate]
            }
            print(backTrackArray.count - 1)
            print(backTrackArray.reversed().map { String($0) }.joined(separator: " "))
            break
        }

        for i in [currentLocate + 1, currentLocate - 1, currentLocate * 2] {
            if (0...100000).contains(i) && routeVisited[i] == -1 {
                routeVisited[i] = currentLocate
                neededCheckQueue.append(i)
            }
        }
        index += 1
    }
}

//BaekJoon Algorithm Study n.11060(Jump Jump!) 重要度:🎖🎖🎖🎖
// BFSを用いたコード
let size = Int(readLine()!)!
let start = 0, destination = size - 1
let maze = readLine()!.split(separator: " ").map { Int(String($0))! }
var visited = Array(repeating: false, count: size)
var neededCheckQueue: [(locate: Int, time: Int)] = [(start, 0)]
var result = 0
visited[start] = true

bfs_jump()

if !visited[destination] {
    print(-1)
} else {
    print(result)
}

func bfs_jump() {
    var index = 0

    while index < neededCheckQueue.count {
        let (currentLocate, timeCount) = neededCheckQueue[index]
        let canJump = maze[currentLocate]

        if currentLocate == destination {
            result = timeCount
            break
        }

        for i in 0...canJump {
            let nextLocate = currentLocate + i

            if nextLocate < 0 || nextLocate >= size || visited[nextLocate] {
                continue
            }

            visited[nextLocate] = true
            neededCheckQueue.append((nextLocate, timeCount + 1))
        }
        index += 1
    }
}

//DPを用いたコード (動的計画法)
let size = Int(readLine()!)!
let start = 0, destination = size - 1
let arr = readLine()!.split(separator: " ").map { Int(String($0))! }
var dp = Array(repeating: size, count: size)
dp[start] = 0

for i in 0...size - 1 {
    for j in stride(from: 0, through: arr[i], by: 1) {
        if i + j <= size - 1 {
            dp[i + j] = min(dp[i] + 1, dp[i + j])
        }
    }
}

if dp[destination] == size {
    print(-1)
}else {
    print(dp[destination])
}

//BaekJoon Algorithm Study n.17141(研究室2) 重要度: 🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖
//高難度のBFS
// 組み合わせのアルゴリズム必要
// ❗️時間超過になってしまったコード
//ここで、また新しく配列をコピーしたのが多分時間超過の理由だと思ってる
// ⚠️途中の段階

typealias Locate = (row: Int, column: Int, time: Int)
let data = readLine()!.split(separator: " ").map { Int(String($0))! }
let mapSize = data[0], virusCount = data[1]
var map = [[Int]]()
var possibleVirus: [Locate] = []
var result = 2501
let directionRow = [0, 0, 1, -1]
let directionColumn = [1, -1, 0, 0]

for i in 0..<mapSize {
    map += [readLine()!.split(separator: " ").map { Int(String($0))! }]
    
    for j in 0..<mapSize {
        if map[i][j] == 2 {
            possibleVirus.append((i, j, 0))
        }
    }
}

var checkVisit = Array(repeating: false, count: possibleVirus.count)
dfs_combination(0, [])

if result == 2501 {
    print(-1)
} else {
    print(result)
}

//ここをまた、見直す必要がある
func dfs_combination(_ depth: Int, _ selected: [Locate]) {
    if depth == virusCount {
        result = min(result, bfs_laboratoryVirus2(selected))
        return
    } else {
        for i in depth..<possibleVirus.count {
            if !checkVisit[i] {
                checkVisit[i] = true
                dfs_combination(depth + 1, selected + [possibleVirus[i]])
                checkVisit[i] = false
            }
        }
    }
}

//okay
func bfs_laboratoryVirus2(_ virusLocate: [Locate]) -> Int {
    var visited = Array(repeating: Array(repeating: false, count: mapSize), count: mapSize)
    var tempResult = 0
    var index = 0
    var neededCheckQueue = virusLocate
    
    for i in neededCheckQueue {
        visited[i.row][i.column] = true
    }
    
    while index < neededCheckQueue.count {
        let (currentRow, currentColumn, timeCount) = neededCheckQueue[index]
        tempResult = timeCount
        
        for i in 0..<4 {
            let nextRow = currentRow + directionRow[i]
            let nextColumn = currentColumn + directionColumn[i]
            
            if nextRow < 0 || nextRow >= mapSize || nextColumn < 0 || nextColumn >= mapSize || visited[nextRow][nextColumn] || map[nextRow][nextColumn] == 1 {
                continue
            }
            
            if map[nextRow][nextColumn] != 1 {
                visited[nextRow][nextColumn] = true
                neededCheckQueue.append((nextRow, nextColumn, timeCount + 1))
            }
        }
        index += 1
    }
    
    if !checkMap(visited) {
        return 2501
    } else {
        return tempResult
    }
}

//okay
func checkMap(_ checkVisit: [[Bool]]) -> Bool {
    for i in 0..<mapSize {
        for j in 0..<mapSize {
            if !checkVisit[i][j] && map[i][j] != 1 {
                return false
            }
        }
    }
    
    return true
}


