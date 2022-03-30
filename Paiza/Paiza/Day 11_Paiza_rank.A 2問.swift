//
//  Day11.swift
//  Paiza
//
//  Created by Kyus'lee on 2022/03/30.
//

import Foundation

//読書の課題 rank.A
//　高難度問題
// 🔥必須問題🔥
// Dynamic Programming (ナップサック問題の基本例)
// ナップサック問題には、二つの種類がある　-> Fractional　Problem(入れる商品を割れるのが可能), 0/1問題 (割れることができない)
// 今回は、0/1問題の基本例であり、Brute Force と、Greedyのどっちかを用いればいい

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

//再チャレンジのコード
//最後のテストケースが間違ってた
typealias bookInfo = (page: Int, day: Int)
let data = readLine()!.split(separator: " ")
var books = 0, vacationDays = 0
if !conditionCheck() {
    exit(0)
}
var dp = Array(repeating: 0, count: vacationDays + 1)
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

//後ろからloopした方が効率的である --> 理由: 後ろの配列から確認すると、その前のindexはまだ更新されてないから、うまく実装できる
for i in 0..<bookArray.count {
    let selectPage = bookArray[i].page
    let selectDay = bookArray[i].day

    for j in stride(from: vacationDays, to: 0, by: -1) {
        if j - selectDay >= 0 {
            dp[j] = max(dp[j], dp[j - selectDay] + selectPage)
        }
    }
}

print(dp[dp.lastIndex(where: { $0 == dp.max()! })!])

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

//ロボットへの命令 rank.A
typealias Locate = (row: Int, column: Int)
let data = readLine()!.split(separator: " ")
var rowSize = 0, columnSize = 0

guard conditionCheck() else {
    exit(0)
}

var map = [[Character]]()
var start: Locate = (0, 0), sCheck = 0
var end: Locate = (0, 0), gCheck = 0
var isPossible = false
let directionRow = [0, 0, 1, -1] //東西南北
let directionColumn = [1, -1, 0, 0]

for i in 0..<rowSize {
    let putData = Array(readLine()!)
    if !conditionCheck2(putData) {
        exit(0)
    }
    
    if let s = putData.firstIndex(of: "S") {
        start = (i, s)
        sCheck += 1
        if sCheck > 1 {
            exit(0)
        }
    }
    
    if let g = putData.firstIndex(of: "G") {
        end = (i, g)
        gCheck += 1
        if gCheck > 1 {
            exit(0)
        }
    }
    
    map += [putData]
}

var result = ""
dfs_findGoal(start.row, start.column, "")
if isPossible {
    print(result)
} else {
    exit(0)
}

func dfs_findGoal(_ rowStart: Int, _ columnStart: Int, _ command: String) {
    if (rowStart, columnStart) == end {
        result = command
        isPossible = true
        return
    }
    
    for i in 0..<4 {
        let nextRow = rowStart + directionRow[i]
        let nextColumn = columnStart + directionColumn[i]
        
        if nextRow < 0 || nextRow >= rowSize || nextColumn < 0 || nextColumn >= columnSize || map[nextRow][nextColumn] == "#" {
            continue
        }
        
        if map[nextRow][nextColumn] == "." || map[nextRow][nextColumn] == "G" {
            if i == 0 {
                map[nextRow][nextColumn] = "R"
            } else if i == 1 {
                map[nextRow][nextColumn] = "L"
            } else if i == 2 {
                map[nextRow][nextColumn] = "D"
            } else if i == 3 {
                map[nextRow][nextColumn] = "U"
            }
            dfs_findGoal(nextRow, nextColumn, command + String(map[nextRow][nextColumn]))
        }
    }
}

func conditionCheck() -> Bool {

    if let intRow = Int(data[0]) {
        if intRow < 1 || intRow > 100 {
            return false
        } else {
            if let intColumn = Int(data[1]) {
                if intColumn < 1 || intColumn > 100 {
                    return false
                } else {
                    rowSize = intRow
                    columnSize = intColumn
                }
            }
        }
    } else {
        return false
    }

    return true
}

func conditionCheck2(_ compare: [Character]) -> Bool {
    if compare.count > columnSize {
        return false
    } else {
        for i in compare {
            if i != "#" && i != "." && i != "S" && i != "G" {
                return false
            }
        }
    }
    
    return true
}
