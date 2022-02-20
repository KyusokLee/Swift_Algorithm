//
//  Day8_Week1の復習及びまとめ.swift
//  BaekJoon
//
//  Created by Kyus'lee on 2022/02/13.
//

import Foundation

//📚📝Day8. Week1: 一週間のアルゴリズムの整理と問題の復習 !
//BaekJoon Algorithm Study Num.1157 (最も多く入力された文字の数）
let word1 = readLine()!.uppercased()
var dict1: [Character:Int] = [Character:Int]()
var result_arr: [Character] = [Character]()

for i in word1 {
    if dict1[i] == nil {
        dict1[i] = 1
    } else {
        dict1[i]! += 1
    }
}

for i in dict1.keys {
    if dict1[i] == dict1.values.max()! {
        result_arr.append(i)
    }
}

print(result_arr.count == 1 ? result_arr[0] : "?")
//🌈⬆️考察:　入力したStringをfor in 文を使ってそのままCharacterとして配列に格納した方が処理時間がもっと早いことに気づいた

//🔽以下は、前回に書いたコード
let word = readLine()!.uppercased()
var dict: [String:Int] = [:]
var result2 = [String]()

for i in word {
    if (dict[String(i)] == nil) {
        dict[String(i)] = 1
    } else {
        dict[String(i)]! += 1
    }
}
print(dict)

for key in dict.keys {
    if dict[key] == dict.values.max() {
        result2.append(key)
    }
}

print(result2.count == 1 ? result2[0] : "?")


//BaekJoon Algorithm Study num.2439　output Star(空白入れる方法)
let star_num = Int(readLine()!)!

for i in 1...star_num {
    for _ in stride(from: star_num, to: i, by: -1) {
        print(" ", terminator: "")
    }
    for _ in stride(from: 0, to: i, by: 1) {
        print("*", terminator: "")
    }
    print("")
}
//🌈⬆️考察:　stride文法についてしっかりと理解しておく必要があると感じた
//       また、printを用いて出力する場合、どうしても後ろから表示するという昨日はないと今のところそう思う！printを用いた出力について誤解しないこと！
//  stride(from: 1, to: 5, by: 1)の場合: 5を含めないため、5 - 1 = 4回繰り返す
//  stride(from: 1, through: 5, by: 1)の場合: 5を含めるため、5 - 1 + 1回繰り返す

//BaekJoon Algorithm n.10809 (アルファベット探し) 重要度：🎖
let word2 = Array(readLine()!)

for i in Character("a").asciiValue!...Character("z").asciiValue! {
    let finding = Character(UnicodeScalar(i))

    if word2.contains(finding) {
        print("\(word2.firstIndex(of: finding)!)", terminator: " ")
    } else {
        print("-1", terminator: " ")
    }
}
print("")
//🌈⬆️考察:　String型のままで、string.firstIndex　メッソドを使うと、そのIndexの値が変な数字になっていることに注意！
// このような問題は必ず配列に格納してから、比較することにしよう！
//
//BaekJoon Algorithm Study num.10871 (Xより小さい数字)
//二つの方法がある
//方法１. filterの後、reduceを用いた文字列の結合 >> 処理時間joinedよりかかる
let N_X = readLine()!.split(separator: " ").map { Int($0)! }
let Num = readLine()!.split(separator: " ").map { Int($0)! }

let result_Num = Num.filter( { $0 < N_X[1]} ).reduce("") { String($0) + String($1) + " " }
print(result_Num)
//🌈⬆️考察 : 前よりfilterとreduceの文法について理解度が含まった気がする
//          reduce を用いて空白を入れながら結合することが可能である
//          reduceの英語の意味である　”減らす”という表現にふさわしく配列の要素を一つに結合して返してくれる

//方法2. filterの後、joinedを用いた方法
// ‼️joinedは文字列の配列を一つの文字として結合してくれる
let N_X1 = readLine()!.split(separator: " ").map { Int($0)! }
let Num1 = readLine()!.split(separator: " ")

let result_Num1 = Num1.filter( { Int($0)! < N_X1[1] } ).joined(separator: " ")
print(result_Num1)

//BaekJoon Algorithm Study num.15829 (Hashing関数) 重要度：🎖
let M = 31
let mod = 1234567891

