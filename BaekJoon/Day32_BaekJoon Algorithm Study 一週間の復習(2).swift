//
//  Day32.swift
//  BaekJoon
//
//  Created by Kyus'lee on 2022/03/12.
//

import Foundation

//Day32 Week4 ~ 5: 一週間の復習 (2)

//BaekJoon Algorithm Study n.14891 (歯車) 重要度：🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖
//🔥解いてみた問題の中で、一番難しかった..🔥
// ‼️📮Hard: ⭐️⭐️⭐️
var wheelsData = [[Int]]()
var poles = [(left: Int, right: Int)](repeating:(6, 2), count: 4)
var moveInit = [Bool](repeating: false, count: 4)
var isMoved = moveInit
var resultSum = 0

for _ in 0..<4 {
    wheelsData += [readLine()!.map { Int(String($0))! }]
}

let turnCount = Int(readLine()!)!

for _ in 0..<turnCount {
    let turnCommand = readLine()!.split(separator: " ").map { Int(String($0))! }
    let wheelNum = turnCommand[0], wheelTurn = turnCommand[1]
    wheelTurning(wheelNum - 1, wheelTurn)
    isMoved = moveInit
}

for i in 0..<4 {
    //🔥この12時方向の値を求めるのが難しかった。。
    let direction_12clock = (poles[i].left + 2) % 8
    //説明:歯車のデータ（S極かN極か）は最初に入力された状態から変わらない.. しかし、それぞれの歯車の9時方向 (left) と3時方向 (right) の極を表す polesの値をwheelTurning関数で更新した。そのため、polesの値を基準にdirection_12clockにたどりつくことになる
    if wheelsData[i][direction_12clock] == 1 {
        resultSum += Int(pow(Double(2), Double(i)))
    }
}

print(resultSum)

func wheelTurning(_ num: Int, _ turnDirection: Int) {
    isMoved[num] = true
    let (left, right) = poles[num]

    if 0 <= num - 1 && !isMoved[num - 1] {
        //左の歯車があるということ
        let (_ , rightIndex) = poles[num - 1]
        if wheelsData[num][left] != wheelsData[num - 1][rightIndex] {
            wheelTurning(num - 1, turnDirection * (-1))
        }
    }

    if num + 1 < 4 && !isMoved[num + 1] {
        //右の歯車があるということ
        let (leftIndex, _) = poles[num + 1]
        if wheelsData[num][right] != wheelsData[num + 1][leftIndex] {
            wheelTurning(num + 1, turnDirection * (-1))
        }
    }

    if turnDirection == 1 {
        //時計回りの場合、該当する歯車のleftとrightのindexを変える作業を行う
        poles[num].left = (poles[num].left + 7) % 8 // -1になるのを 全体個数である8から-1をした7を足すという形にした (配列であるため)
        poles[num].right = (poles[num].right + 7) % 8
    } else if turnDirection == -1 {
        //反時計回りの場合、該当する歯車のleftとrightのindexを変える作業を行う
        poles[num].left = (poles[num].left + 1) % 8
        poles[num].right = (poles[num].right + 1) % 8
    }
}

//BaekJoon Algorithm Study n.11559 (ぷよぷよ) 重要度：🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖
//最後に入力されたのを配列[0]にする　-> 理由: 最後に入力される行が一番下の行(テトリスの原則上)になるから
// ‼️📮Hard: ⭐️⭐️
var field = [[Character]]()
let directionRow = [0, 0, -1, 1]
let directionColumn = [1, -1, 0, 0]
var comboCount = 0

for _ in 0..<12 {
    field.insert(Array(readLine()!), at: 0)
}

while true {
    var checked = Array(repeating: Array(repeating: false, count: 6), count: 12)
    var canBoom = false

    for i in 0..<12 {
        for j in 0..<6 {
            if field[i][j] != "." {
                if bfs_select_firstBomb(i, j, field[i][j], &checked) {
                    canBoom = true
                }
            }
        }
    }

    if !canBoom {
        break
    } else {
        puyopuyo()
        comboCount += 1
    }
}

print(comboCount)

func bfs_select_firstBomb(_ rowStart: Int, _ columnStart: Int, _ target: Character, _ checked: inout [[Bool]]) -> Bool {

    var neededCheckQueue = [(rowStart, columnStart)]
    var isPossible = false
    var count = 1
    var Index = 0
    checked[rowStart][columnStart] = true

    while Index < neededCheckQueue.count {
        let (currentRow, currentColumn) = neededCheckQueue[Index]

        for i in 0..<4 {
            let nextRow = currentRow + directionRow[i]
            let nextColumn = currentColumn + directionColumn[i]

            if nextRow < 0 || nextRow >= 12 || nextColumn < 0 || nextColumn >= 6 {
                continue
            }

            if field[nextRow][nextColumn] == target && !checked[nextRow][nextColumn] {
                neededCheckQueue.append((nextRow, nextColumn))
                checked[nextRow][nextColumn] = true
                count += 1
            }
        }
        Index += 1
    }

    if count >= 4 {
        for (row, column) in neededCheckQueue {
            field[row][column] = "."
        }
        isPossible = true
    }

    return isPossible
}

func puyopuyo() {
    for i in 0..<6 {
        for j in 0..<11 {
            for k in j + 1..<12 {
                if field[j][i] == "." && field[k][i] != "." {
                    field[j][i] = field[k][i]
                    field[k][i] = "."
                    break
                }
            }
        }
    }
}

//BaekJoon Algorithm Study n.1316 (グループ単語チェック) 重要度：🎖🎖🎖🎖
let wordsCase = Int(readLine()!)!
var groupWordCount = 0

for _ in 0..<wordsCase {
    let word = readLine()!
    if isGroupWord(word) {
        groupWordCount += 1
    }
}

print(groupWordCount)

func isGroupWord(_ str: String) -> Bool {
    var check = true
    var checkedAlpha = [Character]()
    var beforeAlpha = Character("!")
    
    
    for char in str {
        if !checkedAlpha.contains(char) {
            checkedAlpha.append(char)
            beforeAlpha = char
        } else {
            if beforeAlpha != char {
                check = false
            }
        }
    }
    
    return check
}
// ❗️理想はここまでは明日絶対解いておきたい！
