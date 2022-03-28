//
//  Minimum Spanning Tree アルゴリズム.swift
//  BaekJoon
//
//  Created by Kyus'lee on 2022/03/28.
//

import Foundation

//📮- - 最小スパニングツリー(Minimum Spanning Tree (MST) == 最小全域木)アルゴリズム - -
// MSTを求めるアルゴリズムは、(1) Kruskal アルゴリズムと　(2) Prim　アルゴリズムがある
// 🔥今回はKruskal　アルゴリズムについて学ぶことにする (もっとコーディングスキルを磨いてからPrimアルゴリズムを実現する予定)

// 🔥必須問題 ‼️
// 🌈Kruskal アルゴリズム (Union-Find アルゴリズムを用いる方法)
//BaekJoon Algorithm Study n.1197 (最小スパニングツリー) 重要度: 🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖

let putData = readLine()!.split(separator: " ").map { Int(String($0))! }
let nodes = putData[0], edges = putData[1]

var parent = Array(0...nodes)
var graph = [[Int]]()

for _ in 0..<edges {
    // ノード1, ノード１と繋がっているノード2, 辺の順で入力を受け取る
    graph.append(readLine()!.split(separator: " ").map { Int(String($0))! })
}

var sortedGraph = graph.sorted(by: { $0[2] < $1[2] }) //辺の重さが最も低いノードからスタートできるように昇順でソートする
print(Kruskal())

func Kruskal() -> Int {
    var lines = 0 // 辺の数を数える変数
    var result = 0 //最小値を表す変数

    //親ノードを探る再帰関数
    func findParent(_ index: Int) -> Int {
        if parent[index] == index {
            return index
        } else {
            parent[index] = findParent(parent[index])
            return parent[index]
        }
    }

    //親ノードを統一させるアルゴリズム
    func unionParent(_ node1: Int, _ node2: Int) {
        let num1 = findParent(node1)
        let num2 = findParent(node2)

        if num1 < num2 {
            parent[num2] = num1
        } else {
            parent[num1] = num2
        }
    }

    for index in 0..<sortedGraph.count {
        if lines == nodes - 1 {
            //辺の数が頂点より１個小さいとき、サイクル（ノードが全部繋がっており、永遠に循環できるということ）がなかったら終了とする
            break
        }
        // 調べようとする２つの頂点の親ノードが異なる場合のみ、辺の重さを追加し、辺の数も足す
        //また、親ノードを統一させる作業を行う
        if findParent(sortedGraph[index][0]) != findParent(sortedGraph[index][1]) {
            result += sortedGraph[index][2]
            lines += 1
            unionParent(sortedGraph[index][0], sortedGraph[index][1])
        }
    }

    return result
}

// 🔥必須問題 ‼️
// 🌈Prim アルゴリズム (ノードを一個一個回りながら、最小値を探る方法) --> ⚠️注意点: 全てのノードを回るため、最悪の場合、時間複雑度がすごいかかる : O(ElogE)の時間
// まだ、Heapを用いた最小値の求め方に慣れてないため、今回はHeapを使用せず実装した
// 🔥もう一度実装してみること⚠️ - - - 今後、Heapを使いこなせるようになってから再度実装する予定 ‼️
struct Edge {
    var destination: Int
    var cost: Int
}

let putData = readLine()!.split(separator: " ").map { Int(String($0))! }
let nodes = putData[0], edges = putData[1]

var parent = Array(0...nodes)
var graph = [[Int]]()

for _ in 0..<edges {
    // ノード1, ノード１と繋がっているノード2, 辺の順で入力を受け取る
    graph.append(readLine()!.split(separator: " ").map { Int(String($0))! })
}

print(prim1(nodes, graph))
// ノードの番号が0からスタートするように設計した

func updateDist(_ graph: [Edge], dist: inout [Int?]) -> [Edge] {
    for edge in graph {
        if let d = dist[edge.destination] {
            if d > edge.cost {
                dist[edge.destination] = edge.cost
            }
        } else {
            dist[edge.destination] = edge.cost
        }
    }

    return graph
}

func prim1(_ n: Int, _ costs: [[Int]]) -> Int {
    var dist = [Int?](repeating:nil, count: n)
    var visited = [Bool](repeating: false, count: n)

    var nowNode = 0
    var minimumCost = 0
    var line = 0
    var tree = [[Edge]](repeating: [], count: n)

    for cost in costs {
        tree[cost[0]].append(Edge(destination: cost[1], cost: cost[2]))
        tree[cost[1]].append(Edge(destination: cost[0], cost: cost[2]))
    }

    visited[nowNode] = true
    line += 1

    while line < n {
        _ = updateDist(tree[nowNode], dist: &dist)
        var minCost: Int? = nil

        for i in 0..<n {
            guard !visited[i] , let d = dist[i] else {
                continue
            }

            if let min = minCost {
                if min > d {
                    minCost = d
                    nowNode = i
                }
            } else {
                minCost = d
                nowNode = i
            }
        }

        visited[nowNode] = true
        line += 1
        minimumCost += minCost!
    }

    return minimumCost
}
