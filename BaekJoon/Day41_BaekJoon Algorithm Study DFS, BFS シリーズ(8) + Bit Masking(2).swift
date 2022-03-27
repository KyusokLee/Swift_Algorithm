//
//  Day41.swift
//  BaekJoon
//
//  Created by Kyus'lee on 2022/03/27.
//

import Foundation

//Day 41: BFS,DFS　シリーズ(8)
//BaekJoon Algorithm Study n.17141(研究室2) 重要度: 🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖
//高難度のBFS
// 組み合わせのアルゴリズム必要
//
// - - - 他の人のコードを参考した方法 - - -
let data = readLine()!.split(separator: " ").map { Int(String($0))! }
let mapSize = data[0], virusCount = data[1]
var map = [[Int]]()
var possibleVirus = [(Int, Int)]()
var virusReallyHave = [(Int, Int)]() // （行、列）
var result = 2501

for i in 0..<mapSize {
    map.append(readLine()!.split(separator: " ").map { Int(String($0))! })

    for j in 0..<mapSize {
        if map[i][j] == 2 {
            possibleVirus.append((i, j))
        }
    }
}

var checkVisit = Array(repeating: false, count: possibleVirus.count)
dfs_combination(0, 0)

if result == 2501 {
    print(-1)
} else {
    print(result)
}

//ここをまた、見直す必要がある
func dfs_combination(_ depth: Int, _ startIndex: Int) {
    if depth == virusCount {
        result = min(result, bfs_laboratoryVirus2(virusReallyHave))
        return
    }

    for i in startIndex..<possibleVirus.count {
        if !checkVisit[i] {
            checkVisit[i] = true
            virusReallyHave.append(possibleVirus[i])
            dfs_combination(depth + 1, i)
            checkVisit[i] = false
            virusReallyHave.removeLast()
        }
    }
}

