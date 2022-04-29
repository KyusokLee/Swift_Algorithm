//
//  Atcoder Begginer Contest 200.swift
//  AtCoder
//
//  Created by Kyus'lee on 2022/04/29.
//

import Foundation

//AtCoder Beginner Contest 200

//Atcoder n.200 -A
var input = Int(readLine()!)!
if input % 100 == 0 {
    input /= 100
} else {
    input = input / 100 + 1
}
print(input)

//Atcoder n.200 -B
let input = readLine()!.split(separator: " ").map { Int(String($0))! }
var N = input[0]
let K = input[1]
var result = ""

for _ in 0..<K {
    if N % 200 == 0 {
        N /= 200
    } else {
        var strN = String(N)
        strN += "200"
        N = Int(strN)!
    }
}
print(N)

//Atcoder n.200 -C
// 時間超過になったコード
let input = Int(readLine()!)!
var numArray = readLine()!.split(separator: " ").map { Int(String($0))! % 200}
var result = 0

for i in 0..<input {
    for j in i + 1..<input {
        if numArray[i] - numArray[j] == 0 {
            result += 1
        }
    }
}
print(result)

//時間超過にならないコード
//🌈考察: この問題は、組み合わせの基礎問題であった
//  順列と組み合わせの違い
//  🎖1. 順列: 並べる順序に意味があるということ --> つまり、 1 2 3の数字があるとき、 1 2 3 , 1 3 2, 2 3 1など、順序が違うことに意味を持つため、1 2 3 と 1 3 2を他のものとして扱う --> 順序が違ったら同じ数字が選択されても違うやつにみるということ！！
//  🎖2. 組み合わせ: 並べる順序に意味がないということ --> 1 2 3の数字があるとき、 1 2 3 と　 1 3 2などは共存できない
//                --> 順序が違うことに全く意味を持たないため、 1 2 3と 1 3 2は同じものとして扱う
func combination(_ num: Int) -> Int {
    if num == 0 || num == 1 {
        return 0
    } else {
        return num * (num - 1) / 2
    }
}

let nums = Int(readLine()!)!
let numArray = readLine()!.split(separator: " ").map{ Int(String($0))! }
var counter = [Int](repeating: 0, count: 200)
var answer = 0

for x in numArray {
    counter[x % 200] += 1
}

for x in 0..<counter.count {
    if counter[x] != 0 {
        answer += combination(counter[x])
    }
}
print(answer)

//Atcoder n.200 -D
//Happy BirthDay!2
// 🔥Hard!!
// BIt Masking + Bit全探索
let numbers = Int(readLine()!)!
let numArray = readLine()!.split(separator: " ").map { Int(String($0))! }

if let (checkedB, checkedC) = checkBC(numArray) {
    print("Yes")
    print("\(checkedB.count) \(checkedB.map { String($0 + 1) }.joined(separator: " "))")
    print("\(checkedC.count) \(checkedC.map { String($0 + 1) }.joined(separator: " "))")
} else {
    print("No")
}

//🔥このアルゴリアルが難しかった‼️
func checkBC(_ compareArray: [Int]) -> (arrayB: [Int], arrayC: [Int])? {
    let upperBoundCount = min(compareArray.count, 8)
    var tempArray = [Int: [Int]]()

    //1をupperBoundCountの値ほど左シフト演算した範囲まで探索 ex) 1 << 3　= 8, 1 << 6 = 64
    for i in 1..<(1 << upperBoundCount) {
        let indexes = (0..<upperBoundCount).filter { i & (1 << $0) != 0 } //２進数が被ってるところ(お互い1であるところのみ抽出) -> indexの値をfilter
        let sum = indexes.map { compareArray[$0] }.reduce(0, +) % 200
        if let alreadyFindedSame = tempArray[sum] {
            return (alreadyFindedSame, indexes)
        } else {
            tempArray[sum] = indexes
        }
    }

    return nil
}
