//
//  Fileasd.swift
//  BaekJoon
//
//  Created by Kyus'lee on 2022/05/04.
//

import Foundation
//Day 69 多様なアルゴリズム - (7)
//BaekJoon n.11279 (最大heap) 重要度: 🎖🎖🎖🎖🎖🎖🎖🎖
// 🎖‼️ Heap　アルゴリズム
public struct Heap<T> {
    // Heapのノードを保存する配列
    var nodes: [T] = []

    // Heap内の2つのノードを比較する方法を決定するproperty
    // 最大ヒープには '>' 、 最小ヒープには'<'を使用するようにコード作成
    // 📮最大Heap = 親のノードの値が子供のノードの値より大きい
    // 📮最小Heap = 親のノードの値が子供のノードの値より小さい
    // または、Heapが作成された場合に比較方法を提供
    // Tupleなどのカスタム要素を指定する
    let comparer: (T, T) -> Bool

    var isEmpty: Bool {
        return nodes.isEmpty
    }

    //‼️下記のinit実装が少しよくわからない
    // 以下のsort functionが　このHeapがmaxHeapか、minHeapかを決定する
    // > は　最大Heap、　< は　最小Heap
    init(sort: @escaping (T, T) -> Bool) {
        self.comparer = sort
    }

    func root() -> T? {
        return nodes.first
    }

    mutating func insert(_ element: T) {
        var index = nodes.count

        nodes.append(element)

        // nodes[index] = 現在insertしたノード番号、   nodes[(index - 1) / 2] = 現在insertしたノード番号の親のノードを指す
        while index > 0 && comparer(nodes[index], nodes[(index - 1) / 2]) {
            nodes.swapAt(index, (index - 1) / 2)
            index = (index - 1) / 2
        }
    }

