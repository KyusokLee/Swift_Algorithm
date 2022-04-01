//
//  Day 43.swift
//  BaekJoon
//
//  Created by Kyus'lee on 2022/04/01.
//

import Foundation

//Day 43: ソート(Sort)　シリーズ(1)
//BaekJoon Algorithm Study n.1931 (会議室割り当て) 重要度: 🎖🎖🎖🎖🎖🎖🎖🎖
// Greedy + Sortの基本問題

//できるだけ多くの会議を進めるためには、前回の会議を早く終わらせなければならないため、会議が終わる時間順にソートし、その中では開始時間順にソートする。

typealias Time = (start: Int, end: Int)
let meetings = Int(readLine()!)!
var meetingSchedule: [Time] = [Time]()
var count = 0
var end = 0
var status = true

for _ in 0..<meetings {
    let putMeeting = readLine()!.split(separator: " ").map { Int(String($0))! }
    meetingSchedule.append((putMeeting[0], putMeeting[1]))
}

meetingSchedule.sort {
    //もし、会議の終了時間が同じければ、会議の開始時間が早い順でソートを行う
    if $0.1 == $1.1 {
        return $0.0 < $1.0
    }
    //会議の終了時間を優先にソートを行う
    return $0.1 < $1.1
}

for i in meetingSchedule {
    if i.start >= end {
        end = i.end
        count += 1
    }
}

print(count)

//BaekJoon Algorithm Study n.2752 (３つの数字のソート)
let data = readLine()!.split(separator: " ").map { Int(String($0))! }.sorted()
print(data.map { String($0) }.joined(separator: " "))

//BaekJoon Algorithm Study n.1427 (sort inside)
let data = readLine()!.map { Int(String($0))! }.sorted(by: >)
print(data.map { String($0) }.reduce("") { $0 + $1 })

//BaekJoon Algorithm Study n.11399 (ATM)  重要度: 🎖🎖🎖🎖🎖🎖🎖🎖
//Greedy + ソート

let people = Int(readLine()!)!
let waitingLine = readLine()!.split(separator: " ").map { Int(String($0))! }.sorted()
var timeforWait = Array(repeating: 0, count: people)

for i in 0..<people {
    if i == 0 {
        timeforWait[i] = waitingLine[i]
    } else {
        timeforWait[i] = timeforWait[i - 1] + waitingLine[i]
    }
}
print(timeforWait.reduce(0, +))

//BaekJoon Algorithm Study n.11651 (座標ソート2) 重要度: 🎖🎖
typealias xyGraph = (x: Int, y: Int)
let data = Int(readLine()!)!
var array = [xyGraph]()
for _ in 0..<data {
    let putXY = readLine()!.split(separator: " ").map { Int(String($0))! }
    array.append((putXY[0], putXY[1]))
}

array.sort {
    if $0.y == $1.y {
        return $0.x < $1.x
    }
    return $0.y < $1.y
}
var result = ""
for i in array {
    result += "\(i.x) \(i.y)\n"
}
print(result)

//BaekJoon Algorithm Study n.11728 (配列結合) 重要度: 🎖🎖🎖🎖🎖
// Two Pointer + sort アルゴリズム

//これは時間超過になってしまったコード
let data = readLine()!.split(separator: " ").map { Int(String($0))! }
var A = readLine()!.split(separator: " ").map { Int(String($0))! }
var B = readLine()!.split(separator: " ").map { Int(String($0))! }
var C = A + B

C.sort {
    return $0 < $1
}
print(C.map { String($0) }.joined(separator: " "))

//Two Pointerアルゴリズムを使ったコード (これも時間超過になってしまった。。。。)
let data = readLine()!.split(separator: " ").map { Int(String($0))! }
var A = readLine()!.split(separator: " ").map { Int(String($0))! }
var B = readLine()!.split(separator: " ").map { Int(String($0))! }
var C = Array(repeating: 0, count: data[0] + data[1])

var indexA = 0
var indexB = 0
var indexC = 0

while indexA < data[0] && indexB < data[1] {
    if A[indexA] <= B[indexB] {
        C[indexC] = A[indexA]
        indexA += 1
    } else {
        C[indexC] = B[indexB]
        indexB += 1
    }
    indexC += 1
}

//比較する要素が配列のindexを超えたため、まだ、判別しなかった要素が残っている場合
// 例) 上記のwhile文を回すと、A: 3 5,  B: 2 9 だと、 AのindexA が data[0] を超えてしまい、Bに格納されている9をまだ、Cに格納してない状況になる
while indexA < A.count {
    C[indexC] = A[indexA]
    indexA += 1
    indexC += 1
}

while indexB < B.count {
    C[indexC] = B[indexB]
    indexB += 1
    indexC += 1
}

print(C.map { String($0) }.joined(separator: " "))

//時間超過にならないコード
//https://gist.github.com/JCSooHwanCho/30be4b669321e7a135b84a1e9b075f88  のコードを参考
final class FileIO {
    private var buffer:[UInt8]
    private var index: Int

    init(fileHandle: FileHandle = FileHandle.standardInput) {
        buffer = Array(fileHandle.readDataToEndOfFile())+[UInt8(0)] // indexが範囲を超えるのを防止
        index = 0
    }

    @inline(__always) private func read() -> UInt8 {
        defer { index += 1 }

        return buffer.withUnsafeBufferPointer { $0[index] }
    }

