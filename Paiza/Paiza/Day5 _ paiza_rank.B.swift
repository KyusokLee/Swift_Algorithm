//
//  Day5 _ paiza.swift
//  Paiza
//
//  Created by Kyus'lee on 2022/03/11.
//

import Foundation

//秘密の言葉　rank.B
let data = readLine()!.split(separator: " ").map { Int(String($0))! }
if data[0] < 1 || data[0] > 50 || data[1] < 1 || data[1] > 50 {
    exit(0)
}
var fieldData = [[Character]]()
var alphabetArray = [Character]()
for i in Character("A").asciiValue!...Character("Z").asciiValue! {
    alphabetArray.append(Character(UnicodeScalar(i)))
}

let fieldSize = data[0], wordsCount = data[1]
var result: [(column: Int, row: Int)] = []

for _ in 0..<fieldSize {
    let putChar = readLine()!
    if !conditionCheck(putChar) {
        exit(0)
    }
    fieldData += [Array(putChar)]
}

for _ in 0..<wordsCount {
    let word = readLine()!
    if !wCheck(word) {
        exit(0)
    }

    let wordArray = Array(word)

    for i in 0..<fieldSize {
        for j in 0..<fieldSize {
            if fieldData[i][j] == wordArray[0] {
                if findingWord(i, j, wordArray) {
                    result.append((j + 1, i + 1))
                }
            }
        }
    }
}

for i in 0..<result.count {
    print("\(result[i].column) \(result[i].row)")
}

func findingWord(_ rowStart: Int, _ columnStart: Int, _ target: [Character]) -> Bool {
    let canFind = true
    var mutateRow = rowStart
    var mutateColumn = columnStart

    for i in 1..<target.count {
        let nextRow = mutateRow + 1
        let nextColumn = mutateColumn + 1

        if nextRow >= fieldSize || nextColumn >= fieldSize {
            return false
        }

        if fieldData[nextRow][nextColumn] == target[i] {
            mutateRow = nextRow
            mutateColumn = nextColumn
        } else {
            return false
        }
    }

    return canFind
}

func conditionCheck(_ str: String) -> Bool {
    guard str.count == fieldSize else {
        exit(0)
    }

    let isPossible = true
    let strArray = Array(str)

    for i in strArray {
        if !alphabetArray.contains(i) {
            return false
        }
    }

    return isPossible
}

func wCheck(_ str2: String) -> Bool {
    guard 1 <= str2.count && str2.count <= fieldSize else {
        exit(0)
    }

    let wArray = Array(str2)

    for i in wArray {
        if !alphabetArray.contains(i) {
            return false
        }
    }

    return true
}

//メダル授与式 rank.C
let players = Int(readLine()!)!
if players < 3 || players > 100 {
    exit(0)
}

var rank = Array(repeating: 0, count: players)
let points = readLine()!
if points.count < 0 || points.count > 2000 {
    exit(0)
}
let pointsArray = points.split(separator: " ").map { Int(String($0))! }
if pointsArray.count != players {
    exit(0)
}

for i in 0..<pointsArray.count {
    var rankcount = 1
    let compare = pointsArray[i]
    for j in 0..<pointsArray.count {
        if compare < pointsArray[j] {
            rankcount += 1
        }
    }
    rank[i] = rankcount
}

for i in 0..<rank.count {
    if rank[i] == 1 {
        print("G")
    } else if rank[i] == 2 {
        print("S")
    } else if rank[i] == 3 {
        print("B")
    } else {
        print("N")
    }
}

//時差を求めたい　rank.C ランクCの頂点
// 反例が何かわからない。。
// 問題文の解析が微妙におかしい

var rangeArray1 = Array(1...100).map { String($0) }
var rangeArray2 = Array(-12...14).map { String($0) }
let cities = readLine()!

if !rangeArray1.contains(cities) {
    exit(0)
}

let citiesCount = Int(cities) ?? 0

var alphabetArray = [Character]()
for i in Character("a").asciiValue!...Character("z").asciiValue! {
    alphabetArray.append(Character(UnicodeScalar(i)))
}

