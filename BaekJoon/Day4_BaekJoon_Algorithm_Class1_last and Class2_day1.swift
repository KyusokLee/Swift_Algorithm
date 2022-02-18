
  BaekJoon_Algorithm_Class1_day3.swift
  BaekJoon

  Created by Kyus'lee on 2022/02/08.


import Foundation

//Day 4 : BaekJoon Algorithm Study
//復讐📮BaekJoon Algorithm Study num.10809 (アルファベット探し)
let line = Array(readLine()!)
for i in Character("a").asciiValue!...Character("z").asciiValue! {
    let char = Character(UnicodeScalar(i))
    if line.contains(char) {
        print("\(line.firstIndex(of:char)!)", terminator: " ")
    } else {
        print("-1", terminator: " ")
    }
}
print("")

//ifの部分で!を用いて強制Unrappingをした理由は、その文字がlineに含まれていない可能性もあるためである。

//BaekJoon Algorithm Study num.3052 (余り)
//Setはappendがない！insert()で格納していくことに注意
var arr:[Int] = [Int]()
for _ in 0...9 {
    arr.append(Int(readLine()!)! % 42)
}
let result1: Set<Int> = Set(arr)
print(result1.count)

//SetとArray 活用
let arr3 = [1, 2, 3, 4, 4, 5, 5, 11, 11]
let set_arr3 = Set(arr3)
//Arrayを作り、Setで作った配列を括弧で囲むと、作った配列から重複要素を除いた値がSetに返還される。
print(set_arr3)

//BaekJoon Algorithm Study num.8958 (OXクイズ)
let line2 = Int(readLine()!)!
for _ in 0..<line2 {
    let answer = Array(readLine()!)
    var count = 0, sum = 0

    for j in 0..<answer.count {
        if answer[j] == "O" {
            count += 1
            sum += count
        } else if answer[j] == "X" {
            count = 0
        }
    }
    print(sum)
}

//BaekJoon Algorithm Study num.11720 (数字の合計)
//nilがある可能性があるため、変数のタイプを変えるとき、！を入力してUnwrappingを行う
//方法１　文字数の制限をしてないとき
let line3 = Int(readLine()!)!
var stringNum = readLine()!
var sum1 = 0

for i in stringNum {
    sum1 += Int(String(i))!
}
print(sum1)

//方法２文字数の制限も明確に行う時
let line4 = Int(readLine()!)!
var arr_line4 = [Int](repeating: 0, count: line4)
var stringNum4 = readLine()!

for j in stringNum4 {
    arr_line4.append(Int(String(j))!)
}
print("\(arr_line4.reduce(0) { $0 + $1 })")

//BaekJoon Algorithm Study num.2739 (九九)
let line5 = Int(readLine()!)!
for i in 1...9 {
    print("\(line5) * \(i) = \(line5 * i)")
}

//BaekJoon Algorithm Study num.10871 (Xより小さい数字)
//方法１. filter, joinedを使用しない方法
let line6 = readLine()!.split(separator: " ").map { Int($0)! }
let num6 = readLine()!.split(separator: " ").map { Int($0)! }
var num_Arr6 = [Int]()

for i in 0..<line6[0] {
    if num6[i] < line6[1] {
        num_Arr6.append(num6[i])
    }
}
for j in 0..<num_Arr6.count {
    print("\(num_Arr6[j])", terminator:" ")
}
print("")

//方法２. filter, joined活用バージョン
//joinedは文字列の配列を一つのの文字列として変換するメッソドである。
//joined(separator: " ")は空白を挟みながら文字列に変換する
//こっちの方が処理時間が短い
let line7 = readLine()!.split(separator: " ").map { Int($0)! }
let num7 = readLine()!.split(separator: " ")
let result2 = num7.filter { Int($0)! < line7[1] }.joined(separator: " ")
print(result2)

print("")

