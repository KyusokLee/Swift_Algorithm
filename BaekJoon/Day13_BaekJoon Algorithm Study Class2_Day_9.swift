//
//  day13.swift
//  BaekJoon
//
//  Created by Kyus'lee on 2022/02/19.
//

import Foundation

//📝Day13. Week2: 一週間のアルゴリズムの整理と問題の復習
//➡️昨日の続き
//BaekJoon Algorithm Study n.2606 (パソコンウイルス) 重要度：🎖🎖🎖🎖🎖
// 🔥----🎖DFS(深さ優先探索の定番の問題)------
// ⚠️必ず、使いこなせるようになって、自分のスキルとして実現してみること！
// ⭐️‼️復習必修
// Dictionary は sort()使えない  >> 代わりにsorted()でソートできる

let computers = Int(readLine()!)!
let linked_com = Int(readLine()!)!
var dict_com = [Int: [Int]]()
var nowVisit = Array<Bool>(repeating: false, count: computers) //現在訪問中であるComputerの番号
var visited = Array<Int>(repeating: 0, count: computers) //すでに、訪問してcheckをしたComputerの番号

for i in 1...computers {
    dict_com[i] = []
}

for _ in 0..<linked_com {
    let link = readLine()!.split(separator: " ").map { Int($0)! }
    dict_com[link[0]]!.append(link[1])
    if dict_com[link[0]]!.contains(link[1]) {
        dict_com[link[1]]!.append(link[0])
    }
}

func DFS_findVirus(_ select: Int) -> Int {
    let start = select

    for i in dict_com[start]! {
        if !nowVisit[i - 1] && visited[i - 1] == 0 {
            nowVisit[i - 1] = true
            visited[i - 1] = 1
            DFS_findVirus(i)
            nowVisit[i - 1] = false
        } else {
            continue
        }
    }

    return visited.filter { $0 == 1 }.count - 1
}

nowVisit[0] = true
visited[0] = 1
print(DFS_findVirus(1))

//☀️📚練習：　 fliter練習

let prac_array = [1, 2, 0, 1, 1]
let filter_prac = prac_array.filter { $0 == 1 } // ❗️1を持つ要素だけを配列として返してくれる
print(filter_prac)

// ☀️📚練習：　print(first(where: ) と wholeNumberValue,　compactMapの練習及び理解

// compactMap ：　nilあったら除去してくれるし、Optional値のOptionalを剥がす！

let N = 2022
let digit_N = String(N).count
let String_N = String(N)

let prac_array2 = Array(1...9) //1から9まで1刻みで格納 もちろん Array<Int>
print(prac_array2)

let prac_array3 = Array(N - digit_N * 9..<N) //Arrayの活用
print(prac_array3)

let target_sort1 = prac_array3.first(where: { String($0).compactMap { String($0) }[0] == "2" } ) ?? 0
//ここでの ?? 0は　Optional Unwrapping である ??演算子の使用である (Nil-Coalescing Operation)
print(target_sort1)

let target_sort2 = prac_array3.first(where: { String($0).compactMap { Int(String($0)) }.reduce(0) { $0 + $1 } == 7 }) ?? 0  // ??演算子を使ったunwrappingを用いて、求める値があったら Optional除去した値を、じゃなかったら ?? の右の値を出力。　ここで、注意することは、 ?? の左と右のTypeを一致させなければならないこと！
print(target_sort2)

let target_sort3 = prac_array3.first(where: { String($0).compactMap { $0.wholeNumberValue }.reduce(0, +) == 7 }) ?? 0
print(target_sort3)
// target_sort2 と　target_sort3は全く同じ値になる

let target_sort4 = prac_array3.first(where: { String($0).map { $0.wholeNumberValue! }.reduce(0, +) == 7 }) ?? 0
print(target_sort4)
//target_sort4も target_sort2,3と同じ結果になる

//🌈考察：wholeNumberValue >> Character 型を　Int型に変換したい時、　Int(String())の変換を通さずに一発でInt型に変換させるという便利さがある。
//    もちろん、Int?を返すため、Unwrapping 必要！

//BaekJoon Algorithm Study n.1260 (DFS と BFS) 重要度：🎖🎖🎖🎖🎖🎖🎖
// ‼️⚠️ BFSアルゴリズム　難しい。。
// テストケース通過はしたが、効率的によくなかった。。
// ⭐️‼️復習必修

//自分でやったコード
let data_case = readLine()!.split(separator: " ").map { Int($0)! }
let vertices = data_case[0]
let edges = data_case[1]
let start_visit = data_case[2]

var nowVisit = Array<Bool>(repeating: false, count: vertices + 1)
var visited = Array<Bool>(repeating: false, count: vertices + 1)
var dict_1 = [Int: [Int]]()
var DFS_result: [String] = [String]()

for i in 1...vertices {
    dict_1[i] = []
}

for _ in 0..<edges {
    let edge = readLine()!.split(separator: " ").map { Int($0)! }
    if !dict_1[edge[0]]!.contains(edge[1]) {
        dict_1[edge[0]]!.append(edge[1])
        dict_1[edge[1]]!.append(edge[0])
    }
}

for i in dict_1.keys {
    dict_1[i]!.sort()
}

// DFSは、Stack１個 と 1個の Queue を用いる！その解き方を理解し、使いこなせるようにすること！
// DFSの再帰関数を用いたコード
func DFS(_ select: Int) -> String {
    let start = select

    if !DFS_result.contains(String(start)) {
        DFS_result.append(String(start))
    }

    nowVisit[start] = true
    visited[start] = true

    for i in dict_1[start]! {
        if !nowVisit[i] && !visited[i]  {
            DFS(i)
            nowVisit[i] = false
        } else {
            continue
        }
    }

    return DFS_result.joined(separator: " ")
}

// Queue　２個を用いる方法が普段の解き方
func BFS(_ select: Int) -> String {
    let start = select
    var visitedQueue: [Int] = []
    var needVisitQueue: [Int] = [start]

    while !needVisitQueue.isEmpty {
        let nowNode: Int = needVisitQueue.removeFirst()
        if visitedQueue.contains(nowNode) {
            continue
        }

        visitedQueue.append(nowNode)
        needVisitQueue += dict_1[nowNode] ?? []
    }

    return visitedQueue.map { String($0) }.joined(separator: " ")
}

print(DFS(start_visit))
print(BFS(start_visit))

//⭕️🔥Googleで検索しながら、他の人のコードを参考にしたコード


//配列の練習
var pick_nums = [1, 3, 5, 7, 9]
pick_nums += [2, 4]
print(pick_nums) // [1, 3, 5, 7, 9, 2, 4] 配列の後ろに追加される

