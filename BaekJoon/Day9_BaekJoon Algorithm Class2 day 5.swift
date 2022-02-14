//
//  Day9.swift
//  BaekJoon
//
//  Created by Kyus'lee on 2022/02/14.
//

import Foundation

//BaekJoon Algorithm Study n.1978 (素数探し)重要度：🎖🎖🎖
//Bool　Typeを用いる方法も身に付けておくこと！

let data_num = Int(readLine()!)!
var num_array2 = readLine()!.split(separator: " ").map { Int($0)! }
var count = 0

for i in num_array2 {
    var judgement = true
    if i == 1 {
        continue
    }
    if i == 2 {
        count += 1
        continue
    }

    for j in 2..<i {
        if i % j == 0 {
            judgement = false
        }
    }

    if judgement == true {
        count += 1
    }
}

print(count)

//BaekJoon Algorithm Study n.10828 (スタック (Stack)) 重要度：🎖🎖🎖
//方法１。関数使わずにやる方法
let num_N = Int(readLine()!)!
var stack_arr = [Int]()

for _ in 0..<num_N {
    let test_1 = readLine()!.split(separator: " ")
    //要素が入ってこないときも適用可能
    let command_1 = String(test_1[0])

    if command_1 == "push" {
        stack_arr.append(Int(test_1[1])!)
    } else if command_1 == "pop" {
        print(stack_arr.isEmpty ? "-1" : stack_arr.removeLast())
    } else if command_1 == "size" {
        print(stack_arr.count)
    } else if command_1 == "empty" {
        print(stack_arr.isEmpty ? "1" : "0")
    } else if command_1 == "top" {
        print(stack_arr.isEmpty ? "-1" : stack_arr.last!)
    }
}

//方法２。関数の定義及びswitch文を用いた方法
//強制Unwrapping の代わりに?? 0の文法を使った方がより安全なコードになれる

var stack_1: [Int] = [Int]()

func push (_ num1: Int) {
    stack_1.append(num1)
}

func pop() -> Int {
    if size() == 0 {
        return -1
    }
    let lastVal = stack_1.last ?? 0
    stack_1.removeLast()
    return lastVal
}

func size() -> Int {
    return stack_1.count
}

func empty() -> Int {
    return size() == 0 ? 1 : 0
}

func top() -> Int {
    return size() == 0 ? -1 : stack_1.last ?? 0
}

//⭕️方法2: if let 文法を使う方法
//‼️if let 文法：Optional値をUnwrappingする過程
//    ➡️if文内の条件文の値が nil であるかどうかをチェックしてくれる文法
//    ➡️条件文がnilでないなら、該当するブロックが実行される構造になっている

if let test_NUM = readLine() {

    for _ in 0..<(Int(test_NUM) ?? 0) {
        if let testData = readLine() {
            let value = testData.split(separator: " ")
            switch value[0] {
            case "push": push(Int(value[1]) ?? 0)
            case "pop": print(pop())
            case "size": print(size())
            case "top": print(top())
            default: print(empty())
            }
        }
    }
}

let readNum = Int(readLine()!)!

⭕️方法2: for 文の繰り返しの方法：if let を使わない方法
for _ in 0..<readNum {
    let stack_data = readLine()!.split(separator: " ")

    switch String(stack_data[0]) {
    case "push": push(Int(stack_data[1])!)
    case "pop": print(pop())
    case "size": print(size())
    case "empty": print(empty())
    case "top": print(top())
    default: break
    }
}

//BaekJoon Algorithm Study n.1874 (スタック数列) 重要度：🎖🎖🎖🎖
//この問題は必ずMasterする必要がある！アルゴリズムに関する定番問題！
//❗️🔥IMPORTANT🔥 効率的にStack配列への追加、除去するために、count_idxという変数を用いて、次にStackへ入れるValueを指定して、そのValue値が入るかどうかの判断をif 文などの制御文で行う
//‼️‼️popLastとremoveLastの違い::
//     popLast() : Optionalとして返す (除去する値がない時を想定したメッソド）
//     removeLast(): Optionalとして返さない (つまり、除去するものがない場合に使用すると、Error!が出るから注意して使うこと！)

let test_num = Int(readLine()!)!
var count_idx = 1
var stack_2 = [Int]()
var answer = [String]()

for _ in 0..<test_num {
    let new_value = Int(readLine()!)!
    
    while count_idx <= new_value {
        stack_2.append(count_idx)
        answer.append("+")
        count_idx += 1
    }
    
    if stack_2.last == new_value {
        stack_2.popLast()
        answer.append("-")
    } else {
        print("NO")
        //break //NO出力してプログラムを終了する
        exit(0) //exit(0)の方が安全にプログラムを出力する！ 一番下のprint文がでない！
    }
}

//print(answer.joined())
//⚠️‼️print(type(of:answer.joined())) //文字列の配列を一つの文字列として結合する
print(answer.joined(separator: "\n"))
