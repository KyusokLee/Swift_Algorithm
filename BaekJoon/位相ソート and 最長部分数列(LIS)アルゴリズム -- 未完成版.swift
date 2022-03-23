//
//  位相ソート and 最長部分数列(LIS)アルゴリズム -- 未完成版.swift
//  BaekJoon
//
//  Created by Kyus'lee on 2022/03/23.
//

import Foundation

//📝🔥 - - - - -- DPでLISを求めるアルゴリズム - - - - - --

let testCase = [1, 3, 2, 5, 4, 6] //入力数列
var countArray = [Int]() //入力数列の要素ごとに、当該要素までの最長数列を保存するための配列
var max = 1 // count配列に保存される最長数列の長さの中、最も長い長さの値を保存するための変数

//コードの説明:
//     testCase配列の一番目から最後の要素まで、順番通りチェックするための二重for文を使用
//     繰り返すたびに、まずcount配列に1を追加しておいた
//       ->> 自分自身以外、増加する数がないとしても、最小限自分自身を含んだ長さ１の数列になり得るため、基本的に１を追加する
//     1を追加したcountArray配列の長さほど、下位loop文を実行するが、まず、testCase配列でindex jにある数が index iにある数より小さいかどうかをチェック
//     小さかったら、countArrayに保存したj番目の要素とi番目の要素を比較する
//       ->> i番目の要素、つまりcountArrayに追加した最後の要素である1がcountArray[j]より小さいか同値であれば、i番目の要素はj番目の要素が持つ最長増加数列の個数に１を足した分、最長増加数列を持つという意味で解釈できる
//     上記の施行を繰り返すと、最長増加数列を持つ要素とその長さを求めることができる

for i in 0..<testCase.count {
    countArray.append(1)

    for j in 0..<countArray.count {
        if testCase[j] < testCase[i] && countArray[i] <= countArray[j] {
            countArray[i] = countArray[j] + 1
        }
    }

    print(countArray)

    if max < countArray[i] {
        max = countArray[i]
    }
}
print(countArray)

print(max)

//BaekJoon Algorithm Study n.1965 (箱を入れよう) 重要度: 🎖🎖🎖🎖🎖🎖🎖
// DP + LIS(最長増加部分数列)アルゴリズム
//LIS(Longest Increasing Subsequence) : 部分的に増加する数列の中、最も長いものを探すアルゴリズム
//        🔥簡単に言えば、「小さい値 -> 大きい値」 に至る、繋げられる最大の個数を求めることである🔥
// 例: [1, 6, 2, 5, 7, 3, 5, 6]の場合
//     1 -> 6
//     1 -> 2 -> 5 -> 7
//     1 -> 2 -> 3 -> 5 -> 6   つまり、max: 5


let boxes = Int(readLine()!)!
let boxLine = readLine()!.split(separator: " ").map { Int(String($0))! }
var count = [Int]()
var max = 1

for i in 0..<boxes {
    count.append(1)

    for j in 0..<count.count {
        if boxLine[j] < boxLine[i] && count[i] <= count[j] {
            count[i] = count[j] + 1
        }
    }

    if max < count[i] {
        max = count[i]
    }

}

print(max)

//📝🔥 - - - - -- 位相ソートアルゴリズム - - - - - --
//⚠️途中の段階⚠️
struct Graph<T>: Equatable where T: Equatable {
    var childs: [T]

    mutating func push(_ child: T) {
        self.childs.append(child)
    }
}

var nodes = 5
var inDegree = [Int](repeating:0, count: nodes) //各　Nodesの進入次数情報
var trees = [Graph<Int>]()
inDegree[1] = 1
inDegree[2] = 1
inDegree[3] = 2
inDegree[4] = 1

toPologicalSort()

func toPologicalSort() -> [Int] {
    var result = [Int]()
    var Queue = [Int]()

    for i in 0..<nodes {
        print(i)
        if inDegree[i] == 0 {
            Queue.append(inDegree[i])
        }
    }

    for _ in 0..<nodes {

        if Queue.isEmpty {
            print("サイクルができてしまいました!!")
            exit(0)
        }

        result.append(Queue.first!)
        let node = Queue.removeFirst()

        for child in trees[node].childs {
            // ⚠️上記のchildsの部分でindex　out of rangeエラーがでてしまう
            inDegree[child] -= 1
            if inDegree[child] == 0 {
                Queue.append(child)
            }
        }
    }

    return result
}

//他の方法1
let Nodes = Int(readLine()!)!
var graph = [[Int]](repeating: [], count: Nodes + 1)
var indegree = [Int](repeating: 0, count: Nodes + 1)
var cost = [Int](repeating: 0, count: Nodes + 1)
var result = [Int](repeating: 0, count: Nodes + 1)

for i in 1...Nodes {
    let input = readLine()!.split(separator: " ").map { Int(String($0))! }
    cost[i] = input[0]
    result[i] = input[0]
    for j in 2..<2 + input[1] {
        graph[i].append(input[j])
        indegree[input[j]] += 1
    }
}

func topologySort(_ start: Int) -> [Int] {
    var queue = indegree[1...].enumerated().filter { $0.element == 0 }.map { $0.offset + 1 }
    var stack = [Int]()

    while !queue.isEmpty {
        let first = queue.removeFirst()
        result.append(first)
        if graph[first].isEmpty {
            stack.append(result[first])
        }

        for element in graph[first] {
            result[element] = max(result[element], result[first] + cost[element])
            indegree[element] -= 1
            if indegree[element] == 0 {
                queue.append(element)
            }
        }
    }
    return stack
}

print(topologySort(Nodes).max()!)


//BaekJoon Algorithm Study n.2252 (列を並ばせよう) 重要度: 🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖
// 🔥Very Hard🔥
// DP + 位相ソートアルゴリズム
// ⚠️途中の段階⚠️
// 二人の学生の情報が入力される
//  例えば、A B --> 学生Aが　学生Bの前にいなければいけないってことを意味（問題条件）

let data = readLine()!.split(separator: " ").map { Int(String($0))! }
let students = data[0], compareNums = data[1]
var resultArray = [Int]()
var count = [Int]()

for _ in 0..<compareNums {



}
