//
//  Day 48.swift
//  BaekJoon
//
//  Created by Kyus'lee on 2022/04/06.
//

import Foundation

//Day 48 BackTracking + DFS,BFS シリーズ(12)
//BaekJoon Algorithm Study n.15650 (NとM (2)) 重要度: 🎖🎖🎖🎖
let data = readLine()!.split(separator: " ").map { Int(String($0))! }
let numberHave = data[0], length = data[1]

var visited = Array(repeating: false, count: numberHave + 1)
var result = [Int]()

dfs(0)

func dfs(_ depth: Int) {
    if depth == length {
        if result.sorted() == result {
            print(result.map { String($0) }.joined(separator: " "))
            return
        } else {
            return
        }
    }
    for i in 1...numberHave {
        if !visited[i] {
            visited[i] = true
            result.append(i)
            dfs(depth + 1)
            visited[i] = false
            result.removeLast()
        }
    }
}

//もっと効率的なコード
let data = readLine()!.split(separator: " ").map { Int(String($0))! }
let numberHave = data[0], length = data[1]

dfs(0, 1, [])

func dfs(_ depth: Int, _ start: Int, _ result: [String]) {
    if depth == length {
        print(result.joined(separator: " "))
        return
    }

    if start <= numberHave {
        for i in start...numberHave {
            dfs(depth + 1, i + 1, result + ["\(i)"])
        }
    }
}

//BaekJoon Algorithm Study n.9663 (N-Queen) 重要度: 🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖
//BackTrackingの代表的な問題
// 🔥Very Hard!!🔥

//時間超過になってしまったコード

let N = Int(readLine()!)!
var result = 0
let map = Array(repeating: Array(repeating: true, count: N), count: N) // Queenが置かれた位置を記憶する２次元配列

dfs_findEnableArrange(0, N, map, &result)
print(result)

func dfs_findEnableArrange(_ depth: Int, _ targetN: Int, _ array: [[Bool]], _ answer: inout Int) {
    if depth == targetN {
        answer += 1
        return
    }

    //現在の行にQueenを置くことができるかを確認 ->> 理由: Queenは各行ごとに一つしか置くことができないため、現在の行のそれぞれの列に攻撃できるQueenがあるかどうかを確認する作業を行う
    //　もし、攻撃するQueenがなかったら現在の位置を配列mapに保存し　（falseに変えることで位置を保存） -> 次の行の作業に移る
    // こうやって、実行しながら一番最後の行に達した場合は、Queenを配置することができるcaseであるため、answer (配置できる場合の数)を　+1する
    for i in 0..<N {
        //攻撃することができないなら
        if isImpossibleAttack(depth, i, array) {
            var newArray = array
            newArray[depth][i] = false //攻撃なできないことをfalseとして扱う
            //dfs実行
            dfs_findEnableArrange(depth + 1, N, newArray, &answer)
        }
    }
}

//攻撃が不可能であるかをcheckする
func isImpossibleAttack(_ row: Int, _ column: Int, _ compare: [[Bool]]) -> Bool {
    for i in 0..<compare.count {
        // 縦を確認 (列の確認)
        if !compare[i][column] {
            return false
        } else if 0..<compare.count ~= column - abs(row - i) && !compare[i][column - abs(row - i)] {
            //対角線で左の方を確認 >> 現在調べるマスを基準に左にある対角線成分を調べる
            return false
        } else if 0..<compare.count ~= column + abs(row - i) && !compare[i][column + abs(row - i)] {
            //対角線で右の方を確認 >> 現在調べるマスを基準に右にある対角線成分を調べる
            return false
        }
    }

    return true
}

//時間超過にならないコード
// ⚠️必ず理解しておくアルゴリズム!!!🔥
print(solution(Int(readLine()!)!))
func solution(_ n: Int) -> Int {
    var map = [Int](repeating: -1, count: n) // indexが列を表し、indexごとに格納された値はその列のどこの行にQueenを置けばいいかを保存する配列である
    var result = 0

    func isImpossibleAttack(_ row: Int, _ column: Int) -> Bool {
        for i in 0..<column {
            if map[i] == row || abs(column - i) - abs(row - map[i]) == 0 {
                return false
            }
        }

        return true
    }

    func dfs_find(_ depth: Int) {
        if depth == n {
            print(map)
            result += 1
            return
        }

        for i in 0..<n {
            if isImpossibleAttack(i, depth) {
                map[depth] = i
                dfs_find(depth + 1)
                map[depth] = -1
            }
        }
    }

    dfs_find(0)
    return result
}

