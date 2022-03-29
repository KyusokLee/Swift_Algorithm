//
//  main.swift
//  Paiza
//
//  Created by Kyus'lee on 2022/02/16.
//

import Foundation


////⚠️Paizaの問題を解くときに注意すること：　＞＞　paizaでは、条件の設定が厳しいため、ちゃんと問題文の条件のみが入力されるように自分で設計しなければいけない‼️
////ライブスケジュール問題 Rank.C
//
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

////楽しい暗号解読 rank.B
////カフェが閉まったため、時間内に解けなかった...
//let data = Array(readLine()!.split(separator: " ").map { String($0) })
//var check = [Character]()
//
//guard conditionCheck() else {
//    exit(0)
//}
//
//let testNum = Int(data[0])!, sentence = Array(data[1])
//var alphabet_Array = [Character]()
//
//for i in Character("a").asciiValue!...Character("z").asciiValue! {
//    let alphabet = Character(UnicodeScalar(i))
//    alphabet_Array.append(alphabet)
//}
//
//let fullString = readLine()!
//var compare = fullString.split(separator: " ").map { String($0) }
//let compare_firstOne = Array(compare[0])[0]
//
//if fullString.count < 1 || fullString.count > 1000 ||  compare_firstOne == " " {
//    exit(0)
//}
//
//for _ in 0..<testNum {
//    for i in 0..<compare.count {
//        if !compareCheck(compare[i]) {
//            exit(0)
//        }
//
//        compare[i] = changing(compare[i])
//    }
//}
//
//print(compare.joined(separator: " "))
//
//func conditionCheck() -> Bool {
//    let noPossible = true
//
//    if Int(data[0])! < 0 || Int(data[0])! > 100 {
//        return false
//    }
//
//    if data[1].count != 26 {
//        return false
//    }
//
//    for i in data[1] {
//        if !check.contains(i) {
//            check.append(i)
//        } else {
//            return false
//        }
//    }
//
//    return noPossible
//}
//
//func compareCheck(_ str: String) -> Bool {
//    let noPossible = true
//
//    for i in str {
//        if i != " " && !alphabet_Array.contains(i) {
//            return false
//        }
//    }
//
//    return noPossible
//}
//
//func changing(_ str: String) -> String {
//    let toChange = Array(str)
//    var newString = ""
//    var index = 0
//
//    for i in 0..<toChange.count {
//        if sentence.contains(toChange[i]) {
//            index = sentence.firstIndex(of: toChange[i])!
//            newString += String(alphabet_Array[index])
//        }
//    }
//
//    return newString
//}

//読書の課題 rank.A
//　高難度問題
//⚠️途中の段階
typealias bookInfo = (page: Int, day: Int)
let data = readLine()!.split(separator: " ")
var books = 0, vacationDays = 0
if !conditionCheck() {
    exit(0)
}
var bookArray = [bookInfo]()
var maxPages = 0

for _ in 0..<books {
    let bookData = readLine()!.split(separator: " ")
    var pages = 0, expectDays = 0
    
    if let intPage = Int(bookData[0]) {
        if intPage < 1 || intPage > 1000 {
            exit(0)
        } else {
            if let intDays = Int(bookData[1]) {
                if intDays < 1 || intDays > vacationDays {
                    exit(0)
                } else {
                    pages = intPage
                    expectDays = intDays
                }
            }
        }
    } else {
        exit(0)
    }
    
    bookArray.append((pages, expectDays))
}

var checked = Array(repeating: false, count: books)
var tempPages = 0

print(dfs_select(0, 0, 0))

//アルゴリズムの設計がちょっと難しかった
func dfs_select(_ pages: Int, _ days: Int, _ index: Int) -> Int {
    if days > vacationDays {
        return 0
    }
    
    for i in index..<bookArray.count {
        if !checked[i] {
            tempPages += bookArray[i].page
            checked[i] = true
            if dfs_select(pages + bookArray[i].page, days + bookArray[i].day, index + 1) == 0 {
                tempPages -= bookArray[i].page
                maxPages = max(maxPages, tempPages)
                checked[i] = false
            }
            checked[i] = false
            tempPages -= bookArray[i].page
        }
    }
    
    return maxPages
}

func conditionCheck() -> Bool {
    
    if let intBook = Int(data[0]) {
        if intBook < 1 || intBook > 1000 {
            return false
        } else {
            if let intDays = Int(data[1]) {
                if intDays < 1 || intDays > 100 {
                    return false
                } else {
                    books = intBook
                    vacationDays = intDays
                }
            }
        }
    } else {
        return false
    }

    return true
}
