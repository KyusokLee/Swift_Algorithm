//
//  main.swift
//  BaekJoon
//
//  Created by Kyus'lee on 2022/02/06.
//

import Foundation

//BaekJoon Algorithm n.2753 (閏年)
let input = Int(readLine()!)!

if input % 4 == 0 && (input % 100 != 0 || input % 400 == 0) {
    print("1")
} else {
    print("0")
}


//BaekJoon Algorithm n.2562 (最大値)
let maxN = 9
var numArr: [Int] = [Int]()
for _ in 0..<maxN {
    let num = Int(readLine()!)!
    numArr.append(num)
}

for i in 0..<maxN {
    if numArr[i] == numArr.max()! {
        print("\(numArr[i])")
        print("\(i + 1)")
    }
}

//BaekJoon Algorithm n.2577 (数字の個数（掛け算の結果）)
var inputArr = [Int]()
var result = [Int](repeating:0, count: 10)

for _ in 0..<3 {
    inputArr.append(Int(readLine()!)!)
}

var mulResult = inputArr.reduce(1) { $0 * $1 }
var splitResult = String(mulResult).map { Int(String($0))! }

for i in 0...9 {
    for j in splitResult {
        if i == j {
            result[i] += 1
        }
    }
    print(result[i])
}

//BaekJoon Algorithm n.2675 (文字列の反復)
let T = Int(readLine()!)!
for _ in 0..<T {
    let R_S = readLine()!.split(separator: " ")
    let R = Int(R_S[0])!
    let S = R_S[1]

    for char_S in S {
        for _ in 0..<R {
            print("\(char_S)", terminator:"")
        }
    }
    print("")
}

//BaekJoon Algorithm n.2884 (目覚まし時計)(45分前に起きたい！)
let targetT = readLine()!
let arr_T = targetT.split(separator: " ").map { Int($0)! }
var hour = arr_T[0]
var min = arr_T[1]
min -= 45

if min < 0 {
    hour -= 1
    min += 60
}

if hour < 0 {
    hour += 24
}
print("\(hour) \(min)" )

//BaekJoon Algorithm n.11654 (文字のASCIIコード変換及び出力)
//asciiValueはCharacter型に使用できる
//文字のアスキーコード値をUInt8？に返すので、オプショナル(?)を剥がして変換する必要がある。
let put = Character(readLine()!).asciiValue!
print(put)

//Intの場合はInt(readLine()!)!だったのに、Characterは後ろに！がない理由は、readLine自体がStringとして入力値を扱うため、Stringの一環であるCharacterは！はいらないと考えられる

//BaekJoon Algorithm n.10809 (アルファベット探し) 重要度：🎖
let word = Array(readLine()!)
for i in Character("a").asciiValue!...Character("z").asciiValue! {
    let char_word = Character(UnicodeScalar(i))
    if word.contains(char_word) {
        print("\(word.firstIndex(of:char_word)!)", terminator:" ")
    } else {
        print("-1", terminator:" ")
    }
}

for i in 0...9 {
    print("\(i)", terminator:" ")
}
//terminator -> " ": 空白を挟みながら出力　"": 空白なしで出力
//terminator なし：普通に改行が行われながら、出力