//BaekJoon Algorithm Study n.15651 (NとM (3)) 重要度: 🎖🎖🎖
let data = readLine()!.split(separator: " ").map { Int(String($0))! }
let numberHave = data[0], length = data[1]
var result = ""

dfs(0, "")
result.removeLast()
print(result)

func dfs(_ depth: Int, _ answer: String) {
    if depth == length {
        result += answer
        result.removeLast()
        result += "\n"
        return
    }
    for i in 1...numberHave {
        dfs(depth + 1, answer + "\(i) ")
    }
}

//BaekJoon Algorithm Study n.15652 (NとM (4)) 重要度: 🎖🎖🎖
let data = readLine()!.split(separator: " ").map { Int(String($0))! }
let numberHave = data[0], length = data[1]
var result = [Int]()

dfs(0)

func dfs(_ depth: Int) {
    if depth == length {
        print(result.map { String($0) }.joined(separator: " "))
        return
    }

    for i in 1...numberHave {
        if result.last == nil {
            result.append(i)
            dfs(depth + 1)
            result.removeLast()
        } else {
            if result.last! > i {
                continue
            } else {
                result.append(i)
                dfs(depth + 1)
                result.removeLast()
            }
        }
    }
}

//もっと効率的なコード
let data = readLine()!.split(separator: " ").map { Int(String($0))! }
let numberHave = data[0], length = data[1]
var result = ""

dfs(0, "", 1)
result.removeLast()
print(result)

func dfs(_ depth: Int, _ str: String, _ index: Int) {
    if depth == length {
        result += str
        result.removeLast()
        result += "\n"
        return
    }

    for i in index...numberHave {
        dfs(depth + 1, str + "\(i) ", i)
    }
}

//BaekJoon Algorithm Study n.3109 (ベーカリー) 重要度: 🎖🎖🎖🎖🎖🎖🎖
// 🔥Greedy + DFS Hard🔥
let data = readLine()!.split(separator: " ").map { Int(String($0))! }
let rowSize = data[0], columnSize = data[1]
let directionPipe = [(-1, 1), (0, 1), (1, 1)] //右上、右、右下の順　(問題文で指定された条件)
var map = [[Character]]()
var visited = Array(repeating: Array(repeating: false, count: columnSize), count: rowSize)
var result = 0

for _ in 0..<rowSize {
    map += [Array(readLine()!)]
}

for i in 0..<rowSize {
    if dfs_stealPipe(i, 0) {
        result += 1
    }
}
print(result)

func dfs_stealPipe(_ row: Int, _ column: Int) -> Bool {
    visited[row][column] = true
    if column == columnSize - 1 {
        return true
    }
    
    for i in 0..<3 {
        let nextRow = row + directionPipe[i].0
        let nextColumn = column + directionPipe[i].1
        
        if nextRow < 0 || nextRow >= rowSize || nextColumn < 0 || nextColumn >= columnSize || map[nextRow][nextColumn] == "x" || visited[nextRow][nextColumn] {
            continue
        }
        
        // ここで、ただのdfsじゃなく dfsのreturnがtrueだったらtrueをreturnするようにした理由は、ただのdfsにしちゃうとdfsの結果がtrueになっても一番したのreturn falseのせいで全部falseになってしまうからである
        // また、重複のpipeを避けるために、先にベーカリーに到着したらそのままpipeが完成されてtrueをreturnするようにした
        // 例えば、
        // .x.
        // ...
        // .x. のとき　１行１列から次に訪問するマスは0行2列である。ベーカリーについたため、このままretrunする
        // もし、そのままreturnせず、dfsを回すと 1行1列から1行2列のパイプも認めてしまい、このpipeは重複のマスがあるため、正しい結果を得ることができない
        // そのため、目的地に着いたらそのままreturnするようにしておいた
        if dfs_stealPipe(nextRow, nextColumn) {
            return true
        }
    }
    
    return false
}
