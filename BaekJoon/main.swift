//
//  Day6_BaekJoon_Algorithm_Class2_day2.swift
//  BaekJoon
//
//  Created by Kyus'lee on 2022/02/11.
//

import Foundation

////BaekJoon Algorithm Study n.2869 (かたつむりは上に上がりたい)
////ceil関数：切り上げ
////floor関数：切り捨て
////round関数：四捨五入
//let data_1 = readLine()!.split(separator: " ").map { Double($0)! }
//let daytime = data_1[0]
//let night = data_1[1]
//let length = data_1[2]
//
//var day_count = Int(ceil((length - night) / (daytime - night)))
//
//print(day_count)
//
////BaekJoon Algorithm Study n.2839 (砂糖の配達) 動的計画法, 貪欲アルゴリズム 重要度:🎖🎖🎖
////‼️Tip: 問題で3kgと5kgの重さを指定したので、大きい数字である5kgを優先して入力した値を5で割り切れるかどうかを先に計算しておく　% 5 == 0を使う
//// while true == 無限loopであるため、breakが必ず必要!!
//var data_2 = Int(readLine()!)!
//var total = 0
//
//while true {
//    if data_2 % 5 == 0 {
//        total += data_2 / 5
//        print(total)
//        break
//    }
//
//    data_2 -= 3
//    total += 1
//
//    if data_2 < 0 {
//        total = -1
//        print(total)
//        break
//    }
//}
//
////BaekJoon Algorithm Study n.11650 (座標の整列) Fisrt Silver rate 問題 重要度:🎖🎖
////座標を簡単に表せるのが、Swiftのメリット！Tuple型の配列の使い方を学んでおこう
////sort()はその配列自体を再編成することに対し、sorted()関数は参照した配列は変えず、新しい配列を作る！
////sorted()とsort()両方とも、時間複雑度: O(nlogn)
//// sorted()は新しい配列を作るため、メモリの使用量がsort()より多い
//
////方法1. Tuple型の配列を用いた方法
//let data_3 = Int(readLine()!)!
//var storage = [(Int, Int)]()
//
//for _ in 0..<data_3 {
//    let test_data = readLine()!.split(separator: " ").map { Int($0)! }
//
//    storage.append((test_data[0], test_data[1]))
//}
//
//storage.sort(by: { $0.0 == $1.0 ? ($0.1 < $1.1) : ($0.0 < $1.0)})
//for i in 0..<data_3 {
//    print("\(storage[i].0) \(storage[i].1)")
//}
//
////方法２. 2次元配列を用いた方法
////
////
//
////BaekJoon Algorithm Study n.10989 (自然数の整列3)
////❗️これだと、時間超過しちゃう。。。もっといいコードを作成しましょう!!❗️重要度:🎖🎖🎖
//let data_5 = Int(readLine()!)!
//var arr_num = [Int]()
//
//for _ in 0..<data_5 {
//    arr_num.append(Int(readLine()!)!)
//}
//
//arr_num.sort()
//for i in 0..<arr_num.count {
//    print("\(arr_num[i])")
//}
//
////‼️この問題は、単純にソートするだけではなく、処理時間とメモリ使用量もちゃんと考慮しながらアルゴリズムを作成すべき問題である！ 時間制限：3秒, メモリ制限：8MB
////‼️‼️ Counting Sort 係数ソートアルゴリズムを用いたソート方法
////⚠️このようにしても処理時間がオーバーになる。。今度また、見てみよう
//func Counting_sort (_ arr1: [Int] ) -> [Int] {
//    let max_num = arr1.max()!
//    var arr2 = Array(repeating:0, count:Int(max_num + 1))
//
//    for element in arr1 {
//        arr2[element] += 1
//    }
//
//    for index in 1..<arr2.count {
//        arr2[index] += arr2[index - 1]
//    }
//
//    var sortedArray = Array(repeating:0, count:arr1.count)
//    for index in stride(from:arr1.count - 1, through: 0, by: -1)
//    {
//        let select = arr1[index]
//        arr2[select] -= 1
//        sortedArray[arr2[select]] = select
//    }
//
//    return sortedArray
//}
//
//let data_4 = Int(readLine()!)!
//var Array_data = [Int]()
//
//for _ in 0..<data_4 {
//    Array_data.append(Int(readLine()!)!)
//}
//
//let result = Counting_sort(Array_data)
//for i in 0..<data_4 {
//    print("\(result[i])")
//}
//
////BaekJoon Algorithm Study n.10841 (年齢順にソート)
//let member_num = Int(readLine()!)!
//var database = [(Int, String)]()
//
//for _ in 0..<member_num {
//    let member_data = readLine()!.split(separator: " ").map { String($0)} //Array(Substring)を返す
//    database.append((Int(member_data[0])!, member_data[1]))
//}
//
//database.sort(by: {  $0.0 == $1.0 ? ($0.0 < $1.0) : ($0 < $1) })
//for i in 0..<member_num {
//    print("\(database[i].0) \(database[i].1)")
//}

////BaekJoon Algorithm Study n.2751 (自然数のソート)
//let N = Int(readLine()!)!
//var N_sort = [Int]()
//
//for _ in 0..<N {
//    N_sort.append(Int(readLine()!)!)
//}
//N_sort.sort()
//
//var result1 = ""
//for i in N_sort {
//    result1 += "\(i)\n" //これは値の足し算ではなく、Int型であろう、String型であろうとも文字の結合を行う方法である
//}
//
//print(result1)

//BaekJoon Algorithm Study n.10866 (Deque) 重要度:🎖🎖🎖
//‼️append自体が配列の後ろから追加する方法である！
//first　と　last は Optionalタイプになっている
let command_num = Int(readLine()!)!
var deque = [Int]()

for _ in 0..<command_num {
    let command = readLine()!.split(separator: " ")
    let command_type = String(command[0])
    
    if command_type == "push_front" {
        deque.insert(Int(command[1])!, at: 0)
    } else if command_type == "push_back" {
        deque.append(Int(command[1])!)
    } else if command_type == "pop_front" {
        print(deque.isEmpty ? -1 : deque.removeFirst())
    } else if command_type == "pop_back" {
        print(deque.isEmpty ? -1 : deque.removeLast())
    } else if command_type == "size" {
        print(deque.count)
    } else if command_type == "empty" {
        print(deque.isEmpty ? 1 : 0)
    } else if command_type == "front" {
        print(deque.isEmpty ? -1 : deque[0])
    } else if command_type == "back" {
        print(deque.isEmpty ? -1 : deque.last!)
    }
}


