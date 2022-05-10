//
//  Day71.swift
//  BaekJoon
//
//  Created by Kyus'lee on 2022/05/08.
//

import Foundation

//Day 71 多様なアルゴリズム - (9)
//BaekJoon n.11727 (2 x n タイル2) 重要度: 🎖🎖🎖🎖🎖
// 🎖‼️ DP -> ある規則を探すのが大事
let n = Int(readLine()!)!
var dp = [Int](repeating: 0, count: n + 1)
dp[1] = 1
dp[2] = 3

if n == 1 {
    print(dp[1])
} else if n == 2 {
    print(dp[2])
} else {
    for i in 3...n {
        dp[i] = (dp[i - 1] + 2 * dp[i - 2]) % 10007
    }

    print(dp[n])
}

//BaekJoon n.18429 (筋肉損失) 重要度: 🎖🎖🎖🎖🎖
// 🎖Brute Force + Back Tracking
let data = readLine()!.split(separator: " ").map { Int(String($0))! }
let days = data[0], muscleDecreasePerDay = data[1]
let exerciseKit = readLine()!.split(separator: " ").map { Int(String($0))! }
var visited = [Bool](repeating: false, count: days)
var caseCounts = 0

dfs_permutation(0, [])
print(caseCounts)

func dfs_permutation(_ choice: Int, _ currentKit: [Int]) {
    if choice == days {
        if calculate_muscleCapacity(currentKit) {
            caseCounts += 1
            return
        }
    } else {
        for i in 0..<exerciseKit.count {
            if !visited[i] {
                visited[i] = true
                dfs_permutation(choice + 1, currentKit + [exerciseKit[i]])
                visited[i] = false
            }
        }
    }
}

func calculate_muscleCapacity(_ selectedKit: [Int]) -> Bool {
    let mappedKit = selectedKit.map { $0 - muscleDecreasePerDay }
    var capacity = 500

    for i in mappedKit {
        capacity += i
        if capacity < 500 {
            return false
        }
    }

    return true
}

//もっと効率的な方法
let data = readLine()!.split(separator: " ").map { Int(String($0))! }
let (days, muscleDecreasePerDays) = (data[0], data[1])
let exerciseKit = readLine()!.split(separator: " ").map { Int(String($0))! - muscleDecreasePerDays }
var visited = [Bool](repeating: false, count: days)
var caseCounts = 0

dfs_permutation(0, 500)
print(caseCounts)

func dfs_permutation(_ depth: Int, _ weight: Int) {
    if depth == days {
        caseCounts += 1
        return
    }

    for i in 0..<days {
        if !visited[i] && (weight + exerciseKit[i]) >= 500 {
            visited[i] = true
            dfs_permutation(depth + 1, weight + exerciseKit[i])
            visited[i] = false
        }
    }
}

//BaekJoon n.7662 (二重priority Queue) 重要度: 🎖🎖🎖🎖🎖🎖🎖🎖🎖
// 🎖 Hard ‼️: Priority Queue
// 最大Heapと最小Heapを用いるアルゴリズム

// この問題は実装が難しかった
public struct priorityQueue<T> {
    // Heapのノードを保存する配列
    var nodes: [T] = []
    let comparer: (T, T) -> Bool

    var isEmpty: Bool {
        return nodes.isEmpty
    }

    init(sort: @escaping (T, T) -> Bool) {
        self.comparer = sort
    }

    func root() -> T? {
        return nodes.first
    }

    //挿入
    //　挿入する時に、折角な再整列になるようにしておくこと
    mutating func insert(_ element: T) {
        var index = nodes.count

        nodes.append(element)

        // nodes[index] = 現在insertしたノード番号、   nodes[(index - 1) / 2] = 現在insertしたノード番号の親のノードを指す
        while index > 0 && comparer(nodes[index], nodes[(index - 1) / 2]) {
            nodes.swapAt(index, (index - 1) / 2)
            index = (index - 1) / 2
        }
    }

//    @discardableResult mutating func popMinValue() -> T? {
//        guard !nodes.isEmpty else {
//            return nil
//        }
//
//        if nodes.count == 1 {
//            return nodes.removeFirst()
//        } else {
//            let minValue = nodes.min()
//            let filterNode = nodes.filter { $0 != minValue }
//            nodes = filterNode
//            return minValue
//        }
//    }

