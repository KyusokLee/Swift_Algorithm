//
//  Day 36.swift
//  BaekJoon
//
//  Created by Kyus'lee on 2022/03/18.
//

import Foundation

//優先順位　Queueの具現　Heapを用いる
// Heapは完全二分木で成り立っている
//  -> 最大heap -> Root Nodeが最大値である (自分の子供のノードの値は、自分の値より小さいか同じでなければならない)
//  -> 最小heap -> Root Nodeが最小値である (自分の子供のノードの値は、自分の値より大きいか同じでなければならない)
// BST(Binaray Search Tree (二分探索木))とは違い、左の子と右の子の間の値のサイズは関係ない　-> つまり、左の子供の値が右の方より大きくてもいいし、右の子供が左の方より大きくなっても別に構わない
//　このような特徴があるため、根ノード（Root Node）がいつも最大値か最小値になることができる (最大Heapと最小Heapの区分は、コード作成時設計を変える)

//今回、最大Heapについて、作成した
// 完全二分木であるから、ノード間のindex関係を表せる >> 必ず、左の子供のノードから順番に埋まって行くから、ノードが生成されるindexを表現できるから、親と子供間のindexをお互い求めることが可能

// 親のノードのindex番号: 子供ノードのindex番号　/ 2 (Int型の時)
//配列で具現する時、配列は0から始まるため、ややこしくなるため、Nodeのindexをわざと1から始まるように設定する >> 0から始まると0のノードの子供のノードを探すために別途のコードを書けないといけない

//最大Heap

//構造体の作成
//比較が可能なデータであれば、全て格納するため、Comparable　プロトコルを採択した
struct Heap<T: Comparable> {
    var heapArray: Array<T> = []

    init() { }
    init(data: T) {
        heapArray.append(data) //0番目のindexを埋めるため
        heapArray.append(data) //実際のRoot Nodeを埋めるため
    }

    //データの挿入
    //挿入作業
    //    -> 1. 完全二分木のアルゴリズム通り、一旦挿入する（データ比較 X）
    //    -> 2. 挿入されたデータの大きさが親ノードのデータより小さくなるまで、Swapする (繰り返し作業で)
    mutating func insert(_ data: T) {
        if heapArray.count == 0 {
            heapArray.append(data)
            heapArray.append(data)
            return
        }

        heapArray.append(data)

        //親のノードより大きければ　-> True (上に移動　OK)
        func isMoveUp(_ insertIndex: Int) -> Bool {
            if insertIndex <= 1 {   //RootNodeであるときは、直接RootNodeに格納できないようにしとく
                return false
            }
            let parentIdx: Int = insertIndex / 2
            return heapArray[insertIndex] > heapArray[parentIdx] ? true : false
        }

        var insertIndex: Int = heapArray.count - 1 //0が格納されているため、 -1をする
        while isMoveUp(insertIndex) {
            let parentIdx: Int = insertIndex / 2
            heapArray.swapAt(insertIndex, parentIdx)
            insertIndex = parentIdx
        }
    }

    // Heapに保存されたデータを取り出す(削除する方法)
    //削除作業(最大Heapの場合)
    //    -> 1. 最も大きい値であるRoot Nodeを削除する(Return 値)
    //    -> 2. 一番最後に追加されたノード(配列の最後の要素)をRoot Nodeに移動させる
    //    -> 3. 移動されたRoot Nodeのデータが左、右の子供より大きくなるまで、子供のノードの中、大きい値を持つノードとSwapする(繰り返し作業)
    enum moveDownStatus {
        case none, left, right
        //none: 移動なし
        //left: 左の子供のノードとswapするため
        //right: 右の子供のノードとswapするため
    }