    @inline(__always) func readInt() -> Int {
        var sum = 0
        var now = read()
        var isPositive = true

        while now == 10
            || now == 32 { now = read() } // 空白と改行を無視
        if now == 45{ isPositive.toggle(); now = read() } // 負数の処理
        while now >= 48, now <= 57 {
            sum = sum * 10 + Int(now-48)
            now = read()
        }

        return sum * (isPositive ? 1:-1)
    }

    @inline(__always) func readString() -> String {
        var str = ""
        var now = read()

        while now == 10
            || now == 32 { now = read() } // 空白と改行を無視

        while now != 10
            && now != 32 && now != 0 {
                str += String(bytes: [now], encoding: .ascii)!
                now = read()
        }

        return str
    }
}

let fileIO = FileIO()

let (n, m) = (fileIO.readInt(), fileIO.readInt())
var A = [Int]()
var B = [Int]()

for _ in 0..<n {
    A.append(fileIO.readInt())
}
for _ in 0..<m {
    B.append(fileIO.readInt())
}

var aIndex = 0
var bIndex = 0

var ordered = ""

while aIndex < A.count {
    if bIndex == B.count || A[aIndex] < B[bIndex] {
        ordered += "\(A[aIndex]) "
        aIndex += 1
    } else {
        ordered += "\(B[bIndex]) "
        bIndex += 1
    }
}

while bIndex < B.count {
    ordered += "\(B[bIndex]) "
    bIndex += 1
}

ordered.removeLast()
print(ordered)

//BaekJoon Algorithm Study n. 10815 (数字カード)　重要度: 🎖🎖🎖🎖🎖🎖
// 二分探索(BinarySearch) + sort
let cards = Int(readLine()!)!
var haveCard = readLine()!.split(separator: " ").map { Int(String($0))! }.sorted()
let showNum = Int(readLine()!)!
var showCard = readLine()!.split(separator: " ").map { Int(String($0))! }
var result = ""

for i in 0..<showCard.count {
    result += binarySearch(haveCard, showCard[i]) ? "1 " : "0 "
}

result.removeLast()
print(result)

func binarySearch(_ compareArray: [Int], _ targetNum: Int) -> Bool {
    var first = 0
    var end = compareArray.count - 1

    while first <= end {
        let middle = (first + end) / 2
        if targetNum > compareArray[middle] {
            first = middle + 1
        } else if targetNum < compareArray[middle] {
            end = middle - 1
        } else if targetNum == compareArray[middle] {
            return true
        }
    }

    return false
}

//BaekJoon Algorithm Study n. 1946 (新入社員)　重要度: 🎖🎖🎖🎖🎖🎖🎖🎖
// Greedy + Sort アルゴリズム
// 🔥Hard!‼️
//時間超過になったコード
func solution() {
    typealias Rank = (document: Int, interview: Int)
    let testCase = Int(readLine()!)!
    for _ in 0..<testCase {
        let students = Int(readLine()!)!
        var pass = 0
        var tempCompare = 0
        var studentData = [Rank]()
        for _ in 0..<students {
            let putData = readLine()!.split(separator: " ").map { Int(String($0))! }
            studentData.append((putData[0], putData[1]))
        }
        studentData.sort {
            return $0.document < $1.document
        }

        for i in 0..<studentData.count {
            if i == 0 {
                pass += 1
                tempCompare = studentData[i].interview
            } else {
                if tempCompare > studentData[i].interview {
                    pass += 1
                    tempCompare = studentData[i].interview
                }
            }
        }

        print(pass)
    }
}

solution()

//時間超過にならないコード   (BaekJoon サイトはswiftの時間処理を配慮してほしい。。。Kotlinは処理時間の制限を少し伸ばしてくれたのに対し、swiftは。。😭)
final class FileIO {
    private var buffer:[UInt8]
    private var index: Int

    init(fileHandle: FileHandle = FileHandle.standardInput) {
        buffer = Array(fileHandle.readDataToEndOfFile())+[UInt8(0)] // indexが範囲を超えるのを防止
        index = 0
    }

    @inline(__always) private func read() -> UInt8 {
        defer { index += 1 }

        return buffer.withUnsafeBufferPointer { $0[index] }
    }

    @inline(__always) func readInt() -> Int {
        var sum = 0
        var now = read()
        var isPositive = true

        while now == 10
            || now == 32 { now = read() } // 空白と改行を無視
        if now == 45{ isPositive.toggle(); now = read() } // 負数の処理
        while now >= 48, now <= 57 {
            sum = sum * 10 + Int(now-48)
            now = read()
        }

        return sum * (isPositive ? 1:-1)
    }

    @inline(__always) func readString() -> String {
        var str = ""
        var now = read()

        while now == 10
            || now == 32 { now = read() } // 空白と改行を無視

        while now != 10
            && now != 32 && now != 0 {
                str += String(bytes: [now], encoding: .ascii)!
                now = read()
        }

        return str
    }
}

let file = FileIO()

let testCase = file.readInt()
for _ in 0..<testCase {
    let count = file.readInt()
    var scores: [(Int, Int)] = []
    for _ in 0..<count {
        scores.append((file.readInt(), file.readInt()))
    }

    scores.sort { $0.0 < $1.0 }
    var result = 1
    var min = scores[0].1
    for i in 1..<scores.count {
        if scores[i].1 < min {
            result += 1
            min = scores[i].1
        }
    }
    print(result)
}
