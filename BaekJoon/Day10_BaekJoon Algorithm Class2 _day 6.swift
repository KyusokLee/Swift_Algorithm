//
//  day10.swift
//  BaekJoon
//
//  Created by Kyus'lee on 2022/02/15.
//

import Foundation

//📝Day10. Stack数列問題の復習
//BaekJoon Algorithm Study n.1874 (スタック数列) 重要度：🎖🎖🎖
let put_n = Int(readLine()!)!
var stack_prac = [Int]()
var result_print = [String]()
var start_cnt = 1

for _ in 0..<put_n {
    let test_number = Int(readLine()!)!

    while start_cnt <= test_number {
        stack_prac.append(start_cnt)
        result_print.append("+")
        start_cnt += 1
    }

    if stack_prac.last == test_number {
        stack_prac.popLast()
        result_print.append("-")
    } else {
        print("NO")
        exit(0)
    }
}

print(result_print.joined(separator: "\n"))
//print(type(of:result_print.joined(separator: "\n"))) //一つの文字列として結合したのを一字ずつ改行を行い、出力する
//print(type(of:result_print)) //Array<String>型
//print(type(of:result_print.joined())) // 要素を一つの文字列としてのString型に返す！

//BaekJoon Algorithm Study n.1929 (素数探し) 重要度：🎖🎖🎖🎖
// 🌹エラトステネスの篩を用いた有名なアルゴリズム
// コーディングテストの定番問題でもある
// ⭕️方法1. シンプルなエラトステネスの篩の活用
let M_N = readLine()!.split(separator: " ").map { Int($0)! }
let M = M_N[0]
let N = M_N[1]

var arr_num: [Int] = Array(repeating: 0, count: N + 1)
for i in 2...N {
    arr_num[i] = i
}

for j in 2...N {
    for k in stride(from: j + j, through: N, by: j) {
        if arr_num[k] == 0 {
            continue
        } else {
            arr_num[k] = 0
        }
    }
}

for i in M...N {
    if arr_num[i] != 0 {
        print("\(arr_num[i])")
    }
}

//Good Try👋❗️: print(arr_num.filter( { $0 != 0 } ).reduce("") { String($0) + String($1) + "\n" } ) -> 2が含まれるなど、設定した範囲内の要素だけが表示されることはできなかった。

// ⭕️方法２. Bool Typeを用いたエラトステネスの篩　＞＞処理時間がより早くなる！
let M_N_1 = readLine()!.split(separator: " ").map { Int($0)! }
let M_1 = M_N_1.first!
let N_1 = M_N_1.last!
var primes = [Int]()
var clear = Array(repeating: false, count: N_1 + 1) //素数じゃない要素をtrueにさせる
//初期値はfalseに設定

for i in 2...N_1 {
    if !clear[i] {
        primes.append(i) // !clear[i] の意味：clear[i]の真偽値がfalseの時を意味
        //⚠️つまり、clear[i] がtrue になっていても、false になっていても、!clear[i]は常にfalseを指しているということ！

        for j in stride(from: i * 2, through: N_1, by: i) {
            clear[j] = true
        }
    }
}

for prime in primes {
    if prime < M_1 {
        continue
    }
    print(prime)
}

//BaekJoon Algorithm Study n.1654 (LAN線のカット) 重要度：🎖🎖🎖🎖🎖
//‼️二分探索を用いる体表的な問題である！
// 🔥Difficult: 難しい問題
//⚠️必ず、習得しておくこと‼️

//❌方法１。　Run Time Error
let put_LAN = readLine()!.split(separator: " ").map { Int($0)! }
let have_num = put_LAN.first!
let want_num = put_LAN.last!

var arr_LANS1 = [Int]()
var result = 0

for _ in 0..<have_num {
    arr_LANS1.append(Int(readLine()!)!)
}

var first1 = 0
var last1 = arr_LANS1.max()!

while first1 <= last1 {
    let middle1 = (first1 + last1) / 2
    var max_count = 0
    for lan in arr_LANS1 {
        max_count += lan / middle1
    }

    if max_count >= want_num {
        if result < middle1 {
            result = middle1
        }
        first1 = middle1 + 1
    } else {
        last1 = middle1 - 1
    }
}

print(result)

//⭕️方法2。　true　と　falseの真偽値を返す関数を定義！
//        🌈🌱考察：true　と　false の真偽値を用いると、処理時間がより早くなることに気づいた！（今んとこ、こう考えてる）
//          ⬆️修正可能性: あり　⭕️

var first = 1
//⚡️⚠️❗️ fisrt = 0にするとずっと、Run Time Error ! が出るのに、first = 1に設定すると、Run Time Error がでない。。なんでだろう。。。
var last = 0
let read = readLine()?.components(separatedBy: " ")
let have_LAN: Int = Int(read?[0] ?? "") ?? 0
let want_LAN: Int = Int(read?[1] ?? "") ?? 0
var arr_LANS = Array<Int>(repeating: 0, count: have_LAN)
var max_length: Int = 0

//middle の値で、求めようとする個数（超えてもいい）を作れるかを調査
func possible(mid: Int) -> Bool {
    var count = 0
    for i in 0..<have_LAN {
        count += (arr_LANS[i] / mid)
    }
    if count >= want_LAN {
        //求めようとするLAN線の個数を満たすなら、trueで返す
        return true
    }
    //満たしていない場合は、falseを返す
    return false
}

for i in 0..<have_LAN {
    let read_LAN = Int(readLine() ?? "") ?? 0
    arr_LANS[i] = read_LAN
    last = max(last, read_LAN)
}

//⭐️⭐️重要: 二分探索
// 必ず、このアルゴリズムを覚えておくこと！
while first <= last {
    let middle = (first + last) / 2
    if possible(mid: middle) {
        if max_length < middle {
            max_length = middle
        }
        first = middle + 1
        //🔥 生成されたLAN線数が求めるLAN線数より多いか、もしくは同じであれば繰り返し範囲のstart点をmiddle値　+ 1に新しく更新しる。
        // この問題では、LAN線の長さをできれば最大限にして取り出したいため、更新したmax_lengthより大きい長さのLAN線を作れるかが要点！
        // そのため、first を middle + 1にして、その可能性を全て調べるのがこの問題のポイントである
    } else {
        last = middle - 1 //更新したmiddle値で求めようとするLAN線の個数を超えなかった場合：右の値をmiddle - 1にして、繰り返す範囲を狭める
    }
}
print(max_length)

////👋 以下の文法じゃなくても、可能
//// max()を求める最も丁寧であり、優しい文法 (可読性は上がる　 But, コードの長さが長くなりそう)
//for _ in 0..<want_LAN {
//    let data_LAN = Int(readLine()!)!
//    arr_LANS.append(data_LAN)
//    last = max(last, data_LAN) //max(a, b) メッソド：aとbの中、大きい値を返す。 もし、a と　bが同値なら、bを返す
//}
