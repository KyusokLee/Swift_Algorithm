//
//  Day 49.swift
//  BaekJoon
//
//  Created by Kyus'lee on 2022/04/07.
//

import Foundation

//Day 49 春休みの振り返り - 復習(1)
//BaekJoon Algorithm Study n.3109 (ベーカリー) 重要度: 🎖🎖🎖🎖🎖🎖🎖
// 🔥Greedy + DFS Hard🔥
let data = readLine()!.split(separator: " ").map { Int(String($0))! }
let rowSize = data[0], columnSize = data[1]
var visited = [[Bool]]()
var result = 0
let directionPipe = [(-1, 1), (0, 1), (1, 1)] //右上、右、右下の順で探索する

for _ in 0..<rowSize {
    visited += [readLine()!.map { $0 == "x" }] // xがあるところは移動できないため、先にtrueにしておく
}

//Pipeは、同じマスの重複がないようにしておかなければならないため、最初の列から最後の列まで繋がるルートがあればそのままresult + 1する
// 例えば、
//  11111 と
//
//  1
//   1
//    111　は 最初の始点が同じであるため、pipeの重複ができてしまう --> そのため、完成されたPipeは 2個じゃなく1つである

for i in 0..<rowSize {
    if dfs_findPipe(i, 0) {
        // ここで、visitedで訪問したかどうかをチェックせず、dfs関数を呼び出すようにしてもいい理由は、どうせ最初の列からスタートし、右の方にどんどんマスを探索するため、visitedを設けなくても済んだからである
        result += 1
    }
}

print(result)

func dfs_findPipe(_ row: Int, _ column: Int) -> Bool {
    visited[row][column] = true
    if column == columnSize - 1 {
        return true
    }

    for i in 0..<3 {
        let (nextRow, nextColumn) = (row + directionPipe[i].0, column + directionPipe[i].1)

        if nextRow < 0 || nextRow >= rowSize || nextColumn < 0 || nextColumn >= columnSize || visited[nextRow][nextColumn] {
            continue
        }

        if dfs_findPipe(nextRow, nextColumn) {
            return true
        }
    }

    return false
}

// 🔥mapの活用　--> map {} の内部closure で $0 (Shorthand Argument Names ( 速記引数名 ))と　== 演算を使うと Boolの配列になる
var map1 = [[Bool]]()
var rowSize = 5

for _ in 0..<rowSize {
    let putData = readLine()!.map { $0 == "a" } // 入力されたのが a だったらtrueを返す
    print(type(of:putData))
    print(putData)
}

print(map1)


//BaekJoon Algorithm Study n.15652 (NとM (4)) 重要度: 🎖🎖🎖
let data = readLine()!.split(separator: " ").map { Int(String($0))! }
let numberHave = data[0], length = data[1]
var result = ""

dfs(0, 1, "")
result.removeLast()
print(result)

func dfs(_ depth: Int, _ index: Int, _ str: String) {
    if depth == length {
        result += str
        result.removeLast()
        result += "\n"
        return
    }

    if index <= numberHave {
        for i in index...numberHave {
            dfs(depth + 1, i, str + "\(i) ")
        }
    }
}