    mutating func pop() -> T? {
        if heapArray.count <= 1 {
            return nil
        }

        let returnData = heapArray[1] //最大値であるRoot Nodeを returnするように
        heapArray.swapAt(1, heapArray.count - 1) //[1]ノード（Root Node）と、一番最後に追加された（一番後ろ）のノードの値をswapする
        heapArray.removeLast() //後ろの要素削除

        var poppedIdx = 1 //一番後ろのノードとswapした後の　Root NodeのIndex
        while true {
            switch isMoveDown(poppedIdx) {
            case .none:
                return returnData
            case .left:
                let leftChildIdx = poppedIdx * 2
                heapArray.swapAt(poppedIdx, leftChildIdx)
                poppedIdx = leftChildIdx
            case .right:
                let rightChildIdx = (poppedIdx * 2) + 1
                heapArray.swapAt(poppedIdx, rightChildIdx)
                poppedIdx = rightChildIdx
            }

        }

        func isMoveDown(_ poppedIdx: Int) -> moveDownStatus {
            let leftChildIdx = (poppedIdx * 2)
            let rightChildIdx = leftChildIdx + 1

            //Case 1. 全ての(左の)子供のノードがない場合　（完全二分木は左の方から埋まっていくため）
            if leftChildIdx >= heapArray.count {
                return .none
            }

            //Case 2. 左の子供のノードだけある場合
            if rightChildIdx >= heapArray.count {
                return heapArray[leftChildIdx] > heapArray[poppedIdx] ? .left : .none
            }

            //Case 3. 左、右の子供のノードが全部ある場合
            // Case 3 - (1) 子供の値が自分より全部小さい場合
            if (heapArray[leftChildIdx] < heapArray[poppedIdx] && heapArray[rightChildIdx] < heapArray[poppedIdx]) {
                return .none
            }

            // Case 3 - (2) 子供の値が自分より全部大きい場合
            if (heapArray[leftChildIdx] > heapArray[poppedIdx] && heapArray[rightChildIdx] > heapArray[poppedIdx]) {
                return heapArray[leftChildIdx] > heapArray[rightChildIdx] ? .left: .right
            }
            // Case 3 - (3) 左と右の子供の中、片方だけ自分より大きい場合
            return heapArray[leftChildIdx] > heapArray[rightChildIdx] ? .left : .right
        }
    }
}

//var heap = Heap.init(data:0)
//heap.insert(100)
//heap.insert(30)
//heap.insert(200)
//print(heap)
////出力:  Heap<Int>(heapArray: [0, 200, 100, 30, 0])　　（0番目のindexはわざと入れたため、無視すること）

var heap = Heap.init(data: 30)
var a: Heap<Int>
heap.insert(20)
heap.insert(18)
heap.insert(9)
heap.insert(6)
heap.insert(50)
print(heap)
print("pop Data == \(heap.pop()!)")
print(heap)
print(heap.heapArray)

//BaekJoon Algorithm Study n.1753 (最短経路) 重要度: 🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖 (Heapと 優先順位Queueに関する問題)
//  ⚠️⚠️途中の段階‼️⚠️⚠️
// ‼️Very Very Hard ‼️
//他のheapの具現コード　(他の人のコード参考)
//高級文法を使ったheap具現コード

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

extension Heap where T: Comparable {
    init() {
        self.init(comparer: >)
    }
}

struct EdgeData: Comparable {
    static func < (left: EdgeData, right: EdgeData) -> Bool {
        left.value < right.value
    }

    var value: Int
    var node: Int
}

//BaekJoon Algorithm Study n.2206 (壁を壊して移動)　重要度: 🎖🎖🎖🎖🎖🎖🎖🎖🎖
// BFS + 貪欲法　を応用した問題 (‼️とてもいい問題)
// Rank. Gold 4 --> Paiza A rank上位　〜　S rankに相当すると自分的に思う
//最後の-1出力の部分で行き詰まった...
//⚠️ タイムオーバーになってしまったコード
// 🔥考えたアイデア1. 壁を1つ壊してもいいなら、一つずつ壊して距離が一番短く出る結果を出力する
//  -->📝🌈考察: しかし、この方法は本当にたくさんの時間がかかってしまい、失敗するしかなかった

typealias Locate = (row: Int, column: Int)
let data = readLine()!.split(separator: " ").map { Int(String($0))! }
let rowSize = data[0], columnSize = data[1]
let directionRow = [0, 0, -1, 1]
let directionColumn = [1, -1, 0, 0]
var wallLocate: [(row: Int, column: Int)] = []
var map = [[Int]]()
var result = 98765432
var finalResult = 0


for i in 0..<rowSize {
    let putData = readLine()!.map { Int(String($0))! }
    map.append(putData)

    for j in 0..<columnSize {
        if map[i][j] == 1 {
            wallLocate.append((i, j))
        }
    }
}

var isTrue = false
let start: Locate = (0, 0)
let targetDestination: Locate = (rowSize - 1, columnSize - 1)

var selectedCheck = [Bool](repeating: false, count: wallLocate.count)
var loopCount = 0
select_OneWall(0, [])

print(finalResult)

func select_OneWall(_ depth: Int, _ wall: [Locate]) {
    if depth == 1 {
        var compareMap = map
        compareMap[wall[0].row][wall[0].column] = 0
        let isAvailable = bfs_minDistance(&compareMap)

        if loopCount == 1 {
            finalResult = min(result, isAvailable)
            loopCount = 0
            return
        }

        if finalResult > 0 {
            if !isTrue {
                isTrue = true
            }
        }

        if isTrue {
            if isAvailable < 0 {
                return
            } else {
                finalResult = min(finalResult, isAvailable)
            }
        } else {
            if isAvailable > 0 {
                finalResult = isAvailable
                isTrue = true
            }
        }

        return
    } else {
        for i in 0..<wallLocate.count {
            if !selectedCheck[i] {
                selectedCheck[i] = true
                if i == 0 {
                    loopCount = 1
                }
                select_OneWall(depth + 1, wall + [wallLocate[i]])
                selectedCheck[i] = false
            }
        }
    }
}

