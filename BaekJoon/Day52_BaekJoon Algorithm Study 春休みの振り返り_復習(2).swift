//
//  Day52.swift
//  BaekJoon
//
//  Created by Kyus'lee on 2022/04/10.
//

import Foundation

//Day 52: 春休みの振り返り - 復習(2)
//BaekJoon Algorithm Study n.1992 (QuadTree) 重要度: 🎖🎖🎖🎖🎖🎖
//分割統治法 , 再帰関数
let mapSize = Int(readLine()!)!
var map = [[Int]]()
var result = ""

for _ in 0..<mapSize {
    map += [readLine()!.map { Int(String($0))! }]
}
quadTree(0, 0, mapSize)
print(result)

func quadTree(_ row: Int, _ column: Int, _ size: Int) {
    if check(row, column, size) {
        result += "\(map[row][column])"
        return
    } else {
        result += "("
        let newSize = size / 2

        for i in 0..<2 {
            for j in 0..<2 {
                quadTree(row + newSize * i, column + newSize * j, newSize)
            }
        }

        result += ")"
    }
}

func check(_ row: Int, _ column: Int, _ size: Int) -> Bool {
    let compareNum = map[row][column]

    for i in row..<row + size {
        for j in column..<column + size {
            if map[i][j] != compareNum {
                return false
            }
        }
    }

    return true
}

//BaekJoon Algorithm Study n.1074 (Z) 重要度: 🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖
//分割統治法 , 再帰関数
// 注意: 時間超過にならないように設計する際、注意すること
// ‼️必ず、このアルゴリズム使いこなせるようにしておくこと‼️
// 🔥Hard!!🔥

// 0, 1, 2, 3 --> 左上, 右上,　左下、 右下 の順のindex
let data = readLine()!.split(separator: " ").map { Int(String($0))! }
let mapSize = data[0]
let targetLocate: (row: Int, column: Int) = (data[1], data[2])
var result = 0

moveLikeZ(Int(pow(2, Double(mapSize))), 0, 0)

func moveLikeZ(_ size: Int, _ row: Int, _ column: Int) {
    if size == 2 {
        if (row, column) == targetLocate {
            print(result)
            return
        }
        result += 1
        if (row, column + 1) == targetLocate {
            print(result)
            return
        }
        result += 1
        if (row + 1, column) == targetLocate {
            print(result)
            return
        }
        result += 1
        if (row + 1, column + 1) == targetLocate {
            print(result)
            return
        }
        result += 1
        return
    } else {
        if targetLocate.row < row + size / 2 && targetLocate.column < column + size / 2 {
            //　第1象限
            moveLikeZ(size / 2, row, column)
        } else if targetLocate.row < row + size / 2 && targetLocate.column < column + size / 2 + size / 2 {
            // 第2象限
            result += (size / 2) * (size / 2) // 第1象限を全部回ってきたため、 (size / 2) * (size / 2) * 1
            moveLikeZ(size / 2, row, column + size / 2)
        } else if targetLocate.row < row + size / 2 + size / 2 && targetLocate.column < column + size / 2 {
            // 第3象限
            result += (size / 2) * (size / 2) * 2 // 第2象限まで全部回ってきたため、 (size / 2) * (size / 2) * 2
            moveLikeZ(size / 2, row + size / 2, column)
        } else {
            // 第4象限
            result += (size / 2) * (size / 2) * 3 // 第3象限まで全部回ってきたため、 (size / 2) * (size / 2) * 3
            moveLikeZ(size / 2, row + size / 2, column + size / 2)
        }
    }
}

//BaekJoon Algorithm Study n.9466 (turm Project) 🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖
// 🔥Very Hard DFS
// Cycleを判別するDFS Algorithm

// ⚠️正しく出力されるが、メモリ量超過になってしまったコード
let testCase = Int(readLine()!)!

for _ in 0..<testCase {
    let students = Int(readLine()!)!
    var stdSelectStd = readLine()!.split(separator: " ").map { Int(String($0))! - 1 }

    var makeTeam = [Bool](repeating: false, count: students)
    for i in 0..<students {
        if !makeTeam[i] {
            dfs(i, stdSelectStd[i], [i], &makeTeam, &stdSelectStd)
        }
    }
    print(makeTeam.filter { $0 == false }.count)
}

func dfs(_ stdNum: Int, _ select: Int, _ tempTeam: [Int], _ visit: inout [Bool], _ selectStd: inout [Int]) {
    if select == stdNum {
        visit[select] = true
        return
    } else {
        if select == tempTeam.first! {
            tempTeam.forEach { member in
                visit[member] = true
            }
            return
        } else {
            if !visit[select] {
                dfs(select, selectStd[select], tempTeam + [select], &visit, &selectStd)
            } else {
                return
            }
        }
    }
}

// より効率的なコード
let testCase = Int(readLine()!)!

for _ in 0..<testCase {
    let students = Int(readLine()!)!
    let stdSelectStd = readLine()!.split(separator: " ").map { Int(String($0))! - 1 }

    var makeTeam = [Bool](repeating: false, count: students)
    var teams = [[Int]]()
    for i in 0..<students {
        if !makeTeam[i] {
            var team = [Int]()
            dfs(i, stdSelectStd, &team, &teams, &makeTeam)
        }
    }
    print(students - teams.flatMap { $0 }.count)
}

func dfs(_ stdNum: Int, _ stdArray: [Int], _ tempTeam: inout [Int], _ completeTeam: inout [[Int]], _ visit: inout [Bool]) {
    visit[stdNum] = true
    tempTeam.append(stdNum)
    let doesSelect = stdArray[stdNum]

    if !visit[doesSelect] {
        //まだ、checkしてない studentならば -> 再帰関数dfsを回す
        dfs(doesSelect, stdArray, &tempTeam, &completeTeam, &visit)
    } else {
        // 既に、checkをしているstudentならば、
        if tempTeam.contains(doesSelect) {
            // もし、現在調べている学生が選んだ学生が既にcheckをしている人でありながら、臨時のTeam (tempTeam)に入っている学生であれば、cycleができてしまうので、新しく選んだ学生から現在の学生までが完成されたチームになる
            completeTeam.append(Array(tempTeam.firstIndex(of: doesSelect)!...tempTeam.endIndex - 1))
        }
        return
    }
}
