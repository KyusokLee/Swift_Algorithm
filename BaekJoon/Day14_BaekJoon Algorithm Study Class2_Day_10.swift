//
//  Day 14.swift
//  BaekJoon
//
//  Created by Kyus'lee on 2022/02/20.
//

import Foundation

//Day 14: Week2: 一週間のアルゴリズムの整理と問題の復習
//➡️昨日の復習
//BaekJoon Algorithm Study n.1260 (DFS と BFS) 重要度：🎖🎖🎖🎖🎖🎖🎖
// ‼️⚠️ BFSアルゴリズム　難しい。。
// テストケース通過はしたが、効率的によくなかった。。
// ⭐️‼️復習必修
//⭕️🔥Googleで検索しながら、他の人のコードを参考にしたコード
//　⭐️このスキルを自分のものにすること⭐️
//🔥Dictionaryじゃなく、二重配列を用いた方法も覚えておくこと１
let read_Data = readLine()!.split(separator: " ").map { Int($0)! }
let vertices1 =  read_Data[0]
let edges1 = read_Data[1]
let start1 = read_Data[2]
var datas = [[Int]](repeating: [Int]() , count: vertices1 + 1)

// 繋がっている頂点のデータを入力
for _ in 0..<edges1 {
    let link1 = readLine()!.split(separator: " ").map { Int($0)! }
    datas[link1[0]].append(link1[1])
    datas[link1[1]].append(link1[0])
}

for i in 1...vertices1 {
    datas[i].sort()
}

var visited = [Bool](repeating: false, count: vertices1 + 1)
var result_DFS = String()
var result_BFS = String()

//深さ優先探索
func DFS_1(start: Int) {
    visited[start] = true
    result_DFS += "\(start) "

    //すでにソートしたので、needVisitというもう一個のstackはいらない
    for i in datas[start] {
        if !visited[i] {
            DFS_1(start: i)
        }
    }
    // ⚠️注意:Stringがそのまま直接に配列に入るとCharacter 型になる
}

DFS_1(start:start1)
visited = [Bool](repeating: false, count: vertices1 + 1)

//幅優先探索
func BFS_1(start: Int) {
    var needVisitQueue1 = [start]

    while !needVisitQueue1.isEmpty {
        let select_node = needVisitQueue1.removeFirst()

        if !visited[select_node] {
            visited[select_node] = true
            result_BFS += "\(select_node) "
            needVisitQueue1 += datas[select_node]
        }
    }

}

BFS_1(start:start1)

print(result_DFS)
print(result_BFS)

//🌈考察: Return　がない関数を使った方が、処理時間が短く済むことに気づいた
//       Bool TypeのVisited 配列を用いた方が処理時間が短かったことに気づいた

//BaekJoon Algorithm Study n.11724 (Connected Componentsの数)　重要度：🎖🎖🎖🎖🎖🎖🎖
//  Connected Components (連結要素) とは、繋がっている頂点同士の集団の数
//  例えば、 1 - 2 - 3 - 5    4 - 7 が繋がっているとすると、連結要素は２個である
// 問題で同じ辺は一回だけ与えられると設定されているので、ifを用いたcheckは除いた

let readData = readLine()!.split(separator: " ").map { Int(String($0))! }
let vertices2 = readData[0]
let edges2 = readData[1]
var datas2 = [[Int]](repeating: [Int](), count: vertices2 + 1)
var datas2_count = [Int](repeating: 0, count: vertices2 + 1)
var visited2 = [Bool](repeating: false, count: vertices2 + 1)
var result2 = 0
var maxIdx = 0

for _ in 0..<edges2 {
    let link2 = readLine()!.split(separator: " ").map { Int(String($0))! }
    datas2[link2[0]].append(link2[1])
    datas2[link2[1]].append(link2[0])
}

for i in 1...vertices2 {
    datas2_count[i] = datas2[i].count
}
maxIdx = datas2_count.firstIndex(where: { $0 == datas2_count.max()!} )!

func DFS_3(start: Int) {
    visited2[start] = true

    for i in datas2[start] {
        if !visited2[i] {
            DFS_3(start:i)
        }
    }
}

//また、visitedしていないidxを探し、DFS関数を呼び出す
for i in 1...vertices2 {
    if !visited2[i] {
        result2 += 1
        DFS_3(start:i)
    }
}

DFS_3(start:maxIdx)
print(result2)

var prac_case3 = [[Int]]()
prac_case3.append([1])
prac_case3.append([2])
print(prac_case3)
// 結果は、[[1], [2]]になる、
// [[1, 2]]の結果が欲しい。。。

//BaekJoon Algorithm Study n.1012 (オーガニック白菜) 重要度：🎖🎖🎖🎖🎖🎖🎖🎖
//‼️HARD: 隣接リストとDFSをうまく使うこと、そして処理時間に注意してコードを設計しよう🔥
// ⚠️途中の段階
let testNum = Int(readLine()!)!

for _ in 0..<testNum {
    finding()
}

func finding() {
    var result = 0
    let data_cabbage = readLine()!.split(separator: " ").map { Int(String($0))! }
    let width = data_cabbage[0], height = data_cabbage[1], numbers = data_cabbage[2]

    var field = Array(repeating: Array(repeating: false, count: height), count: width)
  
    for i in 0..<numbers {
        let location = readLine()!.split(separator: " ").map { Int(String($0))! }
        field[location[0]][location[1]] = true
    }
    
    
    
    print(field)
}