//okay
func bfs_laboratoryVirus2(_ virusLocate: [(Int, Int)]) -> Int {
    let directionRow = [0, 0, 1, -1]
    let directionColumn = [1, -1, 0, 0]
    var visited = Array(repeating: Array(repeating: false, count: mapSize), count: mapSize)
    var tempResult = 0
    var index = 0
    var neededCheckQueue = [((Int, Int), Int)]()   // ((行, 列), 時間)

    for i in virusLocate {
        neededCheckQueue.append(((i.0, i.1), 0))
        visited[i.0][i.1] = true
    }

    while index < neededCheckQueue.count {
        let ((currentRow, currentColumn), timeCount) = neededCheckQueue[index]
        tempResult = timeCount

        for i in 0..<4 {
            let nextRow = currentRow + directionRow[i]
            let nextColumn = currentColumn + directionColumn[i]

            if nextRow < 0 || nextRow >= mapSize || nextColumn < 0 || nextColumn >= mapSize || visited[nextRow][nextColumn] {
                continue
            }
            if map[nextRow][nextColumn] == 1 {
                visited[nextRow][nextColumn] = true
                continue
            }

            visited[nextRow][nextColumn] = true
            neededCheckQueue.append(((nextRow, nextColumn), timeCount + 1))
        }
        index += 1
    }

    if checkMap(visited) {
        return tempResult
    } else {
        return 2501
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

//　🔥自分なりに改良したコード (完成版)
// 🌈📝考察 1. --> dfsの深さを表すdepthという変数一つだけで、関数を繰り返そうとしたのが、失敗だった。。
//           -->>> 理由: depthだけだと、もうすでに訪問したindexももう一度無駄に訪問したcheckの判別を行う
//           -->>> DFSは、深さと回すindexを設けた方が効率的であることを学んだ問題だった
// 🌈📝考察 2. --> typealiasは、処理時間に影響を与えないことに気づいた
//            --> 新しい配列と変数を作るより、dfs関数の中で、完結できるようなparameterを用いる方がより処理時間とメモリ量を節約することができた
//            --> 候補として選ばれなかったウイルス( 2が格納されているマス )をむりやり 0 に変える必要はなかった --> ただ、visitedを用いて操作すればいい(このアルゴリズムを実現するのにだいぶ時間を使ってしまった)


typealias Locate = (row: Int, column: Int, time: Int)
let data = readLine()!.split(separator: " ").map { Int(String($0))! }
let mapSize = data[0], virusCount = data[1]
var map = [[Int]]()
var possibleVirus = [Locate]() // （行、列）
var result = 2501

for i in 0..<mapSize {
    map.append(readLine()!.split(separator: " ").map { Int(String($0))! })

    for j in 0..<mapSize {
        if map[i][j] == 2 {
            possibleVirus.append((i, j, 0))
        }
    }
}

var checkVisit = Array(repeating: false, count: possibleVirus.count)
dfs_combination(0, 0, [])

if result == 2501 {
    print(-1)
} else {
    print(result)
}

//組み合わせアルゴリズム
func dfs_combination(_ depth: Int, _ startIndex: Int, _ selected: [Locate]) {
    if depth == virusCount {
        result = min(result, bfs_laboratoryVirus2(selected))
        return
    }

    for i in startIndex..<possibleVirus.count {
        if !checkVisit[i] {
            checkVisit[i] = true
            dfs_combination(depth + 1, i, selected + [possibleVirus[i]])
            checkVisit[i] = false
        }
    }
}

//okay
func bfs_laboratoryVirus2(_ virusLocate: [Locate]) -> Int {
    let directionRow = [0, 0, 1, -1]
    let directionColumn = [1, -1, 0, 0]
    var visited = Array(repeating: Array(repeating: false, count: mapSize), count: mapSize)
    var tempResult = 0
    var index = 0
    var neededCheckQueue = virusLocate

    for i in virusLocate {
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

            visited[nextRow][nextColumn] = true
            neededCheckQueue.append((nextRow, nextColumn, timeCount + 1))
        }
        index += 1
    }

    if checkMap(visited) {
        return tempResult
    } else {
        return 2501
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

//BaekJoon Algorithm Study n.17142 (研究室3)  重要度: 🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖
//高難度のBFS
// 組み合わせのアルゴリズム必要
// Xcode上では、反例を見つけられなかったが、BaekJoon Testerを回した結果反例があったようだ。。
typealias Locate = (row: Int, column: Int, time: Int)
let data = readLine()!.split(separator: " ").map { Int(String($0))! }
let mapSize = data[0], activeVirus = data[1]
var map = [[Int]]()
var possibleVirus = [Locate]()
var result = 2501
let directionRow = [0, 0, 1, -1]
let directionColumn = [1, -1, 0, 0]

for i in 0..<mapSize {
    map.append(readLine()!.split(separator: " ").map { Int(String($0))! })

    for j in 0..<mapSize {
        if map[i][j] == 2 {
            possibleVirus.append((i, j, 0))
        }
    }
}

var dfsCheckVisited = Array(repeating: false, count: possibleVirus.count)
dfs_combination2(0, 0, [])

if result != 2501 {
    print(result)
} else {
    print(-1)
}

func dfs_combination2(_ depth: Int, _ startIdx: Int, _ selected: [Locate]) {
    if depth == activeVirus {
        result = min(result, bfs_laboratoryVirus3(selected))
        return
    }
    for i in startIdx..<possibleVirus.count {
        if !dfsCheckVisited[i] {
            dfsCheckVisited[i] = true
            dfs_combination2(depth + 1, i, selected + [possibleVirus[i]])
            dfsCheckVisited[i] = false
        }
    }
}

func bfs_laboratoryVirus3(_ activatedVirus: [Locate]) -> Int {
    var visited = Array(repeating: Array(repeating: false, count: mapSize), count: mapSize)
    var tempResult = 0
    var index = 0
    var neededCheckQueue = activatedVirus

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

            visited[nextRow][nextColumn] = true
            neededCheckQueue.append((nextRow, nextColumn, timeCount + 1))
        }
        index += 1
    }

    if checkMap2(visited) {
        return tempResult
    } else {
        return 2501
    }
}

func checkMap2(_ checkVisit: [[Bool]]) -> Bool {
    for i in 0..<mapSize {
        for j in 0..<mapSize {
            if !checkVisit[i][j] && map[i][j] == 0 {
                return false
            }
        }
    }

    return true
}

//0があるところを最初から設定し、countを操作するコード
// 非活性化ウイルスがあるところもcountする必要があった！すなわち、0がある空間があるかどうかがこの問題のkey pointであった
//  - - - -　完成版 - - - -
// 　🌈📝考察: 先に0がある場所を数えて、個数の数を処理する方法が正しい解答だった

typealias Locate = (row: Int, column: Int, time: Int)
let data = readLine()!.split(separator: " ").map { Int(String($0))! }
let mapSize = data[0], activeVirus = data[1]
var map = [[Int]]()
var possibleVirus = [Locate]()
var result = 2501
let directionRow = [0, 0, 1, -1]
let directionColumn = [1, -1, 0, 0]
var emptyCount = 0

for i in 0..<mapSize {
    map.append(readLine()!.split(separator: " ").map { Int(String($0))! })

    for j in 0..<mapSize {
        if map[i][j] == 2 {
            possibleVirus.append((i, j, 0))
        }
        if map[i][j] == 0 {
            emptyCount += 1 //空いてるマスを数える変数
        }
    }
}

var dfsCheckVisited = Array(repeating: false, count: possibleVirus.count)
dfs_combination2(0, 0, [])

if result != 2501 {
    print(result)
} else {
    print(-1)
}

func dfs_combination2(_ depth: Int, _ startIdx: Int, _ selected: [Locate]) {
    if depth == activeVirus {
        result = min(result, bfs_laboratoryVirus3(selected))
        return
    }
    for i in startIdx..<possibleVirus.count {
        if !dfsCheckVisited[i] {
            dfsCheckVisited[i] = true
            dfs_combination2(depth + 1, i, selected + [possibleVirus[i]])
            dfsCheckVisited[i] = false
        }
    }
}

func bfs_laboratoryVirus3(_ activatedVirus: [Locate]) -> Int {
    var visited = Array(repeating: Array(repeating: false, count: mapSize), count: mapSize)
    var tempResult = 0
    var index = 0
    var neededCheckQueue = activatedVirus
    var tempCount = emptyCount

    for i in neededCheckQueue {
        visited[i.row][i.column] = true
    }

    while index < neededCheckQueue.count {
        let (currentRow, currentColumn, timeCount) = neededCheckQueue[index]
        tempResult = timeCount

        if map[currentRow][currentColumn] == 0 {
            tempCount -= 1
        }
        if tempCount == 0 {
            return tempResult
        }

        for i in 0..<4 {
            let nextRow = currentRow + directionRow[i]
            let nextColumn = currentColumn + directionColumn[i]

            if nextRow < 0 || nextRow >= mapSize || nextColumn < 0 || nextColumn >= mapSize || visited[nextRow][nextColumn] || map[nextRow][nextColumn] == 1 {
                continue
            }

            visited[nextRow][nextColumn] = true
            neededCheckQueue.append((nextRow, nextColumn, timeCount + 1))

        }
        index += 1
    }
    return 2501
}

//BaekJoon Algorithm Study n.2003 (数の和2) 重要度: 🎖🎖🎖🎖🎖🎖
// Important 必須問題 !🔥Two Pointer アルゴリズムの代表的な問題🔥

let data = readLine()!.split(separator: " ").map { Int(String($0))! }
let numCount = data[0], targetNum = data[1]
let numArray = readLine()!.split(separator: " ").map { Int(String($0))! }

twoPointer()

func twoPointer() {
    var startIdx = 0, endIdx = 0
    var result = 0
    var sum = 0

    while (endIdx <= numCount) {
        if sum >= targetNum {
            sum -= numArray[startIdx]
            startIdx += 1
        } else {
            if endIdx < numCount {
                sum += numArray[endIdx]
            }
            endIdx += 1
        }
        if sum == targetNum {
            result += 1
        }
    }
    print(result)
}

//DFS + Bit Masking アルゴリズム　高難度
//BaekJoon Algorithm Study n.1987 (アルファベット) 重要度: 🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖
//最大値を求めるアルゴリズムは、大体DFSアルゴリズムである
// 🔥Very Hard!!!🔥‼️
//この問題は、時間超過にならないようにするためには、Bit Maskingしかなかった。。
// アルファベット大文字のASCIIコードは、65 ~ 90までである   A = 65    a = 97
// << 左の方にshift演算   >> 右の方にshift演算

let data = readLine()!.split(separator: " ").map { Int(String($0))! }
let rowSize = data[0], columnSize = data[1]
let directionRow = [0, 0, 1, -1]
let directionColumn = [1, -1, 0, 0]
var map = [[Int]]()
var visited = Array(repeating: Array(repeating: false, count: columnSize),  count: rowSize)
var result = 0

for _ in 0..<rowSize {
    //大文字を全部Int型として格納する
    map.append(readLine()!.map { Int($0.asciiValue!) - 65 })
}

dfs_findingMaxRoute(0, 0, 1 << map[0][0], 1)
print(result)

func dfs_findingMaxRoute(_ rowStart: Int, _ columnStart: Int, _ alphabetBit: Int, _ count: Int) {
    result = max(result, count)

    for i in 0..<4 {
        let nextRow = rowStart + directionRow[i]
        let nextColumn = columnStart + directionColumn[i]

        if nextRow < 0 || nextRow >= rowSize || nextColumn < 0 || nextColumn >= columnSize {
            continue
        }

        //上記のif文を通過できたら、作った配列のindexの範囲を満たされるため、そのマスに移動できるということ!
        let n = 1 << map[nextRow][nextColumn] //次に移動するマスに格納されている数字をBit Maskingする

        //現在の位置にある Bit と次の位置の Bit が全く違う値である場合のみ、DFS探索を行う
        if n & alphabetBit == 0 {
            // AND演算子 ( = & 演算子) は、同じビットであれば、1を変換. 同じビットではないとき、0を変換
            dfs_findingMaxRoute(nextRow, nextColumn, alphabetBit | n, count + 1)
        }
    }

    result = max(result, count)
}

// 🔥IMPORTANT Bit Masking Operator　練習🔥
var testArray = [2, 3, 4, 5, 6]
let idx1 = 1 << testArray[0]
let idx2 = 1 << testArray[1]
let idx3 = 1 << testArray[2]
print(idx1)
print(idx2)
print(idx3)

if idx1 & idx2 == 0 {
    print("yes")
}

let a = 4
let b = 444
let c = a & b
print(c) // 共通の数字 4 が出力される

// 下記のif文は実行されない
if a & b == 1 {
    print("have same Bit") //共通である部分があるため、出力されない
}
// 完全に同じ値であれば　1(True) , 共通の部分が完全にないときは 0(False)  また、共通の部分があれば 0も1もならない

//共通の部分があるときは.....
if a & b != 1 {
    print("have same Bit") // 出力: have same Bit
}

if a & b != 0 {
    print("have same Bit") // 出力: have same Bit
}

let d = 44
let e = 444
let dANDe = d & e
print(dANDe) //44が出力される

// OR 演算子 ( | 演算子 ) は、二つのBitを結合する演算子である

// ex) 101 (5) OR 1000 (8) = 1101 (13)
let practiceBit1 = 5
let practiceBit2 = 8
let Bit1ORBit2 = practiceBit1 | practiceBit2
print(Bit1ORBit2) //13が出力される

// ex) 111 (7) OR 100 (4) = 111 (7)
let pracBit3 = 7
let pracBit4 = 4
let prac3OR4 = pracBit3 | pracBit4
print(prac3OR4) //7が出力される