var cityName = [String]()
var cityTime = [Int]()

for _ in 0..<citiesCount {
    let cityHour = readLine()!.split(separator: " ").map { String($0) }
    if !conditionCheck(cityHour[0], cityHour[1]) {
        exit(0)
    }
    if !cityName.contains(cityHour[0]){
        cityName.append(cityHour[0])
        cityTime.append(Int(cityHour[1]) ?? 0)
    } else {
        exit(0)
    }
}

let compareData = readLine()!.split(separator: " ").map { String($0) }
let compareCity = compareData[0]
var hh = "", mm = ""
if !cityName.contains(compareCity) || !timeCheck(compareData[1]) {
    exit(0)
}

let compareTime = compareData[1]
var resultTime = Array(compareTime)

var cityTimeArray = [String]()
let timeIndex = cityTime[cityName.firstIndex(of: compareCity)!]

for i in 0..<cityName.count {
    var resultTime = ""
    var putH = 0
    
    if 0 <= cityTime[i] && cityTime[i] < 12 {
        putH = 12 + cityTime[i]
        let stringChange = String(putH)
        resultTime = stringChange + ":" + mm
    } else if cityTime[i] >= 12 {
        putH = cityTime[i] - 12
        let stringChange2 = String(putH)
        resultTime = "0" + stringChange2 + ":" + mm
    } else if -12 <= cityTime[i] && cityTime[i] < 0 {
        //マイナス部分処理がよくわからない
        let absTime = abs(cityTime[i])
        let distance = timeIndex + absTime
        if 0 <= Int(hh)! - distance && Int(hh)! - distance <= 9  {
            resultTime = "0" + String(Int(hh)! - distance) + ":" + mm
        } else if Int(hh)! - distance >= 10 {
            resultTime = String(Int(hh)! - distance) + ":" + mm
        }
        if distance <= 0 {
            if distance == 0 {
                resultTime = "00" + ":" + mm
            } else {
                resultTime = String(24 - distance) + ":" + mm
            }
        } else if distance >= 10 {
            resultTime = String(distance) + ":" + mm
        } else if 0 < distance && distance < 10 {
            resultTime = "0" + String(distance) + ":" + mm
        }
    }
    
    cityTimeArray.append(resultTime)
}

for i in 0..<cityTimeArray.count {
    print(cityTimeArray[i])
}

func conditionCheck(_ str: String, _ time: String) -> Bool {
    let isPossible = true
    let strArray = Array(str)
    
    for i in strArray {
        if !alphabetArray.contains(i) {
            exit(0)
        }
    }
    
    guard 1 <= str.count && str.count <= 20 else {
        exit(0)
    }
    
    if !rangeArray2.contains(time) {
        exit(0)
    }
    
    return isPossible
}

func timeCheck(_ time: String) -> Bool {
    let arabiaArr = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
    var isOkay = false
    
    let timeArray = Array(time)
    if timeArray.count != 5 {
        exit(0)
    }
    var specialChar = [Character]()
    
    for i in 0..<timeArray.count {
        if timeArray[i] == ":" {
            specialChar.append(timeArray[i])
        }
    }
    
    if specialChar.count != 1{
        exit(0)
    }
    
    var hh1 = "", mm1 = ""

    for i in 0..<timeArray.count {
        
        if i < 2 {
            let a = String(timeArray[i])
            if !arabiaArr.contains(a) {
                exit(0)
            }
            hh1 += a
        } else if i == 2 {
            continue
        } else if i > 2 {
            let b = String(timeArray[i])
            if !arabiaArr.contains(b) {
                exit(0)
            }

            mm1 += b
        }
    }
    
    let IntHour = Int(hh1) ?? 0
    let IntMin = Int(mm1) ?? 0
    
    if (0 <= IntHour && IntHour <= 23) && (0 <= IntMin && IntMin <= 59) {
        isOkay = true
    }
    
    hh = hh1
    mm = mm1
    
    return isOkay
}


