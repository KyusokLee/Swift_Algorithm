//
//  File.swift
//  Paiza
//
//  Created by Kyus'lee on 2022/03/17.
//

import Foundation

//Day9 rank.C　１問
//カードの合計 rank.C
let players = readLine()!
var intPlayers = 0
var result = 0
if !check1(players) {
    exit(0)
}
let arabiaArray = Array(0...100)
let cardData = readLine()!.split(separator: " ").map { String($0) }
var intCardData = [Int](), zeroData = [Int](), mul10Data = [String]()
if cardData.count != intPlayers {
    exit(0)
}
if !check2(cardData) {
    exit(0)
}

if cardData.count == 0 || zeroData.count >= 2 || mul10Data.count >= 2 {
    exit(0)
}

let maxValue = intCardData.max()!
var sumValue = intCardData.reduce(0, +)

if zeroData.isEmpty && mul10Data.isEmpty {
    result = sumValue
} else {
    if !zeroData.isEmpty {
        sumValue -= maxValue
        result = sumValue
    }
    
    if !mul10Data.isEmpty {
        sumValue *= 10
        result = sumValue
    }
}

print(result)

func check1(_ str: String) -> Bool {
    let isPossible = true
    
    if let intStr = Int(str) {
        if intStr < 1 || intStr > 100 {
            return false
        } else {
            intPlayers = intStr
        }
    } else {
        return false
    }
    
    
    return isPossible
}

func check2(_ str: [String]) -> Bool {
    let isPossible = true
    
    for i in str {
        if let intI = Int(i) {
            if arabiaArray.contains(intI) {
                if intI == 0 {
                    if !zeroData.contains(intI) {
                        zeroData.append(intI)
                    } else {
                        return false
                    }
                } else {
                    intCardData.append(intI)
                }
            } else {
                return false
            }
        } else if i == "x10" {
            if !mul10Data.contains(i) {
                mul10Data.append(i)
            } else {
                return false
            }
        } else {
            return false
        }
    }

    return isPossible
}