    // ない場合もあるから Generic Optionalにした
    mutating func pop() -> T? {
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
var heap = Heap<Int>(sort: >) // .initを　sort: > にすることで、この変数heapは 最大Heapを表す (> が最大Heapになっている)
var result = ""

for _ in 0..<Int(readLine()!)! {
    let putNum = Int(readLine()!)!

    if putNum == 0 {
        result += "\(heap.pop() ?? 0)\n" // nilの場合 0　出力
    } else {
        heap.insert(putNum)
    }
}
result.removeLast()
print(result)

//BaekJoon n.1927 (最小heap) 重要度: 🎖🎖🎖🎖🎖🎖🎖🎖
// 🎖‼️ Heap　アルゴリズム
// 最小Heapの実装
public struct Heap<T> {
    var nodes = [T]()
    let comparer: (T, T) -> Bool

    var isEmpty: Bool {
        return nodes.isEmpty
    }

    init(sort: @escaping (T, T) -> Bool) {
        self.comparer = sort
    }

    //格納する時も、格納した後再整列の作業を行う
    mutating func insert(_ element: T) {
        var index = nodes.count // 格納するノードのindex番号
        nodes.append(element)

        while index > 0 && comparer(nodes[index], nodes[(index - 1) / 2]) {
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

        let isPopped = nodes.first
        nodes.swapAt(0, nodes.count - 1)
        _ = nodes.popLast()

        var index = 0

        //rootノードの値を取り出して、再整列作業を行う
        while index < nodes.count {
            let leftChildIdx = index * 2 + 1
            let rightChildIdx = leftChildIdx + 1

            if rightChildIdx < nodes.count {
                if !comparer(nodes[leftChildIdx], nodes[rightChildIdx]) && comparer(nodes[rightChildIdx], nodes[index]) {
                    nodes.swapAt(rightChildIdx, index)
                    index = rightChildIdx
                } else if comparer(nodes[leftChildIdx], nodes[index]) {
                    nodes.swapAt(leftChildIdx, index)
                    index = leftChildIdx
                } else {
                    break
                }
            } else if leftChildIdx < nodes.count {
                if comparer(nodes[leftChildIdx], nodes[index]) {
                    nodes.swapAt(leftChildIdx, index)
                    index = leftChildIdx
                } else {
                    break
                }
            } else {
                break
            }
        }
        return isPopped
    }
}

var minHeap = Heap<Int>.init(sort: <)  // Heap<Int>(sort: <)と同じ表現
var result = ""
for _ in 0..<Int(readLine()!)! {
    let putNum = Int(readLine()!)!

    if putNum == 0 {
        result += "\(minHeap.pop() ?? 0)\n"
    } else {
        minHeap.insert(putNum)
    }
}

if result != "" {
    result.removeLast()
}
print(result)

//BaekJoon n.1620 (私は、ポケモンマスター　イ・ダソム！) 重要度: 🎖🎖🎖🎖🎖🎖🎖🎖
// 🎖‼️ Hash を用いた集合とmap
// 時間超過になったコード
let data = readLine()!.split(separator: " ").map { Int(String($0))! }
let knownPokemonsNums = data[0], wantToKnowNums = data[1]
var pokemonArray = [String]()
var result = ""

for _ in 0..<knownPokemonsNums {
    pokemonArray.append(readLine()!)
}

let sortedArray = pokemonArray.sorted()
for _ in 0..<wantToKnowNums {
    let wantData = readLine()!
    if let intData = Int(wantData) {
        result += "\(pokemonArray[intData - 1])\n"
    } else {
        binarySearch(wantData)
    }
}
result.removeLast()
print(result)

func binarySearch(_ targetOne: String) {
    var first = 0
    var end = knownPokemonsNums - 1

    while first <= end {
        let middle = (first + end) / 2

        if targetOne == sortedArray[middle] {
            result += "\(pokemonArray.firstIndex(of: targetOne)! + 1)\n"
            return
        } else if targetOne > sortedArray[middle] {
            first = middle + 1
        } else {
            end = middle - 1
        }
    }
}

//より効率的なコード
// Dictionaryを用いること！
// また、時間超過になってしまった...
let data = readLine()!.split(separator: " ").map { Int(String($0))! }
let knownPokemonsNums = data[0], wantToKnowNums = data[1]
var pokemonDictionary = [String: Int]()
var value = 0
var result = ""

for _ in 0..<knownPokemonsNums {
    let pokemonData = readLine()!
    if pokemonDictionary[pokemonData] == nil {
        pokemonDictionary[pokemonData] = value + 1
        value += 1
    }
}

for _ in 0..<wantToKnowNums {
    let wantToFind = readLine()!
    if let intData = Int(wantToFind) {
        let filterOne = pokemonDictionary.filter { $0.value == intData }.map { String($0.key) }[0]
        result += "\(filterOne)\n"
    } else {
        result += "\(pokemonDictionary[wantToFind]!)\n"
    }
}

if result != "" {
    result.removeLast()
}
print(result)

//時間超過にならない効率的なコード
// 🌈考察: 変数を少なくするために ①一つのDictionaryを用いたfiltering
//           もしくは、　② データを格納した配列とAlphabet辞書順にソートした配列を用いて二分探索を行った
//   上記の2つの方法は、両方とも時間超過になってしまい、問題をClearすることができなかった
//   ❗️ここから、学んだことは変数を減らすために必ずしも一つの配列およびDictionaryで完結しようとするよりも
//    ‼️もっと簡素に処理できそうな方法があったら変数を増やしてコードを作成する方がむしろ処理時間が早い結果となった!
let data = readLine()!.split(separator: " ").map { Int(String($0))! }
let knownPokemonsNums = data[0], wantToKnowNums = data[1]
var pokemonDictionary1 = [String: Int]()
var pokemonDictionary2 = [Int: String]()
var result = ""

for i in 0..<knownPokemonsNums {
    let pokemonData = readLine()!
    pokemonDictionary1[pokemonData] = i + 1
    pokemonDictionary2[i + 1] = pokemonData
}

for _ in 0..<wantToKnowNums {
    let wantToFind = readLine()!
    if let intOne = Int(wantToFind) {
        result += "\(pokemonDictionary2[intOne]!)\n"
    } else {
        result += "\(pokemonDictionary1[wantToFind]!)\n"
    }
}

if result != "" {
    result.removeLast()
}
print(result)

//BaekJoon n.5525 (IOIOI) 重要度: 🎖🎖🎖🎖🎖🎖🎖
// 🎖　文字列　Hard
// ❗️アイデアを絞り出すのが大変だった問題
let OCounts = Int(readLine()!)!
let strLength = Int(readLine()!)!
let compareStr = readLine()!.map { $0 }
var result = 0
var compare = 0
var i = 0

while i < strLength - 2 {
    if String(compareStr[i...i + 2]) == "IOI" {
        compare += 1
        if compare == OCounts {
            compare -= 1
            result += 1
        }
        i += 1
    } else {
        compare = 0
    }
    i += 1
}

print(result)

//もっと効率的なコード
func solution() -> Int {
    let OCounts = Int(readLine()!)!
    let strLen = Int(readLine()!)!
    let str = readLine()!
    let strArray = Array(str)
    var pattern = 0
    var cnt = 0
    var i = 1

    while i < strLen - 1 {
        if strArray[i - 1] == "I" && strArray[i] == "O" && strArray[i + 1] == "I" {
            pattern += 1
            // IOIの pattern 一つに Oが１個含められることがわかる
            // もし、OCounts が２であれば　求めるのは IOIのpatternが２回連続続いてる　IOIOIである
            if pattern == OCounts {
                pattern -= 1 // IOIOIの場合、前の方のpattern　IOIを消す作業をする -> IOIOI　から　__IOIとなる
                cnt += 1 // count　を + 1にする　（Oが２個含まれた IOIOIを見つけたため）
            }
            i += 1 //① -> ここで　iを一度 + 1して、、
        } else {
            pattern = 0
        }

        i += 1 // ② ->  ①の続きにi をもう一度増やす IOIOI のように I　と　I の間は　indexの差が 2であるため
        // もし、pattern IOIを見つけなかったら、 i を一個ずつ増やして探すため i += 1を　上記の①とここで分けて行う
        // 例えば、 OOIOIOIのとき　i = 1の場合、strArray[i - 1] == "O" , strArray[i] == "O" ,strArray[i + 1] == "I"となり、
        //        OOIは求めようとするIOIとはことなるため、i を +1して、 OIOを探すこといなる
    }
    return cnt
}

print(solution())

//BaekJoon n.16928 (ヘビとハシゴゲーム) 重要度: 🎖🎖🎖🎖🎖🎖🎖
// 🎖　BFS
let data = readLine()!.split(separator: " ").map { Int(String($0))! }
let ladders = data[0], snakes = data[1]
var map = Array(1...100)
var jumpingArray = [(Int, Int)]()

for _ in 0..<ladders + snakes {
    let putData = readLine()!.split(separator: " ").map { Int(String($0))! - 1 }
    jumpingArray.append((putData[0], putData[1]))
}

print(bfs_GotoEndPoint(0, 99))

func bfs_GotoEndPoint(_ start: Int, _ endPoint: Int) -> Int {
    var neededVisitQueue = [(start, 0)]
    var visited = Array(repeating: false, count: 100)
    var index = 0
    var result = 0

    while index < neededVisitQueue.count {
        let (curLocation, diceCount) = neededVisitQueue[index]

        if curLocation == endPoint {
            result = diceCount
            break
        }

        for i in 1...6 {
            var nextLocation = curLocation + i
            if nextLocation >= 100 || visited[nextLocation] {
                continue
            } else if jumpingArray.contains(where: { ($0.0, $0.1) == (nextLocation, $0.1) } ) {
                let newLocation = jumpingArray.filter { $0.0 == nextLocation }[0].1
                nextLocation = newLocation
                neededVisitQueue.append((nextLocation, diceCount + 1))
                visited[nextLocation] = true
            } else {
                neededVisitQueue.append((nextLocation, diceCount + 1))
                visited[nextLocation] = true
            }
        }

        index += 1
    }

    return result
}
