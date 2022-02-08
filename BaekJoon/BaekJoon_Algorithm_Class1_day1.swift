//
//  BaekJoon_Algorithm.swift
//  BaekJoon
//
//  Created by Kyus'lee on 2022/02/06.
//

import Foundation

//BaekJoon Num.1000 （足し算と引き算）
let a = readLine()!
let aLine = a.split(separator: " ").map { Double($0)! }
print(aLine[0] / aLine[1])


//BaekJoon Num.1008 (割り算)
//components使用
let put = readLine()!
let putArr = put.components(separatedBy:" ")
print(Double(putArr[0])! / Double(putArr[1])!)

//BaekJoon Algorithm Study Num. 1152 (単語の個数)
let put3 = readLine()!
let putArr3 = put3.split(separator: " ").count
print(putArr3)

//BaekJoon Algorithm Study Num.1157 (最も多く入力された文字の数）
let word = readLine()!.uppercased()
var dict: [String:Int] = [:]
var result = [String]()

for i in word {
    if (dict[String(i)] == nil) {
        dict[String(i)] = 1
    } else {
        dict[String(i)]! += 1
    }
}

for key in dict.keys {
    if dict[key] == dict.values.max() {
        result.append(key)
    }
}

print(result.count == 1 ? result[0] : "?")
//配列resultに格納されている要素数が1であれば、その要素を出力、じゃなければ ? を出力
