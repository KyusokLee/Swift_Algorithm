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

//山の頂上を探せ Rank.B
let mapSize = Int(readLine()!)!
var mapData = [[Int]]()
let directionRow = [0, 0, -1, 1]
let directionColumn = [1, -1, 0, 0]
var mountain_top = [Int]()

for _ in 0..<mapSize {
    mapData += [readLine()!.split(separator: " ").map { Int(String($0))! }]
}

for i in 0..<mapSize {
    for j in 0..<mapSize {
        if Find_Top(i, j) {
            mountain_top.append(mapData[i][j])
        }
    }
}

mountain_top.sort(by: >)

for i in 0..<mountain_top.count {
    print(mountain_top[i])
}

func Find_Top(_ rowStart: Int, _ columnStart: Int) -> Bool {
    let compareValue = mapData[rowStart][columnStart]
    var isTop = true
    
    for i in 0..<4 {
        let nextRow = rowStart + directionRow[i]
        let nextColumn = columnStart +  directionColumn[i]
        
        if nextRow < 0 || nextRow >= mapSize || nextColumn < 0 || nextColumn >= mapSize {
            continue
        }
        
        let compareRound = mapData[nextRow][nextColumn]
        
        if compareValue <= compareRound {
            isTop = false
        }
    }
    
    return isTop
}
