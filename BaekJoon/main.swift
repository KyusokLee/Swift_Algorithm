//
//  main.swift
//  BaekJoon
//
//  Created by Kyus'lee on 2022/02/06.
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

