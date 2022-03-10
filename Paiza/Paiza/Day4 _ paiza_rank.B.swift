//
//  Day4 _ paiza_rank.B.swift
//  Paiza
//
//  Created by Kyus'lee on 2022/03/10.
//

import Foundation

//ネットサーフィン rank.B 再チャレンジ
//　Queueを用いたコードだとすごい簡単だった問題。。。
// 正しい作成
// 問題の条件をよく分析すること！
let testCase = Int(readLine()!)!
var resultPage = [String]()
var currentWindow = [String]()

for i in 0..<testCase {
    let command = readLine()!

    if i == 0 {
        if command != "go to blank page" {
            exit(0)
        }
    }

    if command == "use the back button" {
        backButton()
    } else {
        var command_Array = Array(command).map { String($0) }

        for _ in 0..<6 {
            command_Array.removeFirst()
        }

        var pageName = ""
        for j in command_Array {
            pageName += j
        }
        network_Surfing(pageName)
    }
}

while !resultPage.isEmpty {
    print(resultPage.removeFirst())
}

func network_Surfing(_ command: String) {
    currentWindow.append(command)
    resultPage.append(command)
}

func backButton() {
    if currentWindow.last! == "blank page" {
        exit(0)
    }
    currentWindow.removeLast()
    resultPage.append(currentWindow.last!)
}

//小さなライフゲーム　rank. B
let data = readLine()!.split(separator: " ").map { String($0) }
if (data[0].count != 10 || data[1].count != 4) {
    exit(0)
}

for i in data[0] {
    if String(i) != "+" && String(i) != "-" {
        exit(0)
    }
}
for i in data[1] {
    if String(i) != "+" && String(i) != "-" {
        exit(0)
    }
}

let startArray = Array(data[0]).map { String($0) }
let rule = Array(data[1]).map { String($0) }
var changingArray = startArray
var compareArray = startArray
var Index = 0

while Index < 20 {
    for i in 0..<compareArray.count {
        var nextLeft = i - 1
        var nextRight = i + 1

        if i == 0 {
            nextLeft = 9
        } else if i == 9 {
            nextRight = 0
        }

        if compareArray[nextLeft] == "-" && compareArray[nextRight] == "-" {
            changingArray[i] = rule[0]
        } else if compareArray[nextLeft] == "-" && compareArray[nextRight] == "+" {
            changingArray[i] = rule[1]
        } else if compareArray[nextLeft] == "+" && compareArray[nextRight] == "-" {
            changingArray[i] = rule[2]
        } else if compareArray[nextLeft] == "+" && compareArray[nextRight] == "+" {
            changingArray[i] = rule[3]
        }
    }
    compareArray = changingArray
    if compareArray == startArray {
        print("YES")
        exit(0)
    }

    Index += 1
}

if compareArray != startArray {
    print("NO")
}

//ダーツゲーム　rank.B の中級レベル
//　計算が近似値は出るが、どうしても正確な値にならない。。なんでだろう。
// ‼️⚠️解決できなかったやつ

var pi = Double.pi
var g = 9.8
let data1 = readLine()!.split(separator: " ").map { Double(String($0))! }
let o_y = data1[0], arrowSpeed = data1[1], angle = data1[2]

guard check_1(o_y, arrowSpeed, angle) else {
    exit(0)
}

let data2 = readLine()!.split(separator: " ").map { Double(String($0))! }
let distanceX = data2[0], targetHeight = data2[1], diameter = data2[2]

guard check_2(distanceX, targetHeight, diameter) else {
    exit(0)
}

let radius = diameter / 2
var arrowLocation = isArrowLocation(arrowSpeed, angle, distanceX)

if ((targetHeight - radius) + 0.05 <= arrowLocation) && arrowLocation <= (targetHeight + radius) - 0.05 {
    var roundValue = Double(0)
    roundValue = abs(targetHeight - arrowLocation)
    roundValue = roundValue * 10
    roundValue = round(roundValue)
    roundValue = roundValue / 10

    print("Hit \(roundValue)")
} else {
    print("Miss")
}

//⚠️ここで、何かが計算が正しく四捨五入されない。。
func isArrowLocation(_ s: Double, _ seta: Double, _ x: Double) -> Double {
    var result = Double(0)
    let tan_seta = tan((seta * pi) / 180)
    let x_2 = x * x
    let s_2 = s * s
    let cos_seta = cos((seta * pi) / 180)

    result = o_y + (x * tan_seta) - (g * x_2) / (2 * s_2 * cos_seta)

    return result
}

func check_1(_ num1: Double, _ num2: Double, _ num3: Double) -> Bool {
    let isChecked1 = true

    if num1 < 0 || num1 > 100 {
        return false
    }

    if num2 < 1 || num2 > 100 {
        return false
    }

    if num3 < 0 || num3 > 90 {
        return false
    }

    return isChecked1
}

func check_2(_ num1: Double, _ num2: Double, _ num3: Double) -> Bool {
    let isChecked2 = true

    if num1 < 1 || num1 > 100 {
        return false
    }

    if num2 < 0 || num2 > 100 {
        return false
    }

    if num3 < 1 || num3 > 100 {
        return false
    }

    return isChecked2
}

