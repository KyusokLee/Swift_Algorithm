//
//  Day22_BaekJoon Algorithm Study 一週間の復習s.swift
//  BaekJoon
//
//  Created by Kyus'lee on 2022/03/01.
//

import Foundation

//Day 23: Week3: 一週間のアルゴリズムの整理と問題の復習 (2)
//BaekJoon Algorithm Study n.1697 (隠れんぼ)　問題等級：Silver 1　重要度：🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖
//contains  メッソドは時間超過になる可能性が高い.. この場合は、問題で示された範囲でtrue false配列を用いた方が処理時間をより効率的に減らすことができる

let data = readLine()!.split(separator: " ").map { Int(String($0))! }
let subin = data[0], sister = data[1]

bfs_findingSister()

func bfs_findingSister() {
    var visitedQueue = Array(repeating: false, count: 100001)
    var nextVisitQueue = [(subin, 0)]
    var index = 0
    visitedQueue[subin] = true

    while index < nextVisitQueue.count {
        let (currentVisit, time) = nextVisitQueue[index]
        if currentVisit == sister {
            print(time)
            break
        }

        let nextWay = [currentVisit - 1, currentVisit + 1, 2 * currentVisit]

        for next in nextWay {
            if 0 <= next && next <= 100000 && !visitedQueue[next] {
                nextVisitQueue.append((next, time + 1))
                visitedQueue[next] = true
            }
        }
        index += 1
    }
}

//BaekJoon Algorithm Study n.2468 (安全な領域) 重要度：🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖
let fieldSize = Int(readLine()!)!
var visited = [[Bool]]()
var rainedArea = [[Bool]]()
var rainLevel = 0
var maxFieldCount = 0
var field = [[Int]]()
var maxHeight = 0
let directionRow = [0, 0, -1 ,1]
let directionColumn = [1, -1, 0, 0]

for _ in 0..<fieldSize {
    let data = readLine()!.split(separator: " ").map { Int(String($0))! }
    field += [data]

    if maxHeight < data.max()! {
        maxHeight = data.max()!
    }
}

for _ in 0..<maxHeight {
    countingSafeArea(rainLimit: rainLevel)
    rainLevel += 1
}

print(maxFieldCount)

func countingSafeArea(rainLimit: Int) {
    visited = Array(repeating: Array(repeating: false, count: fieldSize), count: fieldSize)
    rainedArea = Array(repeating: Array(repeating: false, count: fieldSize), count: fieldSize)
    var areaCount = 0

    for i in 0..<fieldSize {
        for j in 0..<fieldSize {
            if field[i][j] <= rainLimit {
                rainedArea[i][j] = true
            }
        }
    }

    for i in 0..<fieldSize {
        for j in 0..<fieldSize {
            if !rainedArea[i][j] && !visited[i][j] {
                areaCount += 1
                dfs(startRow:i, startColumn: j)
            }
        }
    }

    if maxFieldCount < areaCount {
        maxFieldCount = areaCount
    }
}

func dfs(startRow: Int, startColumn: Int) {
    visited[startRow][startColumn] = true

    for i in 0..<4 {
        let nextRow = startRow + directionRow[i]
        let nextColumn = startColumn + directionColumn[i]

        if (0 <= nextRow && nextRow < fieldSize) && (0 <= nextColumn && nextColumn < fieldSize) {
            if !visited[nextRow][nextColumn] && !rainedArea[nextRow][nextColumn] {
                dfs(startRow: nextRow, startColumn: nextColumn)
            }
        }
    }
}

//BaekJoon Algoithm Study n.2164 (カードのルール２)
// 可能であれば、exit(0)を使わない方が処理時間を減らせる

let N = Int(readLine()!)!
if N == 1 {
    print("1")
} else {
    var Queue = Array(1...N)
    var headIndex = 0
    var count = N

    while count > 1 {
        headIndex += 1
        count -= 1
        Queue.append(Queue[headIndex])
        headIndex += 1
    }
    print(Queue.popLast()!)
}

//BaekJoon Algorithm Study n.7568 (図体)　Brute Force 重要度: 🎖🎖🎖🎖🎖
let peopleNum = Int(readLine()!)!
var peopleData = Array(repeating:Array(repeating: 0, count: 2), count: peopleNum)
var rankArr = Array(repeating: 0, count: peopleNum)

for i in 0..<peopleNum {
    let data = readLine()!.split(separator: " ").map { Int(String($0))! }
    peopleData[i] = data
}

for i in 0..<peopleNum {
    var rank = 1
    for j in 0..<peopleNum {
        if peopleData[i][0] < peopleData[j][0] && peopleData[i][1] < peopleData[j][1] {
            rank += 1
        }
    }
    rankArr[i] = rank
}