//BaekJoon Algorithm Study num.10171 (猫)
let cat: String = #"""
\    /\
 )  ( ')
(  /  )
 \(__)|
"""#
print(cat)

//BaekJoon Algorithm Study num.10250 (ACMホテル)
//私のミス：配列で抽象的にホテルを実現しようとしたのが、過ちだった　＞＞配列作るのにメモリ量と処理時間を浪費しちゃう
//エレベーターが一番左側にあって一番近い各階の1号室を好むお客さんの特性上、各階の1号室を先にお客さんに割り当て、その次に各階の2号室を割り当てる順序。つまり、for in ループを使用する時、外側for文には各階の部屋の個数、内側for文には階の個数をすることが望ましい。 内側のfor文を回って、 外側のfor文を回るから。
let testCase = Int(readLine()!)!
for _ in 0..<testCase {
    let data_Hotel = readLine()!.split(separator: " ").map { Int($0)! }
    let floor_count = data_Hotel[0]
    let room_count = data_Hotel[1]
    let guest_num = data_Hotel[2]
    var count = 0

    for r in 1...room_count {
        for f in 1...floor_count {
            let room_num = r + f * 100
            count += 1
            if count == guest_num {
                print("\(room_num)")
            }
        }
    }
}

//Array の要素の繰り返し活用
let a = 6
let b = 12
let test1 = Array<Int>(1...b)
print(test1)

//BaekJoon Algorithm Study num.15829 (Hashing関数) 重要度：🎖
//❌間違った例 : この方法は、文字を変換するのではなく、別の変数char_countを利用して計算したため、ダメだった
var hash_num1 = 31
var degree = 1
var sum = 0
var char_count = 0
let put_num1 = Int(readLine()!)!
var put_string1 = Array(readLine()!) //わざとArrayに入れてCharacterに変えなくても、for in 文を用いて　String型として受け取ったreadLine()を character型に変えることが可能である
var result_hash = [Int]()

for i in Character("a").asciiValue!...Character("z").asciiValue! {
    let alphabet = Character(UnicodeScalar(i))
    char_count += 1

    for s in 0..<put_string1.count {
        if put_string1[s] == alphabet {
            result_hash.append(char_count)
        }
    }
}

for k in 0..<result_hash.count {
    if k == 0 {
        sum = result_hash[k]
    } else {
        degree *= hash_num
        sum += result_hash[k] * degree
    }
}

print(sum)

//⭕️正しい例 : 問題で、指定したrとMを用いて変換すること！
//❗️直すべき点_1️⃣:問題文をよく読むこと！

//べき乗を求める関数 pow の作成
let mod = 1234567891
let hash_num = 31

func pow(_ num: Int, _ degree: Int) -> Int {
    var nowNum = num
    if degree == 0 {
        return 1
    } else if degree == 1 {
        print("\(nowNum)")
        return nowNum % mod
    } else {
        for _ in 2...degree {
            print("\(nowNum)")
            nowNum *= num //何で nowNum *= nowNumはダメなのか　疑問⁉️⚠️ >> nowNumにしちゃうと掛け算した値がnowNum自体になるので、31 * 31 * 31のような計算をしたいのに、31 * 31 = 961, 961 * 961みたいな値になってしまう
                //❗️直すべき点_2️⃣：繰り返される変数の初期設定に気を付けること！
            print("\(nowNum)")
            nowNum %= mod
        }
        return nowNum
    }
}

let put_num = Int(readLine()!)!
var put_string = String(readLine()!)
var result = 0
let char_a: Character = "a"
let int_a = Int(char_a.asciiValue!) //aはASCIIコードで97 (asciiValue)はUInt8？に変換する
var count = 0

for i in put_string {
    result += (Int(String(i.asciiValue!))! - (int_a - 1)) * pow(hash_num, count) % mod
    count += 1
}

print(result % mod)

//for (Character) in (String)練習 ＋　ASCIIコードの練習
//ASCII コード
let a_: Character = "a"
let A_: Character = "A"
print(a_)

let ascii_a_ = a_.asciiValue!
let ascii_A_ = A_.asciiValue!
print(type(of:ascii_a_))
print(ascii_a_)

let scalar_a_ = UnicodeScalar(ascii_a_)
let scalar_A_ = UnicodeScalar(ascii_A_)
print(type(of:scalar_a_))
print(scalar_a_)

let int_again_a_ = Character(scalar_a_)
let int_again_A_ = Character(scalar_A_)
print(type(of:int_again_a_))
print(int_again_a_)

let int_a_ = Int(ascii_a_)
let int_A_ = Int(ascii_A_)
print(type(of:int_a_))
print(int_a_)

//for (Character) in (String) 練習
let test_str = "LeeKyusok"

var count_str = 0
for t in test_str {
    print(t, terminator: "")
    count_str += 1
}
print("")
print("\(test_str.count)") //Stringのcountはただ、その文字列を構成している文字の数を表す
print("\(count_str)")
