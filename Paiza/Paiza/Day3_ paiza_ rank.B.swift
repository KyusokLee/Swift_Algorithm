//
//  Day3_ paiza_ rank.B.swift
//  Paiza
//
//  Created by Kyus'lee on 2022/03/09.
//

import Foundation

//マッピングゲーム　rank.B
// 非常に難しい問題
// 配列のIndexの処理に常に注意をすること！　Indexのエラーを探すのに結構時間がかかってしまった。
// もっと早く解決できたはず
let data = readLine()!.split(separator: " ").map { Int(String($0))! }
let turn_Count = data[0], ySize = data[1], xSize = data[2]
var board_Size = Array(repeating: Array(repeating: false, count: xSize), count: ySize)
var red_Have = Array(repeating: Array(repeating: false, count: xSize), count: ySize)
var blue_Have = Array(repeating: Array(repeating: false, count: xSize), count: ySize)
var green_Have = Array(repeating: Array(repeating: false, count: xSize), count: ySize)
let playersCount = 3
var red_Count = 0, blue_Count = 0, green_Count = 0

for _ in 0..<turn_Count {
    for i in 0..<playersCount {
        let putData = readLine()!.split(separator: " ").map { Int(String($0))! }
        let x = putData[0], y = putData[1], massSize = putData[2]

        putColor(i, x, y, massSize)
    }
}

for i in 0..<ySize {
    for j in 0..<xSize {
        if red_Have[i][j] {
            red_Count += 1
        } else if blue_Have[i][j] {
            blue_Count += 1
        } else if green_Have[i][j] {
            green_Count += 1
        }
    }
}

print("\(red_Count) \(blue_Count) \(green_Count)")

func putColor(_ player: Int, _ xStart: Int, _ yStart: Int, _ mass: Int) {
    for i in yStart..<(yStart + mass) {
        guard i < ySize else {
            return
        }
        for j in xStart..<(xStart + mass) {
            guard j < xSize else {
                break
                //ここをreturnにしたせいで、passできなかった
            }

            if board_Size[i][j] {
                checkingColor(player, i, j)
            } else {
                board_Size[i][j] = true
                if player == 0 {
                   red_Have[i][j] = true
                } else if player == 1 {
                    blue_Have[i][j] = true
                } else {
                   green_Have[i][j] = true
                }
            }
        }
    }
}

func checkingColor(_ player: Int, _ y: Int, _ x: Int) {
    if player == 0 {
        if blue_Have[y][x] {
            blue_Have[y][x] = false
            green_Have[y][x] = true
        } else if green_Have[y][x] {
            green_Have[y][x] = false
            blue_Have[y][x] = true
        } else if red_Have[y][x] {
            return
        }

    } else if player == 1 {
        if red_Have[y][x] {
            red_Have[y][x] = false
            green_Have[y][x] = true
        } else if green_Have[y][x] {
            green_Have[y][x] = false
            red_Have[y][x] = true
        } else if blue_Have[y][x] {
            return
        }

    } else {
        if red_Have[y][x] {
            red_Have[y][x] = false
            blue_Have[y][x] = true
        } else if blue_Have[y][x] {
            blue_Have[y][x] = false
            red_Have[y][x] = true
        } else if green_Have[y][x] {
            return
        }
    }

}

//ネットサーフィン rank.B
//なんで、indexの処理にこだわったんだろう。。と思った問題 >> Queueだと5分で解けた
// 間違った作成
let testCase = Int(readLine()!)!
var pageArray = [String]()
var commandArray2 = [String]()
var beforePageIndex = 0, currentPageIndex = 0
var resultPage: [String] = []
var beforePage = ""

for _ in 0..<testCase {
    var pageName = ""
    let command = readLine()!
    commandArray2.append(command)

    var command_dividing = command.split(separator: " ").map { String($0) }

    for _ in 0..<2 {
        command_dividing.removeFirst()
    }

    if command != "use the back button" {
        pageName = command_dividing.joined(separator: " ")
        pageArray.append(pageName)
    }
}

for i in 0..<commandArray2.count {
    netSurfing(commandArray2[i])
}

for i in 0..<resultPage.count {
    print(resultPage[i])
}

func netSurfing(_ string: String ) {
    if string.contains("go to") {
        for i in 0..<pageArray.count {
            if string.contains(pageArray[i]) {
                resultPage.append(pageArray[i])
                break
            }
        }

        beforePageIndex = currentPageIndex - 1

        if beforePageIndex < 0 {
            beforePageIndex = 0
            beforePage = resultPage[beforePageIndex]
        } else {
            //ここがエラーが発生するらしいだね...
            beforePage = resultPage[beforePageIndex]
        }
        print("beforePage = \(beforePage)")
        currentPageIndex += 1

    } else if string.contains("use the") {
        resultPage.append(beforePage)
        currentPageIndex = beforePageIndex

    }
}
