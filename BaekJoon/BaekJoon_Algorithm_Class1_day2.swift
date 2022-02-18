//
//  BaekJoon_Algorithm_Class1_day2.swift
//  BaekJoon
//
//  Created by Kyus'lee on 2022/02/07.
//

import Foundation

//Day 2 : BaekJoon Algorithm Study
//BaekJoon Algorithm Study num.1330 整数の比較
let line = readLine()!
let lineArr = line.split(separator: " ")
let a = Int(lineArr[0])!
let b = Int(lineArr[1])!

if a > b {
    print(">")
} else if a < b {
    print("<")
} else {
    print("==")
}

//BaekJoon Algorithm Study num.1546 科目の平均
let count = Double(readLine()!)!
let realScore = readLine()!.split(separator: " ").map { Double($0)!}
let maxScore = realScore.max()!
let fakeScore = realScore.map { $0 / maxScore * 100}
var sum = 0.0

for i in fakeScore {
    sum += i
}

print(sum / count)

//BaekJoon Algorithm Study num.2438　output Star
let N = Int(readLine()!)!
var idx = 1
for _ in 1...N {
    for i in 1...N {
        print("*", terminator: "")
        if idx == i {
            break;
        }
    }
    print("")
    idx += 1
}

//BaekJoon Algorithm Study num.2439　output Star(空白入れる方法)
// stride(from: 1, to: 10, by: 1) 意味：1から10未満まで1ずつ足しながら
// stride(from: 10, to: 1, by: -1) >> 10から1超過まで−１ずつ引きながら
let input = Int(readLine()!)!
//for a in b 文でaはlet　インスタンスである（c言語のように for 文の中でa++ など勝手にできない）
for i in 1...input {
    for _ in stride(from: input, to: i, by: -1) {
        print(" ", terminator: "")
    }
    for _ in stride(from: 0, to: i, by: 1) {
        print("*", terminator: "")
    }
    print("") //print()も可能
}

//BaekJoon Algorithm Study num.2475 (検証の固有番号取得)
let input1 = readLine()!.split(separator: " ").map { Int($0)! }
let changeNum = input1.map { $0 * $0 }
var sum1 = 0

for i in changeNum {
    sum1 += i
}

print(sum1 % 10)

//num.2475 簡略化
let input2 = readLine()!.split(separator: " ").map { Int($0)! }
var sum2: Int = input2.reduce(0){$0 + ($1 * $1)}
print(sum2 % 10)

//BaekJoon Algorithm Study num.2742 入力した自然数の出力（逆順）
let input3 = Int(readLine()!)!
for i in 0..<input3 {
    print(input3 - i)
}

//BaekJoon Algorithm Study num.2908 数字を逆に読むAさん（二つの数の比較）
//reverse() reversed()の比較：両方とも新しい配列を出力するのではなく、その場で入力された文字列を逆順に返す！
//reversed() = O(1)    reverse() = O(n)の違い
let input4 = readLine()!.split(separator: " ")
var arr: [String] = [String]()
//typeof input4[i] はsplitでくくったためsubstring タイプである。これをStringに変換する必要がある
for i in 0...(input4.count - 1) {
    arr.append(String(input4[i].reversed()))
}

let S = arr.map { Int($0)! }.max()!
print(S)

//BaekJoon Algorithm Study num.2920 数字のソート
let input5 = readLine()!.split(separator: " ")

if input5 == input5.sorted() {
    print("ascending")
} else if input5 == input5.sorted(by: >) {
    print("descending")
} else {
    print("mixed")
}

