//
//  Day4-BaekJoon_Algorithm_Class1_last and Class2_day1.swift
//  BaekJoon
//
//  Created by Kyus'lee on 2022/02/09.
//

import Foundation

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

var result1 = intro.split(separator:" ")
//separatorの""の中に、空白を入れることでintroを空白単位で分けられる
//splitはseparator 以外にもいろんな引数をもっている
// splitのreturn値はsubstring
print(result1)

//components　メッソドはsplitとほとんど変わらないが、引数をseparatedByしか持ってない
//また、return値はStringである。
var result2 = intro.components(separatedBy:" ")
print(result2)
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
