//
//  File.swift
//  BaekJoon
//
//  Created by Kyus'lee on 2022/05/14.
//

import Foundation
//Day 73 多様なアルゴリズム - (11) + 文字列
//BaekJoon n.5052 (電話番号リスト) 重要度: 🎖🎖🎖🎖🎖
// 🎖文字列
let testCase = Int(readLine()!)!
var result = ""
for _ in 0..<testCase {
    let phoneNumberCount = Int(readLine()!)!
    var numArray = [String]()
    for _ in 0..<phoneNumberCount {
        numArray.append((readLine()!))
    }
    numArray.sort() //Stringが辞書順にソートされる  数字だったら例) 900, 911, 917, 90111 -> 900, 90111, 911, 917のように
    if validCheck(numArray) {
        result += "YES\n"
    } else {
        result += "NO\n"
    }
}
result.removeLast()
print(result)

func validCheck(_ nums: [String]) -> Bool {
    for i in 0..<nums.count - 1 {
        if nums[i + 1].hasPrefix(nums[i]) {
            //nums[i + 1]の接頭語が nums[i]で始まるかどうかをBoolean値で返す
            return false
        }
    }
    return true
}

//BaekJoon n.13459 (玉脱出) 重要度: HARD🔥🔥
// ‼️🎖実装 VERY HARD + BFS🔥
// ⭐️📝完全に自分のスキルになるようにしっかり理解して復習しておくこと！
// 🎓問題説明:　青い玉を穴(0があるところ)に入れずに、赤い玉を移動回数10回以下で穴に入れて玉を取り出せるなら数字1を、そうじゃない場合は数字0を出力

typealias locate = (row: Int, column: Int)
let data = readLine()!.split(separator: " ").map { Int(String($0))! }
let rowSize = data[0], columnSize = data[1]
var map = [[String]]()
let directionMove: [locate] = [(0, 1), (0, -1), (1, 0), (-1, 0)] //東西南北
var redBead: locate = (0, 0), blueBead: locate = (0, 0)

for i in 0..<rowSize {
    var putData = readLine()!.map { String($0) }
    for j in 0..<columnSize {
        if putData[j] == "R" {
            redBead = (i, j)
            putData[j] = "."
        } else if putData[j] == "B" {
            blueBead = (i, j)
            putData[j] = "."
        }
    }
    map.append(putData)
}

print(bfs_beadEscaping_Find())

//‼️関数の作成が難しかった
func bfs_beadEscaping_Find() -> Int {
    //Queueを一つの配列にした方が処理時間が早くなる
    var neededVisitQueue: [(red: locate, blue: locate, timeCount: Int)] = [(redBead, blueBead, 0)]
    var index = 0
    //🔥HARD❗️　visited = ４次元配列
    var visited = Array(repeating: Array(repeating: Array(repeating: Array(repeating: false, count: columnSize), count: rowSize), count: columnSize), count: rowSize)
    visited[redBead.row][redBead.column][blueBead.row][blueBead.column] = true

    while index < neededVisitQueue.count {
        let mutualLocate = neededVisitQueue[index]
        index += 1

        if mutualLocate.timeCount == 10 {
            // 10回目の移動であるため、これ以上の移動は意味ない
            return 0
        }

        // 🔥KeyPoint: 次に移動する方向の把握が大事である -> そのため、switch文を使ってcaswを分ける必要がある
        for nextDirection in 0..<4 {
            var nextRed = mutualLocate.red
            var nextBlue = mutualLocate.blue

            switch nextDirection {
            case 0: // Right
                if mutualLocate.blue.column < mutualLocate.red.column {
                    //右に移動する時、Blueのcolumnが redのcolumnの後ろにあれば -> 先にredが動き出してからblueが移動するようにする
                    // 以下、同様
                    (nextRed, nextBlue) = bead_move(first: mutualLocate.red, second: mutualLocate.blue, nextDirection)
                } else {
                    (nextBlue, nextRed) = bead_move(first: mutualLocate.blue, second: mutualLocate.red, nextDirection)
                }
            case 1: // Left
                if mutualLocate.blue.column > mutualLocate.red.column {
                    (nextRed, nextBlue) = bead_move(first: mutualLocate.red, second: mutualLocate.blue, nextDirection)
                } else {
                    (nextBlue, nextRed) = bead_move(first: mutualLocate.blue, second: mutualLocate.red, nextDirection)
                }
            case 2: // down  (row値が大きい -> 下にあるということ)
                if mutualLocate.blue.row < mutualLocate.red.row {
                    (nextRed, nextBlue) = bead_move(first: mutualLocate.red, second: mutualLocate.blue, nextDirection)
                } else {
                    (nextBlue, nextRed) = bead_move(first: mutualLocate.blue, second: mutualLocate.red, nextDirection)
                }
            case 3: // Up
                if mutualLocate.blue.row > mutualLocate.red.row {
                    (nextRed, nextBlue) = bead_move(first: mutualLocate.red, second: mutualLocate.blue, nextDirection)
                } else {
                    (nextBlue, nextRed) = bead_move(first: mutualLocate.blue, second: mutualLocate.red, nextDirection)
                }
            default:
                fatalError("Error")
            }

            if visited[nextRed.row][nextRed.column][nextBlue.row][nextBlue.column] {
                continue
            }
            
            if map[nextRed.row][nextRed.column] == "O" && map[nextBlue.row][nextBlue.column] == "." {
                return 1
            } else if map[nextRed.row][nextRed.column] == "." && map[nextBlue.row][nextBlue.column] == "." {
                neededVisitQueue.append((nextRed, nextBlue, mutualLocate.timeCount + 1))
                visited[nextRed.row][nextRed.column][nextBlue.row][nextBlue.column] = true
            }
        }
    }

    return 0
}

func bead_move(first: locate, second: locate, _ i: Int) -> (locate, locate) {
    var nextmoveF = first
    var nextmoveS = second

    while true {
        let move_f: locate = (nextmoveF.row + directionMove[i].row, nextmoveF.column + directionMove[i].column)
        if move_f.row < 0 || move_f.row >= rowSize || move_f.column < 0 || move_f.column >= columnSize || map[move_f.row][move_f.column] == "#" {
            break
        }
        nextmoveF = move_f
        // 次の場所がOであり、穴に落ちるとしてもnextmoveFを更新して、return するように 下記の条件文の前に書いた
        // 理由: bfs_beadEscaping_Find()関数でもう一度判別を行わないといけないので
        if map[move_f.row][move_f.column] == "O" {
            break
        }
    }

    while true {
        let move_s: locate = (nextmoveS.row + directionMove[i].row, nextmoveS.column + directionMove[i].column)
        if move_s.row < 0 || move_s.row >= rowSize || move_s.column < 0 || move_s.column >= columnSize || map[move_s.row][move_s.column] == "#" {
            break
        }
        if move_s == nextmoveF && map[nextmoveF.row][nextmoveF.column] != "O" {
            //　次に動かす色の玉が 先に移動させった玉の位置と被る位置であり、かつ、先に移動させた玉の位置がO(穴)ではないただの"."(移動できる空間)であるならbreak
            break
        }
        nextmoveS = move_s
        // 次の場所がOであり、穴に落ちるとしてもnextmoveFを更新して、return するように 下記の条件文の前に書いた
        // 理由: bfs_beadEscaping_Find()関数でもう一度判別を行わないといけないので
        if map[move_s.row][move_s.column] == "O" {
            break
        }
    }

    return (nextmoveF, nextmoveS)
}
