//
//  Day36.swift
//  BaekJoon
//
//  Created by Kyus'lee on 2022/03/22.
//

import Foundation

// Day36: DFS、BFS シリーズ (3)

//BaekJoon Algorithm Study n.1753 (最短経路) 重要度: 🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖 (Heapと 優先順位Queueに関する問題)
// ‼️Very Very Hard ‼️
//他のheapの具現コード　(他の人のコード参考)
//高級文法を使ったheap具現コード

//ノードの間を繋げる辺の値が大きい方が重さが大きいため、最大Heapを実現した
//最短経路の問題だから、最小Heapの方が正しい
public struct Heap<T> {
    var nodes: [T] = []
    let comparer: (T, T) -> Bool

    var isEmpty: Bool {
        return nodes.isEmpty
    }

    init(comparer: @escaping (T, T) -> Bool) {
        self.comparer = comparer
    }

    func root() -> T? {
        return nodes.first
    }

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

// ここまでが、Heapのアルゴリズム

extension Heap where T: Comparable {
    init() {
        self.init(comparer: >)
    }
}
//最小Heapを再現するアルゴリズムコード


//⚠️‼️このコードが特に難しかった
struct EdgeData: Comparable {
    static func < (left: EdgeData, right: EdgeData) -> Bool {
        left.cost < right.cost
    }

    var cost: Int
    var node: Int
}

func solution() {
    let inf = 98765432
    let data = readLine()!.split(separator: " ").map { Int(String($0))! }
    let nodesCount = data[0], edgesCount = data[1]
    let startNode = Int(readLine()!)! - 1
    var graph = Array(repeating: [(Int, Int)](), count: nodesCount)
    //Nodes番号がどのNodes番号と繋がっているかと、辺の重さを格納するTuple型の配列

    for _ in 0..<edgesCount {
        let lineData = readLine()!.split(separator: " ").map { Int(String($0))! }
        graph[lineData[0] - 1].append((lineData[1] - 1, lineData[2]))
    }

    var distance = Array(repeating: inf, count: nodesCount)
    distance[startNode] = 0

    var priorityQueue: Heap = Heap<EdgeData>()
    priorityQueue.insert(EdgeData(cost: 0, node: startNode))

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

solution()

//BaekJoon Algorithm Study n.10026 (赤緑色弱) 重要度: 🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖

let testCase = Int(readLine()!)!
var ordinaryView = [[Character]]()
var colorWeaknessView = [[Character]]()
let directionRow = [0, 0, -1, 1]
let directionColumn = [1, -1, 0, 0]
var countOriginal = 0
var countColorWeak = 0

for _ in 0..<testCase {
    var putColor = Array(readLine()!)
    ordinaryView.append(putColor)

    for i in 0..<putColor.count {
        if putColor[i] == "G" {
            putColor[i] = "R"
        }
    }
    colorWeaknessView.append(putColor)
}

// "C" の意味: Checkedの C
for i in 0..<testCase {
    for j in 0..<testCase {
        if ordinaryView[i][j] != "C" {
            bfs_findDistrict(i, j, ordinaryView[i][j], &ordinaryView)
            countOriginal += 1
        }

        if colorWeaknessView[i][j] != "C" {
            bfs_findDistrict(i, j, colorWeaknessView[i][j], &colorWeaknessView)
            countColorWeak += 1
        }
    }
}

print("\(countOriginal) \(countColorWeak)")

func bfs_findDistrict(_ rowStart: Int, _ columnStart: Int, _ targetColor: Character, _ targetMap: inout [[Character]]) {
    var neededCheckQueue = [(rowStart, columnStart)]
    var index = 0
    targetMap[rowStart][columnStart] = "C"

    while index < neededCheckQueue.count {
        let (currentRow, currentColumn) = neededCheckQueue[index]

        for i in 0..<4 {
            let nextRow = currentRow + directionRow[i]
            let nextColumn = currentColumn + directionColumn[i]

            if nextRow < 0 || nextRow >= testCase || nextColumn < 0 || nextColumn >= testCase {
                continue
            }

            if targetMap[nextRow][nextColumn] == targetColor {
                targetMap[nextRow][nextColumn] = "C"
                neededCheckQueue.append((nextRow, nextColumn))
            }
        }

        index += 1
    }
}

//BaekJoon Algorithm Study n.16236 (Baby Shark) 重要度: 🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖
//　初の Gold Rank. 3　難易度の問題
// ‼️Very Hard‼️
// 🔥📚必ず、使いこなせるようにアルゴリズムの設計をちゃんと分析及び復習すること！！！🔥
//　-- ⚠️ 途中の段階🖍

//９があるマスが、赤ちゃんサメがいる場所。　赤ちゃんサメの大きさは、最初は2に固定(初期値)
// 0は、空のマス
// 1, 2, 3, 4, 5, 6　マスにいる魚の大きさ 7と8はない
let mapSize = Int(readLine()!)!
var map = [[Int]]()
let directionRow = [0, 0, -1, 1]
let directionColumn = [1, -1, 0, 0]
var sharkLocate = (-1, -1, -1)
var result = 0
var eatCount = 0

for i in 0..<mapSize {
    let mapData = readLine()!.split(separator: " ").map { Int(String($0))! }
    map += [mapData]
    
    if let j = mapData.firstIndex(of: 9) {
        sharkLocate = (i, j, 2)
        map[i][j] = 0
    }
}

while true {
    if !bfs_sharkMoving(sharkLocate.0, sharkLocate.1, sharkLocate.2) {
        print(result)
        break
    }
}

func bfs_sharkMoving(_ rowStart: Int, _ columnStart: Int, _ size: Int) -> Bool {
    var fishArray = [(Int, Int)]()
    var index = 0
    var neededCheckQueue: [(row: Int, column: Int, moveStack: Int)] = [(rowStart, columnStart, 0)]
    var visited = Array(repeating: Array(repeating: false, count: mapSize), count: mapSize)
    var distance = 98765432
    visited[rowStart][columnStart] = true
    
    while index < neededCheckQueue.count {
        let (currentRow, currentColumn, distanceCount) = neededCheckQueue[index]
        
        if distanceCount > distance {
            continue
        }
        
        if (size - 1..<size).contains(map[currentRow][currentColumn]) {
            distance = distanceCount
            fishArray.append((currentRow, currentColumn))
        }
        
        for i in 0..<4 {
            let nextRow = currentRow + directionRow[i]
            let nextColumn = currentColumn + directionColumn[i]
            
            if nextRow < 0 || nextRow >= mapSize || nextColumn < 0 || nextColumn >= mapSize || map[nextRow][nextColumn] > size || visited[nextRow][nextColumn] {
                continue
            }
            
            visited[nextRow][nextColumn] = true
            neededCheckQueue.append((nextRow, nextColumn, distanceCount + 1))
        }
        
        index += 1
    }
    
    if fishArray.isEmpty {
        return false
    }
    
    //赤ちゃんサメの現在位置から、最も近い距離に複数の候補がある場合、同じ行であれば一番左のマスにいる魚を、同じ行にある魚じゃない場合、一番上の行の魚を食べる(問題の設定)
    fishArray.sort {
        if $0.0 == $1.0 {
            return $0.1 < $1.1
        }
        return $0.0 < $1.0
    }
    
    let targetFish = fishArray.first!
    eatCount += 1
    
    if eatCount == size {
        sharkLocate.2 += 1
        eatCount = 0
    }
    
    map[targetFish.0][targetFish.1] = 0
    sharkLocate = (targetFish.0, targetFish.1, sharkLocate.2)
    
    result += distance
    
    return true
}