func pow (_ num1 : Int, _ num2 : Int) -> Int {
    var result_pow = num1

    for i in 0...num2 {
        if i == 0 {
            result_pow = 1
            result_pow = result_pow % mod
        } else {
            result_pow *= num1
            result_pow = result_pow % mod
        }
    }
    return result_pow
}

let length_str = Int(readLine()!)!
let string_alpha = Array(readLine()!)
let compare_num = Int(Character("a").asciiValue!) - 1
var sum = 0

//わざわざ a から zまでの範囲をloopさせながら文字を探す必要ない
// ‼️今回の場合は、入力された文字だけを返せばいいので、scopeを入力された文字列の長さにするのが効率いいコードになる
for i in 0..<string_alpha.count {
    let int_i = Int(string_alpha[i].asciiValue!)
    sum += ((int_i - compare_num) * pow(M, i)) % mod
}

print(sum % mod)

//🌈⬆️考察: 前回解いたコードより簡素化されたのを気づいた
//         文字列に関する問題が出るとき、なにも考えずに文字全体の範囲でloopさせるのをやめておきましょう！問題文の分析をしっかりとしてから、コード作成すること⚠️

//BaekJoon Algorithm Study n.2798 (New Black Jack Rule) 重要度：🎖🎖
//Brute Force Algorithmの典型的な問題
//❗️効率よくloopさせるのが問題の要点である
//loopさせるとき、どの要素を基準に回すのかちゃんと考えてからコード作成に取り組もう！
let N_M = readLine()!.split(separator: " ").map { Int($0)! }
var card_array = readLine()!.split(separator: " ").map { Int($0)! }
let card_num = N_M[0]
let max_num = N_M[1]
var result = 0

for first in 0..<card_num - 2 {
    for second in first + 1..<card_num - 1 {
        for third in second + 1..<card_num {
            if card_array[first] + card_array[second] + card_array[third] > result {
                if card_array[first] + card_array[second] + card_array[third] <= max_num {
                    result = card_array[first] + card_array[second] + card_array[third]
                }
            }
        }
    }
}

print(result)

//🌈⬆️考察: 多重for文を用いてloopさせるとき、外のfor文のインデックスをよく考えること！

//BaekJoon Algorithm Study num.2609 （最大公約数と最小公倍数）
//🔥Swift言語の長所：C言語みたいに tempを用いて値を交換しなくていい
func gcd (_ num1 : Int, _ num2 : Int) -> Int {
    var a = num1
    var b = num2
    let remainder = a % b

    if a < b {
        a = b
        b = a
    }

    if remainder == 0 {
        return b
    } else {
        return gcd(b, remainder)
    }
}

let num_data = readLine()!.split(separator: " ").map { Int($0)! }
let num1 = num_data[0]
let num2 = num_data[1]

print(gcd(num1, num2))
print(num1 * num2 / gcd(num1, num2))

//BaekJoon Algorithm Study n.1181 (単語の並び替え) 重要度:🎖🎖🎖
//方法２。❗️Tupleを要素として持つ配列を用いた方がより処理時間が短い
//****!!varで宣言しても、タイプを変えることはできない!!****
//‼️⚠️sortingの優先順位を考える必要がある！
// 　　　　今回の場合、文字の長さが短い順に並び替えるのが、文字の長さが等しい場合の辞書登録順に文字を並び替えることより優先順位が高いため、一番最後に文字列の長さの短い順でsortした
// つまり、sortingの順序として
//   1. 辞書登録順に並び替える
//   2. 長さが短い順に再び、並び替える   --> こうすると、一番最後のSortingの条件が優先順位が高くなるため、この方法が正しいと判断した!

let test_num = Int(readLine()!)!
var str_array: [String] = [String]()

for _ in 0..<test_num {
    str_array.append(readLine()!)
}

str_array = Array(Set(str_array))
var tuple_data: [(String, Int)] = []

str_array.forEach {
    tuple_data.append(($0, $0.count))
}

tuple_data.sort(by: { $0.0 < $1.0 })
tuple_data.sort(by: { $0.1 < $1.1 })

for i in 0..<tuple_data.count {
    print("\(tuple_data[i].0)")
}
