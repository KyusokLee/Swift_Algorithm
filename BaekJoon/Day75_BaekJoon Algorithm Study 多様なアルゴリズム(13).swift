//
//  File.swift
//  BaekJoon
//
//  Created by Kyus'lee on 2022/05/15.
//

import Foundation
//Day 75 多様なアルゴリズム - (13)
//BaekJoon n.2632 (チーズ) 重要度: 🎖🎖🎖🎖🎖🎖🎖🎖🎖
// 0があるところ -> チーズない  ,  1があるところ -> チーズがある
// 🎖BFS +　実装問題
let data = readLine()!.split(separator: " ").map { Int(String($0))! }
let rowSize = data[0], columnSize = data[1]
let directionMove = [(0, 1), (0, -1), (1, 0), (-1, 0)] //東西南北
var map = [[Int]]()
var (allMeltedTime, resultCheeseCount) = (0, 0)
var cheeseList = [(Int, Int)]()

for i in 0..<rowSize {
    let input = readLine()!.split(separator: " ").map { Int(String($0))! }
    for j in 0..<columnSize {
        if input[j] == 1 {
            // 1(チーズがある場所を格納する)
            cheeseList.append((i, j))
        }
    }
    map += [input]
}

while !cheeseList.isEmpty {
    allMeltedTime += 1
    finding_OuterSpace(0, 0)
}

print("\(allMeltedTime)\n\(resultCheeseCount)")

//外の空間探し (チーズ中の0がある空間を探すわけではない) チーズ内の空間 : 0があるマスから東西南北全方向に１があり、囲まれている0
func finding_OuterSpace(_ row: Int, _ column: Int) {
    var neededVisitQueue = [(row, column)]
    var outerSpace = Array(repeating: Array(repeating: false, count: columnSize), count: rowSize)
    var index = 0
    outerSpace[0][0] = true

    while index < neededVisitQueue.count {
        let (currentRow, currentColumn) = neededVisitQueue[index]

        for i in 0..<4 {
            let (nextRow, nextColumn) = (currentRow + directionMove[i].0, currentColumn + directionMove[i].1)
            if nextRow < 0 || nextRow >= rowSize || nextColumn < 0 || nextColumn >= columnSize || outerSpace[nextRow][nextColumn] || map[nextRow][nextColumn] != 0 {
                continue
            }

            outerSpace[nextRow][nextColumn] = true
            neededVisitQueue.append((nextRow, nextColumn))
        }
        index += 1
    }
    return meltCheese(&outerSpace)
}

func meltCheese(_ checkedList: inout [[Bool]]) {
    resultCheeseCount = cheeseList.count
    let tempCheeseList = cheeseList
    var willDeleted = false
    cheeseList.removeAll()

    for (curRow, curColumn) in tempCheeseList {
        for next in directionMove {
            //問題文で橋の位置にはチーズが入ることはないと想定したので、index out of rangeのチェックをここでは考慮しなくて良い
            let (nextRow, nextColumn) = (curRow + next.0, curColumn + next.1)
            if checkedList[nextRow][nextColumn] {
                // ここでmapを０に変えても、checkedListには変化がないため、この関数内のBooleanチェックには影響を与えない
                map[curRow][curColumn] = 0
                willDeleted = true
                break
            } else {
                willDeleted = false
            }
        }
        if !willDeleted {
            cheeseList.append((curRow, curColumn))
        }
    }
}

//BaekJoon n.2668 (数字選び) 重要度: 🎖🎖🎖🎖🎖🎖🎖🎖🎖
// 🎖DFS + Cycle問題
//🌈考察: Cycle問題にあまりにも慣れてなくて、解き方がすぐ思いつかなかった -> Cycle問題を復習しておくこと

let numbers = Int(readLine()!)!
var array = [Int]() //配列の入っている値が、次に探索を始めるノードのindexである ex) array[0] = 3, -> array[3]を探索
var defaultVisited = Array(repeating: false, count: numbers)
var visited = defaultVisited

for _ in 0..<numbers {
    let input = Int(readLine()!)!
    array.append(input - 1)
}

for i in 0..<numbers {
    visited = defaultVisited
    visited[i] = true

    let countCheck = dfs_CycleFinding(current: array[i], from: i, count: 1)
    if countCheck > 0 {
        // ここのif文を maxメッソドではなく、0より大きいとき全部defaultVisitedを更新した理由は、 -> indexとそこに格納されている値が同じ時はcount = 1になり、maxメッソドを使うと、ここのif文に入ってこない
        //そのindexの部分をdefaultVisitedでTrueにしなければいけないから
        defaultVisited = visited
    }
}
//enumeated() == (index, value)のTupleのtypeになっている ただし、定義してないと、$0.0, $0.1にしかアクセスできない
// for (index, value) in defaultVisited.enumerated() { ... } なら、indexとvalueを使って配列の要素にアクセスできる

let result = defaultVisited.enumerated().filter { $0.1 == true }.map { Int($0.0) + 1 }

print(result.count)
result.forEach {
    print($0)
}

////以下のような方法も作成できる
//var result1 = [Int]()
//for i in 0..<numbers {
//    if defaultVisited[i] {
//        result1.append(i + 1)
//    }
//}
//print(result1.count)
//result1.forEach {
//    print($0)
//}

func dfs_CycleFinding(current idx: Int, from startIdx: Int, count: Int) -> Int {
    guard idx != startIdx else {
        // 現在調べている idx とstartIdxが同値であるなら、そのまま countをreturn
        // もしくは、indexと　格納されているvalueが同じ -> ex) array[5] = 5 のような
        return count
    }
    guard !visited[idx] else {
        //上記のfor文で既に探索し、候補として採択した値であるなら ( = trueになっているということ) そのまま return 0にする
        return 0
    }

    visited[idx] = true
    return dfs_CycleFinding(current: array[idx], from: startIdx, count: count + 1)
}

//BaekJoon n.1450 (ナップサック問題) 重要度: 🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖
// 🎖‼️HARD!! KnapSack + 二分探索 + meet in the middle方法
// ⚠️途中の段階
let data = readLine()!.split(separator: " ").map { Int(String($0))! }
let itemNums = data[0], weightLimit = data[1]
let itemArray = readLine()!.split(separator: " ").map { Int(String($0))! }
// itemのweightが同じであっても、それぞれのitemは違う種類であるため、同じ扱いにしないことを注意
// 何もカバンに入れてなくても weightLimitの以下であればそのケースも計算に入れること

var sumArrayA = [Int]()
var sumArrayB = [Int]()
//奇数であれば、sumArrayAの方が探索の範囲が小さい ex) 5つの要素であれば、 1 2 / sumB-> 3 4 5
partition(0, itemArray.count / 2, &sumArrayA, 0)
partition(itemArray.count / 2, itemArray.count, &sumArrayB, 0)
sumArrayB.sort() //二分探索は、sortしなくては有効ではないアルゴリズムであるため、昇順にソートしておく

//この関数の実装がかなり難しかった。。
func partition(_ index: Int, _ to: Int, _ array: inout [Int], _ sum: Int) {
    guard sum <= weightLimit else {
        return
    }
    guard index < to else {
        array.append(sum)
        return
    }
    partition(index + 1, to, &array, sum)
    partition(index + 1, to, &array, sum + itemArray[index])
}

func binarySearchUpperBounds(targetNum: Int, _ targetArray: [Int]) -> Int {
    var start = 0
    var end = targetArray.count - 1
    
    while start <= end {
        let middle = (start + end) / 2
        if targetNum < targetArray[middle] {
            end = middle - 1
        } else {
            start = middle + 1
        }
    }
    return start
}