//BaekJoon Algorithm Study n.9663 (N-Queen) 重要度: 🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖
//BackTrackingの代表的な問題
// 🔥Very Hard!!🔥
//時間超過にならないコード
// ⚠️必ず理解しておくアルゴリズム!!!🔥
// N-Queenのコードを徹底的に分析するため、余計なprint()をたくさん使った
print(solution(Int(readLine()!)!))
func solution(_ n: Int) -> Int {
    var map = [Int](repeating: -1, count: n) // indexが列を表し、indexごとに格納された値はその列のどこの行にQueenを置けばいいかを保存する配列である
    // -1に初期化した理由: 配列上で0も意味を持つ値(0, 0 -> 最初の行、最初の列)であるため、-1にした
    var result = 0

    func isImpossibleAttack(_ row: Int, _ column: Int) -> Bool {
        // ここの関数のcolumnは、dfs関数のdepthを受け取る
        print("row: \(row), column: \(column)")
        print(map)
        for i in 0..<column {
            if map[i] == row || abs(column - i) - abs(row - map[i]) == 0 {
                print("(\(row)行, \(column)列)におくと、配置してあるQueenたちと同じ行もしくは、対角線であるため、ここにおくと攻撃可能となる")
                return false
            }
        }
        //abs(column - i) - abs(row - map[i]) == 0は今の位置からの対角線のチェック --> このアルゴリズムが一番難しい買った
        // つまり、行のindexの差と　列のindexの差が等しければ、対角線にあるということ！
        // 書き換えると、abs(column - i) == abs(row - map[i]) になると 対角線であるから return falseになるのが分かる

        print("ここ(\(row)行 , \(column)列) におくとQueenが攻撃不可能")
        return true
    }

    func dfs_find(_ depth: Int) {
        if depth == n {
            print(map)
            result += 1
            return
        }

        for i in 0..<n {
            //ここで、iは isImpossibleAttack関数のrowになる
            if isImpossibleAttack(i, depth) {
                map[depth] = i
                print("select : Queenを\(i)行, \(depth)列においた : \(map[depth]) ")
                print(map)
                dfs_find(depth + 1)
                print(map)
                print("Queenを\(i)行, \(depth)列においたが、候補ではなかった")
                map[depth] = -1
            }
        }
    }

    dfs_find(0)
    return result
}

//!!再チャレンジ!!
// 🌈考察 : --> abs関数を使うと、メモリ量は同じだが、処理時間が長くなる

print(putQueen(Int(readLine()!)!))

func putQueen(_ n: Int) -> Int {
    var result = 0
    var map = [Int](repeating: -1, count: n)

    func isSafe(_ row: Int, _ column: Int) -> Bool {
        for i in 0..<column {
            if map[i] == row || row - map[i] == column - i || map[i] - row == column - i {
                return false
            }
               // map[i] == rowだったらreturn falseをする理由:⬇️
               //       iは現在調べようとする columnまでの列を意味する -> i(列)ごとに現在Queenを置こうと思う行 (row)に同じrowが格納されている場合 ->⬇️
               //               i行のrow行にすでにQueenが置かれていることになるため、同じ行であるとQueenは攻撃するから return  falseをしなければならない

        }

        return true
    }

    // 下記の関数では、新しい変数を設けて計算するようにしたが、処理時間が上記の関数よりながくなってしまった
//    func isSafe(_ row: Int, _ column: Int) -> Bool {
//        for i in 0..<column {
//            let columnDistance = column - i
//            let rowDistance = row - map[i]
//            if map[i] == row || rowDistance == columnDistance || (rowDistance * -1) == columnDistance {
//                return false
//            }
//            // map[i] == rowだったらreturn falseをする理由:⬇️
//            //       iは現在調べようとする columnまでの列を意味する -> i(列)ごとに現在Queenを置こうと思う行 (row)に同じrowが格納されている場合 ->⬇️
//            //               i行のrow行にすでにQueenが置かれていることになるため、同じ行であるとQueenは攻撃するから return  falseをしなければならない
//
//        }
//
//        return true
//    }

    func dfs_select(_ depth: Int) {
        if depth == n {
            result += 1
            return
        }

        for i in 0..<n {
            if isSafe(i, depth) {
                map[depth] = i // isSafe()で、そこにおくと安全であるということがtrueだったらmap[列]に 行のindexを格納する
                dfs_select(depth + 1) // Queenの位置を候補として格納して、dfs_selectを回してみる
                map[depth] = -1 // 現在のdepth(列)で次の列を探索してみたが、見つけなかった場合と、最後の列まで行って result + 1させてから戻ってくる場合 -1に初期化する
            }
        }
    }

    dfs_select(0)
    return result
}


//🔥分割統治法の代表的な問題
//BaekJoon Algorithm Study n.2630 (色紙作り) 重要度: 🎖🎖🎖🎖🎖🎖
// 1は青い色を、 0は白い色を表す
//‼️🔥 必ず理解しておくこと！！！ 🔥‼️
typealias Color = (white: Int, blue: Int)
let paperSize = Int(readLine()!)!
var paper = [[Int]]()

