//
//  Day7_BaekJoon Algorithm Class2_day4.swift
//  BaekJoon
//
//  Created by Kyus'lee on 2022/02/12.
//

import Foundation

//Day 7 : BaekJoon Algorithm Study
// Nested Functionの仕組みを理解する! 関数を入れ子構造にすることができる🎖
// ‼️‼️もっと勉強すること！
func outer (_ numA: Int, _ numB: Int) -> (Int, Int) -> Int {
    let remainder = numA % numB

    func GCD (_ numC: Int, _ numD: Int) -> Int {
        var test1 = numC
        var test2 = numD
        var tmp = 0

        if test1 < test2 {
            test1 = tmp
            tmp = test2
            test2 = tmp
        }

        while test2 != 0 {
            let rest_one = test1 % test2
            test1 = test2
            test2 = rest_one
        }

        return test1
    }

    func LCM (_ numE: Int, _ numF: Int) -> Int {
        return numE
    }

    return remainder != 0 ? GCD : LCM
}

let testcase1 = readLine()!.split(separator: " ").map { Int($0)! }
var result_case1 = outer(testcase1[0], testcase1[1])
print(result_case1(testcase1[0], testcase1[1]))

print(result_case1) //(Function)が出力される
print(outer(testcase1[0], testcase1[1])) //(Function)が出力される
print(result_case1(testcase1[0], testcase1[1]))

//BaekJoon Algorithm Study num.10845 (Queue) 重要度:🎖🎖🎖
let command_num = Int(readLine()!)!
var queue = [Int]()

for _ in 0..<command_num {
    let order_split = readLine()!.split(separator: " ")
    let command_1 = String(order_split[0])
    // let num = Int(order_split[1])! //この表現はなぜか、Errorになってしまう！

    if command_1 == "push" {
        queue.append(Int(order_split[1])!)
    } else if command_1 == "pop" {
        print(queue.isEmpty ? -1 : queue.removeFirst())
    } else if command_1 == "size" {
        print(queue.count)
    } else if command_1 == "empty" {
        print(queue.isEmpty ? 1 : 0)
    } else if command_1 == "front" {
        print(queue.isEmpty ? -1 : queue.first!)
    } else if command_1 == "back" {
        print(queue.isEmpty ? -1 : queue.last!)
    }
}

//BaekJoon Algorithm Study num.2609 （最大公約数と最小公倍数）
// ユークリッドの互除法　アルゴリズムを身につける！重要度:🎖🎖 >> 最大公約数を求める方法
//再帰関数の活用🎖
func Euclide (_ num1: Int, _ num2: Int) -> Int {
    var a = num1
    var b = num2
    var temp = 0

    if a < b {
        temp = a
        a = b
        b = temp
    }
    let r = a % b

    if r == 0 {
        return b
    }
    else {
        return Euclide(b, r)
    }
}

let input_num = readLine()!.split(separator: " ").map { Int($0)! }
let GCD = Euclide(input_num[0], input_num[1])
let LCM = input_num[0] * input_num[1] / GCD
print(GCD)
print(LCM)

//BaekJoon Algorithm Study n.1181 (単語の並び替え) 重要度:🎖🎖🎖
//　方法１。❗️Arrayの中に、Setを格納することが可能！
let test_count = Int(readLine()!)!
var alpha_set: Set<String> = Set<String>()

for _ in 0..<test_count {
    let put_str = readLine()!
    if alpha_set.contains(put_str) {
        continue
    } else {
        alpha_set.insert(put_str)
    }
}

var alpha_array = Array(alpha_set)
alpha_array.sort(by: { $0 < $1 })
let sorted_alpha = alpha_array.sorted(by: { $0.count < $1.count })
for i in 0..<sorted_alpha.count {
    print("\(sorted_alpha[i])")
}

//方法２。❗️Tupleを要素として持つ配列を用いた方がより処理時間が短い


// ❌間違った文法：alpha_array.sort(by: { $0.count == $1.count ? $0 < $1 : $0.count < $1.count })

