//
//  Day4-BaekJoon_Algorithm_Class1_last and Class2_day1.swift
//  BaekJoon
//
//  Created by Kyus'lee on 2022/02/09.
//

import Foundation


//BaekJoon Algorithm Study n.2798 (New Black Jack Rule) 重要度：🎖🎖
//場合の数をすべて考える Brute Force アルゴリズムについて知っているかを要求する問題
//３枚のカードを取るので、for文を３つ設けるのが効率的
let line1 = readLine()!.split(separator: " ").map { Int($0)! }
let card_count = line1[0]
let card_sum = line1[1]
var sum = 0

let card = readLine()!.split(separator:" ").map { Int($0)! }

for firstIdx in 0..<card_count - 2 {
    for secondIdx in firstIdx + 1..<card_count - 1 {
        for thirdIdx in secondIdx + 1..<card_count {
            if  card[firstIdx] + card[secondIdx] + card[thirdIdx] <= card_sum {
                if card[firstIdx] + card[secondIdx] + card[thirdIdx] > sum {
                    sum = card[firstIdx] + card[secondIdx] + card[thirdIdx]
                    //ここのsumを用いることで、前のloopで更新されたsumより大きいsumが発見できたらまたsumを更新
                }
            }
        }
    }
}

print("\(sum)")

//BaekJoon Algorithm Study n.2775 （マンションの居住者数） 重要度：🎖🎖
//２次元配列の実現させる能力必要！問題文の中で、問題で提示されたルールの再分析も必要だ!
//２次元の配列の要素を扱う時、最初の設定が必要である。例)repeating:0, count: (任意)で初期値の設定を行った後、その要素のValueを変更するのが容易である。
let testCase = Int(readLine()!)!

for _ in 0..<testCase {
    let floor = Int(readLine()!)!
    let room = Int(readLine()!)!
    var mansion = Array(repeating: Array(repeating: 0, count: room), count: floor + 1)

    for i in 0...floor {
        for j in 0..<room {
            if i == 0 {
                mansion[i][j] = j + 1
            } else {
                if j == 0 {
                    mansion[i][j] = 1
                } else {
                    mansion[i][j] = mansion[i][j - 1] + mansion[i - 1][j]
                }
            }
        }
    }
    print("\(mansion[(floor)][(room - 1)])")
}

//2次元配列の練習
let test_arr = [[1, 3, 5], [2, 4, 6], [7, 8, 9]]
print(test_arr[0][0]) // test_arr[0] = [1, 3, 5] である。また、その中の１を取り出すためには、test_arr[0][0]をすればいい
var test_arr2 = [[Int]]()
for i in 0...2 {
    for j in 0...2 {
        print("\(test_arr[(i)][(j)])", terminator:" ")
    }
}
print("")
//1 3 5 2 4 6 7 8 9が表示される

//BaekJoon Algorithm Study n.2231 （数字の分解と分解合計） 重要度：🎖🎖
//Brute Force　アルゴリズム
//❌悪い例：Run Time Error! 発生！‼️
let array_N1 = Array(readLine()!).map { String($0) }
let num_digits1 = array_N1.count
let int_N1 = Int(array_N1.reduce("") { $0 + $1 })!
let M_bignum1 = int_N1 - (9 * num_digits1)
var result1 = 0

for i in M_bignum1...int_N1 {
    let i_digits1 = Array(String(i)).map { Int(String($0))! }.reduce(0) { $0 + $1 }
    if i + i_digits1 == int_N1 {
        result1 = i
        break;
    }
}

print(result1)

//⭕️正しい例: より効率的なコードの作成が必要
let N2 = Int(readLine()!)!
var sum2 = 0
var result2 = 0

for i in 1...N {
    sum2 = i
    for j in String(i) {
        sum2 += Int(String(j))!
    }
    if sum2 == N {
        result2 = i
        break
    }
}

//見つからなくてresultが初期値のままの0であるなら、0を出力
if result2 == 0 {
    print("0")
} else {
    print("\(result2)")
}

//⭕️⭕️もっと効率的な解答例: 多少難しい文法が入っているが、いつかは征服すべき文法！
let N = Int(readLine()!)!
let digit = String(N).count

let sort_Num = Array(N - digit * 9..<N)

print(sort_Num.first(where: { $0 + String($0).compactMap{ $0.wholeNumberValue }.reduce(0) { $0 + $1 } == N }) ?? 0
)