for _ in 0..<paperSize {
    paper += [readLine()!.split(separator: " ").map { Int(String($0))! }]
}

let result = unionFind_countColor(0, 0, paperSize)
print("\(result.white)\n\(result.blue)")

func unionFind_countColor(_ rowStart: Int, _ columnStart: Int, _ size: Int) -> Color {
    if size == 1 {
        if paper[rowStart][columnStart] == 1 {
            return (0, 1)
        } else {
            return (1, 0)
        }
    }

    var white = 0, blue = 0
    let rowDivide = [rowStart, rowStart + size / 2]
    let columnDivide = [columnStart, columnStart + size / 2]
    let newSize = size / 2

    for i in 0..<2 {
        for j in 0..<2 {
            let quadrant = unionFind_countColor(rowDivide[i], columnDivide[j], newSize)
            white += quadrant.0
            blue += quadrant.1
        }
    }

    if white == 0 {
        return (0, 1)
    }

    if blue == 0 {
        return (1, 0)
    }

    return (white, blue)
}

//BaekJoon Algorithm Study n.1780 (紙の個数) 重要度: 🎖🎖🎖🎖
// 分割統治法

//方法1 : 全部分割してから統合し、数える方法
typealias paperType = (a: Int, b: Int, c: Int) // -1, 0, 1だけで成り立つ紙の種類
let paperSize = Int(readLine()!)!
var paper = [[Int]]()

for _ in 0..<paperSize {
    paper += [readLine()!.split(separator: " ").map { Int(String($0))! }]
}

let result = unionFind_countPaper(0, 0, paperSize)
print("\(result.0)\n\(result.1)\n\(result.2)")

func unionFind_countPaper(_ rowStart: Int, _ columnStart: Int, _ size: Int) -> paperType {
    if size == 1 {
        if paper[rowStart][columnStart] == -1 {
            return (1, 0, 0)
        } else if paper[rowStart][columnStart] == 0 {
            return (0, 1, 0)
        } else {
            return (0, 0, 1)
        }
    }

    var paperA = 0, paperB = 0, paperC = 0
    let rowDivide = [rowStart, rowStart + size / 3, rowStart + size / 3 * 2]
    let columnDivide = [columnStart, columnStart + size / 3, columnStart + size / 3 * 2]
    let newSize = size / 3

    for i in 0..<3 {
        for j in 0..<3 {
            let dividingNine = unionFind_countPaper(rowDivide[i], columnDivide[j], newSize)
            paperA += dividingNine.0
            paperB += dividingNine.1
            paperC += dividingNine.2
        }
    }

    if paperB == 0 && paperC == 0 {
        return (1, 0, 0)
    }
    if paperA == 0 && paperC == 0 {
        return (0, 1, 0)
    }
    if paperA == 0 && paperB == 0 {
        return (0, 0, 1)
    }

    return (paperA, paperB, paperC)
}

//方法2 : さきにそのsizeの紙をcheckして、分割するか計算結果として値を入れるかの方法
let paperSize = Int(readLine()!)!
var paper = [[Int]]()
var result = [0, 0, 0] // -1, 0, 1の紙の種類

for _ in 0..<paperSize {
    paper += [readLine()!.split(separator: " ").map { Int(String($0))! }]
}

divideAndCount(0, 0, paperSize)
print("\(result[0])\n\(result[1])\n\(result[2])")

func divideAndCount(_ rowStart: Int, _ columnStart: Int, _ size: Int) {
    if check(rowStart, columnStart, size) {
        result[paper[rowStart][columnStart] + 1] += 1
    } else {
        let newSize = size / 3
        for i in 0..<3 {
            for j in 0..<3 {
                divideAndCount(rowStart + newSize * i, columnStart + newSize * j, newSize)
            }
        }
    }
}

func check(_ rowStart: Int, _ columnStart: Int, _ size: Int) -> Bool {
    let compare = paper[rowStart][columnStart]

    for i in rowStart..<rowStart + size {
        for j in columnStart..<columnStart + size {
            if paper[i][j] != compare {
                return false
            }
        }
    }

    return true // そのsizeの紙が一つの数字のみで成り立っている場合 trueを返す
}
