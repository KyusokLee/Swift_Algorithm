//
//  Day73.swift
//  BaekJoon
//
//  Created by Kyus'lee on 2022/05/10.
//

import Foundation
//Day 72 多様なアルゴリズム - (10) + 文字列
//BaekJoon n.11053 (最長増加部分数列) 重要度: 🎖🎖🎖🎖🎖
// 🎖‼️ DP -> ある規則を探すのが大事
let dataSize = Int(readLine()!)!
let dp = readLine()!.split(separator: " ").map { Int(String($0))! }
var maxLength = 0

for i in 0..<dp.count {
    for j in i + 1..<dp.count {
        if i < j {
            maxLength += 1
        }
    }
}

//BaekJoon n.10610 (30) 重要度: 🎖🎖🎖🎖🎖
// 🎖文字列
// 通過できなかったコード
var data = Array(readLine()!).sorted(by: >) // Stringであってもsortedをするとintの値を比較してソートする
print(type(of: data))
let sum = data.reduce(0) { $0 + Int(String($1))! }
if data.last! != Character("0") || sum % 3 != 0 {
    //30の倍数であるためには、最後の数字が0でありながら、桁の各数字の和が3で割り切られなければならない
    print(-1)
} else {
    print(String(data))
    // Array<Character>　Typeは、String()にすると 文字列に変換される
}

//他の方法
let n = readLine()!.map { Int(String($0))! }.sorted(by: >)
var result = ""
if n[n.count - 1] == 0 && n.reduce(0, +) % 3 == 0 {
    for i in n {
        result += String(i)
    }
    print(result)
} else {
    print(-1)
}

//BaekJoon n.10610 (単語ひっくり返し) 重要度: 🎖🎖
// 🎖文字列
let testCase = Int(readLine()!)!
for _ in 0..<testCase {
    let sentence = readLine()!.split(separator: " ").map { String($0.reversed()) }
    print(sentence.joined(separator: " "))
}

//String reversed　練習
let s = "aBc"
let reverseStr = Array(s.reversed()).map { String($0) }.joined()
print(reverseStr)
let pracStr = "IamHappy"
let reversed_Str = pracStr.reversed()
print(type(of: reversed_Str)) //ReversedCollection<String>
// reversed() メッソドは配列を返さない -> 基となる配列のメモリを共有し、その配列を反転した順であるよ！と認識させるメッソドである
let reversed_Str1 = String(pracStr.reversed())
print(type(of: reversed_Str1))
print(reversed_Str1) // このようにTypeを指定すると求めようとする値を得られる

// Array<Character>練習
let prac = ["a", "c", "b"].map { Character($0) }
print(type(of: prac))
print(String(prac))
print(prac.reduce("") { String($0) + String($1) })