print(rankArr.map{ String($0) }.joined(separator: " "))

//BaekJoon Algorithm Study n.1463 (1にさせる) 重要度：🎖🎖🎖🎖🎖🎖🎖
// Dynamic Programming
//❗️このコードだと、エラーが発生する。。なぜだろう。。
func dp_make1() -> Int {
    let num = Int(readLine()!)!

    if num == 1 {
        return 0
    } else if num == 2 || num == 3 {
        return 1
    } else {
        var dp_arr = Array(repeating:0, count:num + 1)
        dp_arr[1] = 0
        dp_arr[2] = 1
        dp_arr[3] = 1

        for i in 4...num {
            // 6のような2にも３にも割り切れる数字はどっちに割っても同じ回数になる
            if i % 3 == 0 {
                dp_arr[i] = min(dp_arr[i / 3] + 1, dp_arr[i - 1] + 1)
                //ここの作業で１を足す理由は、作業の回数を求めるため、1を引いてから回した方がいいか、それとも、すぐ割ってから回した方が最小値になるかを判断し、配列に格納する
            } else if i % 2 == 0 {
                dp_arr[i] = min(dp_arr[i / 2] + 1, dp_arr[i - 1] + 1)
            } else if i % 6 == 0 {
                dp_arr[i] = min(dp_arr[i / 3] + 1, dp_arr[i / 2] + 1, dp_arr[i - 1] + 1)
            } else {
                // 11, 13のような数字は2にも3にも割り切れないため、１を引いてからする方法しかない
                dp_arr[i] = dp_arr[i - 1] + 1
            }
        }
        return dp_arr[num]
    }
}

print(dp_make1())

//方法２：再帰関数
let X = Int(readLine()!)!

func dp_make1(_ num: Int) -> Int {
    if num == 1 {
        return 0
    } else if num == 2 || num == 3 {
        return 1
    } else {
        return min(dp_make1(num / 2) + num % 2, dp_make1(num / 3) + num % 3) + 1
    }
}
print(dp_make1(X))

//方法３:再設計
let X = Int(readLine()!)!

func dp(_ num: Int) -> Int {
    if num == 1 {
        return 0
    } else if num == 2 || num == 3 {
        return 1
    } else {
        var dp_arr = Array(repeating:0, count: num + 1)
        dp_arr[1] = 0
        dp_arr[2] = 1
        dp_arr[3] = 1
        
        for i in 4...num {
            dp_arr[i] = dp_arr[i - 1] + 1
            if i % 2 == 0 {
                dp_arr[i] = min(dp_arr[i], dp_arr[i / 2] + 1)
            }
            //ここで、else ifじゃなく if を使った理由は、6のような場合は、どっちの方が回数が少ないか判断できないため、両方とも処理を通す必要があるからである
            if i % 3 == 0 {
                dp_arr[i] = min(dp_arr[i], dp_arr[i / 3] + 1)
            }
        }
        return dp_arr[num]
    }
}
print(dp(X))

//割り算の理解
let a = 4
let b = 5
let c = 6

print(a / 3 + a % 3)
print(b / 2)
print(b / 3)
print(c / 6)
// Int 型で割り算をすると、小数点を切り捨てた数字になる

//BaekJoon Algorithm Study n.7576 (トマト) Fisrt Gold Rate! 重要度:🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖
// 📮🌈やっと、ゴールドの等級の問題を解くようになった.. これからも精進していこう！🥰
// 🔥Very Hard🔥
//⚠️途中の段階
let boxSize = readLine()!.split(separator: " ").map { Int(String($0))! }
let column = boxSize[0], row = boxSize[1]
var boxData = [[Int]]()
var haveTomato = Array(repeating:Array(repeating: true, count: column), count: row)
var ripenTomato = Array(repeating:Array(repeating: false, count: column), count: row)
var visited = [[Bool]]()
let directionRow = [0, 0, -1, 1]
let directionColumn = [1, -1, 0, 0]
var result_Day = 1001

for _ in 0..<row {
    let tomatoes = readLine()!.split(separator: " ").map { Int(String($0))! }
    boxData += [tomatoes]
}

for i in 0..<row {
    for j in 0..<column {
        if boxData[i][j] == -1 {
            haveTomato[i][j] = false
        }
    }
}

for i in 0..<row {
    for j in 0..<column {
        if boxData[i][j] == 1 {
            bfs_CountDay(startRow: i, startColumn: j)
        }
    }
}

func bfs_CountDay(startRow: Int, startColumn: Int) {
    visited = Array(repeating: Array(repeating: false, count: column), count: row)
    var neededVisitQueue = [(startRow, startColumn)]
    var dayCount = 0, index = 0
    
    
}
