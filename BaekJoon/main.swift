//
//  Day5_BaekJoon Algorithm Class_2 day2.swift
//  BaekJoon
//
//  Created by Kyus'lee on 2022/02/10.
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

//Tuple 勉強

let tuple1 = ("KyusokLee",26)
var tuple2_name = tuple1.0
var tuple2_age = tuple1.1

//Swift で改行の入力しなくても、改行が行われる
print(tuple1)
print(tuple2_name)
print(tuple2_age)

//Splitとcomponents(separatedby:)の違い
let intro = "Hello, my name is Kyulee!"

var result11 = intro.split(separator:" ")
//separatorの""の中に、空白を入れることでintroを空白単位で分けられる
//splitはseparator 以外にもいろんな引数をもっている
// splitのreturn値はsubstring
print(result11)

//components　メッソドはsplitとほとんど変わらないが、引数をseparatedByしか持ってない
//また、return値はStringである。
var result22 = intro.components(separatedBy:" ")
print(result22)
// result1とresult2の結果は同じくなる。しかし、components(separatedBy:) の場合は、import Foundationする必要があるため、余計にメモリと時間を食ってしまう。
//できれば、splitsを使ってみよう

let sentence1 = "Last year was 2021 , this year is 2022 ."
let resul_sen1 = sentence1.components(separatedBy:" ")
print(resul_sen1)
print("\(Int(resul_sen1[3])!) + \(Int(resul_sen1[8])!) = ", Int(resul_sen1[3])! + Int(resul_sen1[8])!)
print(Int(resul_sen1[3])! + Int(resul_sen1[8])!)

let num1:Int = 1
let num2:Int = 3
print(num1 + num2)

//readLine()はStringを受け取る
//split使用
let put1 = readLine()!
let putArr1 = put1.split(separator: " ")
print(putArr1)

//なぜ、!を使って、Optional Wrappingをしなければならないのかがわからない。勉強すること！
let putArr2 = putArr1.map { Int($0)! * 2 }
//mapは既存のデータを変形するとき使う
print(putArr2)

//String 練習
let word2 = "Mississipi"
var dict2: [String:Int] = [:]

//for  A in B 文法で BがStringの場合、AはCharacter typeである。
for i in word2 {
    if (dict2[String(i)] == nil) {
        dict2[String(i)] = 1
    }
    else {
       dict2[String(i)]! += 1
    }
}

print(dict2)

//array practice + 文字列の結合練習
var practice1 = [Int]()
for _ in 0..<10 {
    practice1.append(Int(readLine()!)!)
}

let maxOfArr = practice1.max()!
//max()とmin()はOptional値を返す＞＞そのため、！をつけた
let idxOfMax = practice1.firstIndex(of:maxOfArr)! //!する理由はなんでだろう。。
let idxOfEnd = practice1.endIndex
//文字列の最後の文字であるendIndexは、配列の全長の値を返すので、注意する必要がある
// [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]があるときendIndexは10を返す 実際の最後の要素はarray[9]である。
print(practice1)
print(maxOfArr)
print(idxOfMax)
print(idxOfEnd)
practice1.insert(900, at: idxOfEnd)
print(practice1)

//Mapの考察・練習
var intArr = [Int]()
var resultArr = [Int]()

for _ in 0..<3 {
    intArr.append(Int(readLine()!)!)
}

var mul = intArr.reduce(1){ $0 * $1 } // ->Type: Int
//Int型はmapを持っていない
//Intの数字をInt型の一字一字ずつ分けるときは、Stringに変換した後、また、Intに変換する必要がある。
let splitmul = String(mul).map { $0 } //このままだと、"”がついているCharacter型を要素と持つ配列を返す
print(splitmul)
print(type(of:splitmul[0]))
let splitmul2 = String(mul).map { String($0) } //""がついているString型の要素を持つ変換
print(splitmul2)
print(type(of:splitmul2[0]))
let splitmul3 = String(mul).map { Int(String($0))! }//もう一回変換することで、Optionalになってるため、!がつける
print(splitmul3)
print(type(of:splitmul3[0]))
//character型から直接int型に変換はできない（？）けど、Stringに変えてからInt型に変えると可能である。

//let splitmul2 = String(mul).map {}
//mapは配列に変換してくれる
//配列をmapするとcharacterにタイプが変わる

//ASCIIコードへの変換とその逆変換の練習
let a = 65
let b = UnicodeScalar(a)! //Scalar型に変換する
print(type(of:b))
print(a)
print(b)

//UnicodeScalarの意味：Asciiコードの値を文字（数字、アルファベット、日本語など）に変換してくれる
let prac_word = Array(readLine()!) //入力したStringを一字ずつ分けて、配列にCharacterとして格納
print(prac_word)
print(type(of:prac_word))

//Typeの変換と結合、結合後の再変換の練習, reduceの勉強
let prac_array_N = Array(readLine()!).map { String($0) }
let prac_num_digits = prac_array_N.count
let prac_int_N = Int(prac_array_N.reduce("") { $0 + $1 })! //reduceの時点でType: String
//Int()!で囲むことで、Int型になる

print(prac_int_N)
print(type(of:prac_int_N))

//Compactmap と　wholeNumbleValue　, ??の勉強
let c = "2002"
let d = c.compactMap { $0 }
print(c)
print(type(of:c))
print(d)
print(type(of:d))

// ‼️compactMap(\.wholeNumberValue) は　compactMap{ $0.wholeNumberValue }のClosureを簡略化した文法
//      mapは nil　を除去しないまま配列として変えすが、compactMapは nilを除去した配列を返す！😳
// ‼️wholeNumberValueは、　文字が表す数字値を返すが、　その値が必ずwhole number, つまり 0と自然数を返してくれる
//      負の整数は変換できない！
//      また、数字だけじゃなく　④,　万, 十三 のような数字の意味を持つ文字も数字の値として変換してくれる！😳
//      wholeNumberValueはOptional値を返すため、実際使うときは Optionalを無くす方法を用いましょう！
//      wholeNumberValueのメリットは：Character -> Int 型に直接変換ができるということ。😳
let e = c.compactMap(\.wholeNumberValue)  // \.wholeNumbervalue >> Intに変換してくれる
print(e)
print(type(of:e))

let f = c.compactMap{ $0.wholeNumberValue }
print(f)
print(type(of:f))

let practice_1 = [0, 1, 2, 3, nil, 4]  //>> nilが入ったせいで、Array<Optional<Int>>型になっている
print(type(of:practice_1))
print(practice_1)

let practice1_1 = practice_1.compactMap { $0 } //Optional を剥がしてくれるし、nilも除去してくれる！
print(practice1_1)
print(type(of:practice1_1))

let practice_2 = [1, 2, 3, 4, 5]       //>> nilが入っていないので、Array<Int>型である
print(type(of:practice_2))

//let practice_3 = [0, 1, 2, 3, nil, "a"]  >> [Any]はTypeを明示しないとダメ！必ず、Typeの宣言をしましょう！

let practice_3: [Any?] = [0, 1, 2, 3, nil, "a", "2"] //nilがあることからTypeをAny?で宣言する！

// ⚠️⁉️??文法はいつ使うのかについての勉強が必要！！！！
//let practice_4 = readLine()!
//print(
//    (practice_4 == "a") ?? 1
//)