//提出したコード
import Foundation

var pi = Double.pi
var g = 9.8
let data1 = readLine()!.split(separator: " ").map { Double(String($0))! }
let o_y = data1[0], arrowSpeed = data1[1], angle = data1[2]

guard check_1(o_y, arrowSpeed, angle) else {
    exit(0)
}


let data2 = readLine()!.split(separator: " ").map { Double(String($0))! }
let distanceX = data2[0], targetHeight = data2[1], diameter = data2[2]

guard check_2(distanceX, targetHeight, diameter) else {
    exit(0)
}

let radius = diameter / 2
var arrowLocation = isArrowLocation(arrowSpeed, angle, distanceX)

if ((targetHeight - radius) + 0.05 <= arrowLocation) && arrowLocation <= (targetHeight + radius) - 0.05 {
    var roundValue = 0.00
    roundValue = abs(targetHeight - arrowLocation)
    roundValue = roundValue * 10
    roundValue = round(roundValue)
    roundValue = roundValue / 10

    print("Hit \(roundValue)")
} else {
    print("Miss")
}

//ここで、何かが計算が正しく四捨五入されない。。
func isArrowLocation(_ s: Double, _ seta: Double, _ x: Double) -> Double {
    var result = Double(0)
    let tan_seta = tan((seta * pi) / 180)
    let x_2 = x * x
    let s_2 = s * s
    let cos_seta = cos((seta * pi) / 180)
    var a = Double(0)
    var b = Double(0)
    a = g * x_2
    b = 2 * s_2 * cos_seta

    result = o_y + (x * tan_seta) - a / b

    return result
}

func check_1(_ num1: Double, _ num2: Double, _ num3: Double) -> Bool {
    let isChecked1 = true

    if num1 < 0 || num1 > 100 {
        return false
    }

    if num2 < 1 || num2 > 100 {
        return false
    }

    if num3 < 0 || num3 > 90 {
        return false
    }

    return isChecked1
}

func check_2(_ num1: Double, _ num2: Double, _ num3: Double) -> Bool {
    let isChecked2 = true

    if num1 < 1 || num1 > 100 {
        return false
    }

    if num2 < 0 || num2 > 100 {
        return false
    }

    if num3 < 1 || num3 > 100 {
        return false
    }

    return isChecked2
}

//爆弾の大爆発 rank.B
// DFSを用いた方法
let data = readLine()!.split(separator: " ").map { Int(String($0))! }
let rowSize = data[0], columnSize = data[1]
var field = [[String]]()
var visited = Array(repeating: Array(repeating: false, count: columnSize), count: rowSize)
var result = 0

for _ in 0..<rowSize {
    let putBomb = readLine()!

    for i in putBomb {
        if i != "." && i != "#" {
            exit(0)
        }
    }

    let bombData = Array(putBomb).map { String($0) }
    field += [bombData]
}

for i in 0..<rowSize {
    for j in 0..<columnSize {
        if field[i][j] == "#" {
            if !visited[i][j] {
                dfs_explosion(i, j)
            }
        }
    }
}

for i in 0..<rowSize {
    for j in 0..<columnSize {
        if visited[i][j] {
            result += 1
        }
    }
}

print(result)

func dfs_explosion(_ rowStart: Int, _ columnStart: Int) {
    visited[rowStart][columnStart] = true

    for i in 0..<columnSize {
        if !visited[rowStart][i] {
            if field[rowStart][i] == "#" {
                dfs_explosion(rowStart, i)
            } else {
                visited[rowStart][i] = true
            }
        }
    }

    for i in 0..<rowSize {
        if !visited[i][columnStart] {
            if field[i][columnStart] == "#" {
                dfs_explosion(i, columnStart)
            } else {
                visited[i][columnStart] = true
            }
        }
    }
}

//楽しい暗号解読 rank.B
//カフェが閉まったため、時間内に解けなかった...
//⚠️途中の段階
let data = Array(readLine()!.split(separator: " ").map { String($0) })
var check = [Character]()

guard conditionCheck() else {
    exit(0)
}

let testNum = Int(data[0])!, sentence = data[1]
var alphabet_Array = [Character]()

for i in Character("a").asciiValue!...Character("z").asciiValue! {
    let alphabet = Character(UnicodeScalar(i))
    alphabet_Array.append(alphabet)
}
let arabia: [Character] = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", " "]

let compare = readLine()!.split(separator: " ").map { String($0) }

for i in 0..<compare.count {
    if !compareCheck(compare[i]) {
        exit(0)
    }
}

func conditionCheck() -> Bool {
    let noPossible = true
    
    if Character(data[0]).wholeNumberValue! < 0 || Character(data[0]).wholeNumberValue! > 100 {
        return false
    }

    if data[1].count != 26 {
        return false
    }

    for i in data[1] {
        if !check.contains(i) {
            check.append(i)
        } else {
            return false
        }
    }
    
    return noPossible
}

func compareCheck(_ str: String) -> Bool {
    var noPossible = true
    
    for i in str {
        if !arabia.contains(i) && !alphabet_Array.contains(i) {
            noPossible = false
        }
    }
    return noPossible
}
