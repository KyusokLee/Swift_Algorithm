//
//  Day 44.swift
//  BaekJoon
//
//  Created by Kyus'lee on 2022/04/02.
//

import Foundation

//Day 44 優先順位Queue + Dijikstraアルゴリズム + DFS,BFS　シリーズ(10) + 具現問題 + Two Pointer
//優先順位Queue , Dijikstra アルゴリズム
//ノードの間を繋げる辺の値が大きい方が重さが大きいため、最大Heapを実現した
public struct Heap<T> {
    var nodes: [T] = []
    let comparer: (T, T) -> Bool

    var isEmpty: Bool {
        return nodes.isEmpty
    }

    init(comparer: @escaping (T, T) -> Bool) {
        self.comparer = comparer
    }

//    func root() -> T? {
//        return nodes.first
//    } --> 別にいらなかったコード

    mutating func insert(_ element: T) {
        var index = nodes.count

        nodes.append(element)

        while index > 0 && !comparer(nodes[index], nodes[(index - 1) / 2]) {
            nodes.swapAt(index, (index - 1) / 2)
            index = (index - 1) / 2
        }
    }

    mutating func pop() -> T? {
        guard !nodes.isEmpty else {
            return nil
        }

        if nodes.count == 1 {
            return nodes.removeFirst()
        }

        let result = nodes.first
        nodes.swapAt(0, nodes.count - 1)
        _ = nodes.popLast()

        var index = 0 // Root Nodeの Indexを指定する

        while index < nodes.count {
            //ノードをswapする作業
            let leftChildIdx = index * 2 + 1
            let rightChildIdx = leftChildIdx + 1

            // 左の子供と右の子供両方ともある場合
            if rightChildIdx < nodes.count {
                if comparer(nodes[leftChildIdx], nodes[rightChildIdx]) && !comparer(nodes[rightChildIdx], nodes[index]) {
                    //右の子供が左の子供が持つ値より大きいし、右の子供が持つ値がindex(親のノード)が持つ値より大きいとき
                    nodes.swapAt(rightChildIdx, index)
                    index = rightChildIdx
                } else if !comparer(nodes[leftChildIdx], nodes[index]) {
                    //左の子供がRoot Nodeが持つ値より大きいとき
                    nodes.swapAt(leftChildIdx, index)
                    index = leftChildIdx
                } else {
                    //子供は両方ともあるが、親のノードより値が小さいとき
                    break
                }
            } else if leftChildIdx < nodes.count {
                // 左の子供だけある場合
                if !comparer(nodes[leftChildIdx], nodes[index]) {
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

//特定のプロトコルを採用したタイプのみ拡張可能にする (extension where 文法 ) //ここでは、genericタイプであるTを採択しているHeapに関してってことを意味
extension Heap where T: Comparable {
    init() {
        self.init(comparer: >)
    }
}

//最小Heap
// > < >= <= などの4つの演算を別途で作る必要はなく、ゆとりがあるSwiftは、<　のメッソド一つだけで十分である
struct EdgeData: Comparable {
    // この構造体は、IntをPropertyとして持っているため、上記で拡張したHeapのTがこの構造体をTypeとして採用する場合、TはInt型になる
    static func < (left: EdgeData, right: EdgeData) -> Bool {
        left.cost < right.cost
    }

    var cost: Int
    var node: Int
}

//最小Heapを用いたDijkstra アルゴリズム -> BFSとGreedyがDijktraの基礎となるアルゴリズム
func dijkstra() {
    let inf = 98765432
    let data = readLine()!.split(separator: " ").map { Int(String($0))! }
    let nodesCount = data[0], edgesCount = data[1]
    let startNode = Int(readLine()!)! - 1
    var graph = Array(repeating: [(Int, Int)](), count: nodesCount)
    //Nodes番号がどのNodes番号と繋がっているかと、辺の重さを格納するTuple型の配列
    // graph は、つまり　配列のindex自体がfrom Node (そのノードから出る辺) となり、そのindexのTupleは、$0.0は　to Node（そのノードに入る辺）, $0.1は　辺の重さ(costとなる)

    for _ in 0..<edgesCount {
        let lineData = readLine()!.split(separator: " ").map { Int(String($0))! }
        graph[lineData[0] - 1].append((lineData[1] - 1, lineData[2]))
        //辺は、一度追加するだけで十分なので、例えば、1と5が繋がっているとしても、1からの情報だけ追加した方が効率的!
    }

    var distance = Array(repeating: inf, count: nodesCount)
    distance[startNode] = 0 //自分自身への最短距離は0にする

    var priorityQueue: Heap = Heap<EdgeData>()
    //上で説明した通り、EdgeDataがIntをPropertyとして持っているため、Heapのgeneric Tがこの構造体をTypeとして採用する場合、T は Int型になる

    priorityQueue.insert(EdgeData(cost: 0, node: startNode)) //start地点の重さは0にしておく

    while !priorityQueue.isEmpty {
        let current = priorityQueue.pop()!
        if distance[current.node] < current.cost  {
            continue
        }

        for next in graph[current.node] {
            if current.cost + next.1 < distance[next.0] {
                distance[next.0] = current.cost + next.1
                priorityQueue.insert(EdgeData(cost: current.cost + next.1, node: next.0))
            }
        }
    }

    for i in distance {
        if i == inf {
            print("INF")
        } else {
            print(i)
        }
    }
}

dijkstra()

//BaekJoon Algorithm Study n.5430 (AC) 重要度: 🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖
// Two Pointer
// 🔥Hard!
let testCase = Int(readLine()!)!
for _ in 0..<testCase {
    let command = readLine()!
    let n = Int(readLine()!)!

    let array = readLine()!.dropFirst().dropLast().split(separator: ",").map { Int(String($0))! }

    var head = 0, tail = n - 1
    var isReversed = false
    var isError = false

    for order in command {
        if order == "D" {
            if head > tail {
                isError = true
                break
            }
            if isReversed {
                tail -= 1
            } else {
                head += 1
            }
        } else {
            // order == "R"の場合
            isReversed.toggle()
            // toggle() --> false だったら　trueに　, true だったら falseに変えてくれるメッソド (Bool　typeの反転)
        }
    }

    if isError {
        print("error")
    } else if head > tail {
        print("[]")
    } else {
        let answer = array[head...tail].map { String($0) }.joined(separator: ",")
        let reverseAnswer = array[head...tail].reversed().map { String($0) }.joined(separator: ",")

        if isReversed {
            print("[" + reverseAnswer + "]")
        } else {
            print("[" + answer + "]")
        }
    }
}

//BaekJoon Algorithm Study n.9466 (turm Project) 🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖
// 🔥Very Hard DFS

let testCase = Int(readLine()!)!
for _ in 0..<testCase {
    let students = Int(readLine()!)!
    let stdSelect = readLine()!.split(separator: " ").map { Int(String($0))! - 1 }
    var checked = [Bool](repeating: false, count: students)
    var teams = [[Int]]()
    
    for i in 0..<students {
        if !checked[i] {
            var team = [Int]()
            dfs(i, stdSelect, &checked, &team, &teams)
        }
    }
    //flatMapは、多重配列の要素を一つの配列の要素として変換してくれるメッソド
    print(students - teams.flatMap( { $0 }).count)
}

func dfs(_ stdNum: Int, _ stdArray: [Int], _ check: inout [Bool], _ team: inout [Int], _ teams: inout [[Int]]) {
    check[stdNum] = true
    team.append(stdNum)
    let selectStd = stdArray[stdNum]
    
    if !check[selectStd] {
        dfs(selectStd, stdArray, &check, &team, &teams)
    } else {
        if team.contains(selectStd) {
            teams.append(Array(team[team.firstIndex(of: selectStd)!...]))
        }
        return
    }
}