//！！Setは、setは要素の順序に関わらず無作為にSet配列を出力。そのため、配列を順序がランダムに出力される。
//‼️他の人のコード参考
var list = Set<String>()

for _ in 0..<Int(readLine()!)! {
    list.insert(readLine()!)
}

list.sorted{ (a: String, b: String) -> Bool in
    if a.count == b.count {
        return a < b
    } else {
        return a.count < b.count
    }
}.forEach { print($0) }

//配列の中の文字のソート練習
var test_string_arr = ["what", "is", "your", "goal", "of", "this", "year"]
print(test_string_arr)
// ["what", "is", "your", "goal", "of", "this", "year"]

for i in 0..<test_string_arr.count {
    var select_a = Array(test_string_arr[i])
    select_a.sort(by: { Int($0.asciiValue!) < Int($1.asciiValue!) })
    let string_a = String(select_a)
    test_string_arr[i] = string_a
}
print(test_string_arr)
//["ahtw", "is", "oruy", "aglo", "fo", "hist", "aery"]

var test_string = readLine()!.split
var test_string1 = readLine()!.map { $0 } // StringをCharacterに変換し一字ずつ配列に格納して、その配列を出力
print(test_string) //(Function)出力
print(test_string1)
print(type(of:test_string1))

for i in 0..<test_string1.count {
    let change_ascii = test_string1[i].asciiValue! //UInt8型
    print(change_ascii)
    print(type(of:change_ascii))

    let ascii_to_int = Int(change_ascii)
    print(ascii_to_int)
    print(type(of:ascii_to_int)) //数値の変動はないが、UInt8型をInt型に変換してくれるだけ！

    let ascii_to_char = UnicodeScalar(change_ascii) //ASCII値をScalar型の文字に変換
    //⚠️注意: 元のCharacter型に変換するのではなく、あくまでもScalar型に変換してくれる
    print(ascii_to_char)
    print(type(of:ascii_to_char))
    //🌈考察:
    //1. 文字　-> asciiValue!変換 -> UnicodeScalar は OptionalなしのScalar型の文字（Character）
    //   Character -> UInt8 -> Scalar型の一文字
    //2. 文字　-> asciiValue!変換 -> Int型変換 -> UnicodeScalar　は Intに変換した後にUnicodeScalarに変換したため、Optional<Scalar>型の文字（Character）を変換
    //   Character -> UInt8 -> Int -> Optional<Scalar>型の一文字
    //   Intに変換した後、また文字に変えたいなら、Optional unwrappingが必要


    let Intascii_to_char = UnicodeScalar(ascii_to_int)!
    print(Intascii_to_char)
    print(type(of:Intascii_to_char))
}

//⚠️⚠️String配列のアルファベットソートの理解するための練習
//🔥大手コーディングテストの定番問題

var prac_str_sort = ["zookeeper", "apple", "airport", "brand", "agent", "apply", "brave", "yahoo", "line"]

print(prac_str_sort)
//["zookeeper", "apple", "airport", "brand", "agent", "apply", "brave", "yahoo", "line"]
prac_str_sort.sort()
print(prac_str_sort)
//["agent", "airport", "apple", "apply", "brand", "brave", "line", "yahoo", "zookeeper"]
prac_str_sort.sort(by: >)
print(prac_str_sort)
//["zookeeper", "yahoo", "line", "brave", "brand", "apply", "apple", "airport", "agent"]

//🌈考察：アルファベットの並び替え
//アルファベットを辞書順に再整列するときには、collection のsort 機能を活用すれば、ASCII 値にあえて変換させなくても自動的に再整列してくれる。
//
//長所:文字列の一番前の文字だけを判断するのではなく、文字列全てをアルファベット順に配列を再整列してくれる。
//
//例:apple、apple、apple、appleがあれば、
//apple, apple, apple, appleで整列してくれるという意味
//
//使い方:sort()=sort(by:<)はaからの順番で
//sort(by:>)はzからの順番に再整列する。