    // ない場合もあるから Generic Optionalにした
    // rootの取り出し
    @discardableResult mutating func pop() -> T? {
        guard !nodes.isEmpty else {
            return nil
        }

        if nodes.count == 1 {
            // nodeが１つしかないならそのまま removeFirst()しても構わない
            return nodes.removeFirst()
        }

        //
        let result = nodes.first
        nodes.swapAt(0, nodes.count - 1) // nodes[index]のswap 0 (番目のnode と　最後のノード)
        _ = nodes.popLast() // maxHeap だったら　最大値が、　minHeap だったら 最小値が　popされる

        var index = 0 // Root Nodeの Indexを指定する

        // ‼️Heapの再整列作業
        while index < nodes.count {
            //ノードをswapする作業
            let leftChildIdx = index * 2 + 1 //配列上のIndex
            let rightChildIdx = leftChildIdx + 1

            // 左の子供と右の子供両方ともある場合
            if rightChildIdx < nodes.count {
                if !comparer(nodes[leftChildIdx], nodes[rightChildIdx]) && comparer(nodes[rightChildIdx], nodes[index]) {
                    // comparerが > である場合
                    //右の子供が左の子供が持つ値より大きいし、右の子供が持つ値がindex(親のノード)が持つ値より大きいとき
                    nodes.swapAt(rightChildIdx, index)
                    index = rightChildIdx
                } else if comparer(nodes[leftChildIdx], nodes[index]) {
                    //左の子供がRoot Nodeが持つ値より大きいとき
                    nodes.swapAt(leftChildIdx, index)
                    index = leftChildIdx
                } else {
                    // 例えば comparer が >の場合を想定する
                    // if文の反転値 と　else if 文の反転値を考えると、
                    // if文の反転値は、 nodes[rightChildIdx] <= nodes[leftChildIdx] || nodes[rightChildIdx] <= nodes[index]になる
                    // また、　else if 文の反転値は、　nodes[left] <= nodes[index]になる
                    // 上記の場合をまとめると　elseには
                    // (nodes[rightChildIdx] <= nodes[leftChildIdx] || nodes[rightChildIdx] <= nodes[index]) && nodes[left] <= nodes[index]になる.  この条件式を論理演算すると
                    // よって、nodes[index]が nodes[rightChildIdx]　と　nodes[leftChildIdx]両方とも大きいとき(同値でも構わない)がelseに入ることになる
                    //　子供は両方ともあるが、親のノードより値が小さいとき
                    break
                }
            } else if leftChildIdx < nodes.count {
                // 左の子供だけある場合
                if comparer(nodes[leftChildIdx], nodes[index]) {
                    // comparer > の場合
                    nodes.swapAt(leftChildIdx, index)
                    index = leftChildIdx
                } else {
                    break
                }
            } else {
                //子供がない場合
                break
            }
        }

        return result
    }
}

struct Data : Comparable {
    static func < (lhs: Data, rhs: Data) -> Bool {
        lhs.cost < rhs.cost
    }
    
    var cost: Int
    var index: Int
}

//struct EdgeData: Comparable {
//    static func < (left: EdgeData, right: EdgeData) -> Bool {
//        left.value < right.value
//    }
//
//    var value: Int
//    var node: Int
//}

let testCase = Int(readLine()!)!

for _ in 0..<testCase {
    let dataCounts = Int(readLine()!)!
    printMax_Min(dataCounts)
}

func printMax_Min(_ dataNumbers: Int) {
    var validValue = [Bool](repeating: false, count: 1000001)
    // 上記で作った構造体 priorityQueueをジェネリックタイプ（Generic Type）にしたため、Struck(構造体)をType Parameterとして使える
    // Tは、Type Parameter の略 -> ただのPlaceHolderの役をする
    var maxPriorityQueue = priorityQueue<Data>(sort: >) // 最大Heapの実装
    var minPriorityQueue = priorityQueue<Data>(sort: <) // 最小Heapの実装

    for i in 0..<dataNumbers {
        let command = readLine()!.split(separator: " ").map { String($0) }
        let commandType = command[0], value = Int(command[1])!
        switch commandType {
        case "I":
            maxPriorityQueue.insert(Data(cost: value, index: i))
            minPriorityQueue.insert(Data(cost: value, index: i))
            validValue[i] = true
        case "D":
            if value == -1 {
                syncMinHeap()
                if !minPriorityQueue.isEmpty {
                    let popValue = minPriorityQueue.pop()
                    validValue[popValue!.index] = false
                }
            } else {
                syncMaxHeap()
                if !maxPriorityQueue.isEmpty {
                    let popValue = maxPriorityQueue.pop()
                    validValue[popValue!.index] = false
                }
            }
        default:
            break
        }
    }
    
    syncMinHeap()
    syncMaxHeap()
    
    if maxPriorityQueue.isEmpty {
        print("EMPTY")
    } else {
        print("\(maxPriorityQueue.pop()!.cost) \(minPriorityQueue.pop()!.cost)")
    }
    
    func syncMaxHeap() {
        while !maxPriorityQueue.isEmpty && !validValue[maxPriorityQueue.root()!.index] {
            maxPriorityQueue.pop()
        }
    }
    
    func syncMinHeap() {
        while !minPriorityQueue.isEmpty && !validValue[minPriorityQueue.root()!.index] {
            minPriorityQueue.pop()
        }
    }
}
