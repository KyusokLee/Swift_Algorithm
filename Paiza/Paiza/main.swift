//
//  main.swift
//  Paiza
//
//  Created by Kyus'lee on 2022/02/16.
//

import Foundation

////ライブスケジュール問題 Rank.C
//let bandA_live = Int(readLine()!)!
//var live_schedule = Array(repeating: Array(repeating: "x", count: 2), count: 31)
//var index = 0
//
//for _ in 0..<bandA_live {
//    let liveA_day = Int(readLine()!)!
//    live_schedule[liveA_day - 1][0] = "A"
//}
//
//let bandB_live = Int(readLine()!)!
//for _ in 0..<bandB_live {
//    let liveB_day = Int(readLine()!)!
//    live_schedule[liveB_day - 1][1] = "B"
//}
//
//for day in live_schedule {
//    if day == ["A", "B"] {
//        if day[index] == "A" {
//            print(day[index])
//            index = 1
//        } else if day[index] == "B" {
//            print(day[index])
//            index = 0
//        }
//    } else if day == ["A", "x"] {
//        print(day[0])
//    } else if day == ["x", "B"] {
//        print(day[1])
//    } else {
//        print("x")
//    }
//}
//
////カラオケ大会 Rank.B
//let data = readLine()!.split(separator: " ").map { Int(String($0))! }
//var point_array = Array(repeating: Array(repeating: 0, count: data[1]), count: data[0])
//var standard_array = [Int]()
//var max_score = 0
//
//
//for _ in 0..<data[1] {
//    standard_array += [Int(readLine()!)!]
//}
//
//for i in 0..<data[0] {
//    for j in 0..<data[1] {
//        point_array[i][j] = Int(readLine()!)!
//    }
//}
//
//for i in point_array {
//    grading(i)
//}
//
//print(max_score)
//
//func grading(_ points: [Int]) {
//    var max_compare = 100
//
//    for i in 0..<points.count {
//        if abs(points[i] - standard_array[i]) <= 5 {
//            continue
//        } else if 5 < abs(points[i] - standard_array[i]) && abs(points[i] - standard_array[i]) <= 10 {
//            max_compare -= 1
//        } else if 10 < abs(points[i] - standard_array[i]) && abs(points[i] - standard_array[i]) <= 20 {
//            max_compare -= 2
//        } else if 20 < abs(points[i] - standard_array[i]) && abs(points[i] - standard_array[i]) <= 30 {
//            max_compare -= 3
//        } else if 30 < abs(points[i] - standard_array[i]) {
//            max_compare -= 5
//        }
//    }
//
//    if max_score < max_compare {
//        max_score = max_compare
//    }
//}

////山の頂上を探せ Rank.B
//let mapSize = Int(readLine()!)!
//var mapData = [[Int]]()
//let directionRow = [0, 0, -1, 1]
//let directionColumn = [1, -1, 0, 0]
//var mountain_top = [Int]()
//
//for _ in 0..<mapSize {
//    mapData += [readLine()!.split(separator: " ").map { Int(String($0))! }]
//}
//
//for i in 0..<mapSize {
//    for j in 0..<mapSize {
//        if Find_Top(i, j) {
//            mountain_top.append(mapData[i][j])
//        }
//    }
//}
//
//mountain_top.sort(by: >)
//
//for i in 0..<mountain_top.count {
//    print(mountain_top[i])
//}
//
//func Find_Top(_ rowStart: Int, _ columnStart: Int) -> Bool {
//    let compareValue = mapData[rowStart][columnStart]
//    var isTop = true
//
//    for i in 0..<4 {
//        let nextRow = rowStart + directionRow[i]
//        let nextColumn = columnStart +  directionColumn[i]
//
//        if nextRow < 0 || nextRow >= mapSize || nextColumn < 0 || nextColumn >= mapSize {
//            continue
//        }
//
//        let compareRound = mapData[nextRow][nextColumn]
//
//        if compareValue <= compareRound {
//            isTop = false
//        }
//    }
//
//    return isTop
//}

////マッピングゲーム　rank.B
//// 非常に難しい問題
//// 配列のIndexの処理に常に注意をすること！　Indexのエラーを探すのに結構時間がかかってしまった。
//// もっと早く解決できたはず
//let data = readLine()!.split(separator: " ").map { Int(String($0))! }
//let turn_Count = data[0], ySize = data[1], xSize = data[2]
//var board_Size = Array(repeating: Array(repeating: false, count: xSize), count: ySize)
//var red_Have = Array(repeating: Array(repeating: false, count: xSize), count: ySize)
//var blue_Have = Array(repeating: Array(repeating: false, count: xSize), count: ySize)
//var green_Have = Array(repeating: Array(repeating: false, count: xSize), count: ySize)
//let playersCount = 3
//var red_Count = 0, blue_Count = 0, green_Count = 0
//
//for _ in 0..<turn_Count {
//    for i in 0..<playersCount {
//        let putData = readLine()!.split(separator: " ").map { Int(String($0))! }
//        let x = putData[0], y = putData[1], massSize = putData[2]
//
//        putColor(i, x, y, massSize)
//    }
//}
//
//for i in 0..<ySize {
//    for j in 0..<xSize {
//        if red_Have[i][j] {
//            red_Count += 1
//        } else if blue_Have[i][j] {
//            blue_Count += 1
//        } else if green_Have[i][j] {
//            green_Count += 1
//        }
//    }
//}
//
//print("\(red_Count) \(blue_Count) \(green_Count)")
//
//func putColor(_ player: Int, _ xStart: Int, _ yStart: Int, _ mass: Int) {
//    for i in yStart..<(yStart + mass) {
//        guard i < ySize else {
//            return
//        }
//        for j in xStart..<(xStart + mass) {
//            guard j < xSize else {
//                break
//                //ここをreturnにしたせいで、passできなかった
//            }
//
//            if board_Size[i][j] {
//                checkingColor(player, i, j)
//            } else {
//                board_Size[i][j] = true
//                if player == 0 {
//                   red_Have[i][j] = true
//                } else if player == 1 {
//                    blue_Have[i][j] = true
//                } else {
//                   green_Have[i][j] = true
//                }
//            }
//        }
//    }
//}
//
//func checkingColor(_ player: Int, _ y: Int, _ x: Int) {
//    if player == 0 {
//        if blue_Have[y][x] {
//            blue_Have[y][x] = false
//            green_Have[y][x] = true
//        } else if green_Have[y][x] {
//            green_Have[y][x] = false
//            blue_Have[y][x] = true
//        } else if red_Have[y][x] {
//            return
//        }
//
//    } else if player == 1 {
//        if red_Have[y][x] {
//            red_Have[y][x] = false
//            green_Have[y][x] = true
//        } else if green_Have[y][x] {
//            green_Have[y][x] = false
//            red_Have[y][x] = true
//        } else if blue_Have[y][x] {
//            return
//        }
//
//    } else {
//        if red_Have[y][x] {
//            red_Have[y][x] = false
//            blue_Have[y][x] = true
//        } else if blue_Have[y][x] {
//            blue_Have[y][x] = false
//            red_Have[y][x] = true
//        } else if green_Have[y][x] {
//            return
//        }
//    }
//
//}

//ネットサーフィン rank.B
// indexの扱いが複雑だった問題
// 結構難しい問題 >> 文字列の処理が弱点であることを再び思い知った
//⚠️途中の段階
//‼️完全に理解するように、徹底的に復習すること！‼️
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