func bfs_minDistance(_ map: inout [[Int]]) -> Int {
    var visited = Array(repeating: Array(repeating: false, count: columnSize), count: rowSize)
    var neededVisitQueue: [(Locate, count: Int)] = [(start, 1)]
    var index = 0
    var tempDistance = 0
    var isPossible = false
    visited[0][0] = true

    while index < neededVisitQueue.count {
        let ((currentRow, currentColumn), calculate) = neededVisitQueue[index]

        if (currentRow, currentColumn) == targetDestination {
            isPossible = true
            tempDistance = calculate
            break
        }

        for i in 0..<4 {
            let nextRow = currentRow + directionRow[i]
            let nextColumn = currentColumn + directionColumn[i]

            if nextRow < 0 || nextRow >= rowSize || nextColumn < 0 || nextColumn >= columnSize {
                continue
            }

            if map[nextRow][nextColumn] == 0 && !visited[nextRow][nextColumn] {
                visited[nextRow][nextColumn] = true
                neededVisitQueue.append(((nextRow, nextColumn), calculate + 1))
            }
        }
        index += 1
    }

    if isPossible {
        return tempDistance
    } else {
        return -1
    }
}

//タイムオーバーにならないコード
// 🔥考えたアイデア2. 進む途中に壁に初めて出会うとき、壁を壊して移動回数をカウントする
//   他の人たちのコードを見て理解できなかった部分は、"壁に出会っても何もしないで、後で壊す場合はどうやってチェックするの？"だった。
//　　結論的には、グリッドの概念が統合されたBFSと考えるべきだった。会えば壊す。
//　　壊したかどうかの確認は、座標を表す2次元配列を広げ、3次元配列に格納して同期化させる。
//
//  例:  visited[0][0][0] =  visited[0][0]の位置であり、壁をまだ壊してない。
//       visited[1][2][1] =  visited[1][2]の位置であり、壁に出会って壁をすでに壊したことを表す。
//  Swift言語で作成する際の注意点が、ArrayのremoveFirst()メソッドを使用した場合、O(n)の時間複雑度が発生する。
//　　タイムオーバー問題を解決するために、Queueで現在位置を示すindexを設けた。（しかし、メモリ量をたくさん使ってしまう）
//  作業を関数で宣言し、return値をprintするよりも、全域で実行する方がメモリを少なくすることができる。

func breakingWall() {
    typealias Locate_Data = (row: Int, column: Int, wallbreak: Int)
    let data = readLine()!.split(separator: " ").map { Int(String($0))! }
    let rowSize = data[0], columnSize = data[1]
    var map = [[Int]]()
    var visited = Array(repeating: Array(repeating: Array(repeating: 0, count: 2), count: columnSize), count: rowSize)
    var result = -1
    let directionRow = [0, 0, -1, 1]
    let directionColumn = [1, -1, 0, 0]
    
    for _ in 0..<rowSize {
        map.append(readLine()!.map { Int(String($0))! })
    }
    
    var neededCheckQueue: [Locate_Data] = []
    var index = 0
    visited[0][0][0] = 1
    neededCheckQueue.append((0, 0, 0))
    
    while index < neededCheckQueue.count {
        let (currentRow, currentColumn, breakCheck) = neededCheckQueue[index]
        
        if currentRow == rowSize - 1 && currentColumn == columnSize - 1 {
            result = visited[currentRow][currentColumn][breakCheck]
            break
        }
        
        for i in 0..<4 {
            let nextRow = currentRow + directionRow[i]
            let nextColumn = currentColumn + directionColumn[i]
            var nextCheckWall = breakCheck
            
            if (0 <= nextRow && nextRow < rowSize) && (nextColumn >= 0 && nextColumn < columnSize) && visited[nextRow][nextColumn][breakCheck] == 0 {
                if map[nextRow][nextColumn] == 0 {
                    visited[nextRow][nextColumn][nextCheckWall] = visited[currentRow][currentColumn][breakCheck] + 1
                    neededCheckQueue.append((nextRow, nextColumn, breakCheck))
                } else if nextCheckWall == 0 {
                    //壁であるが、壊すことが可能
                    visited[nextRow][nextColumn][1] = visited[currentRow][currentColumn][breakCheck] + 1
                    nextCheckWall = 1
                    neededCheckQueue.append((nextRow, nextColumn, nextCheckWall))
                }
            }
        }
        index += 1
    }
    
    print(result)
}

breakingWall()
