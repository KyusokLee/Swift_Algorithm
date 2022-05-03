//
//  Day68.swift
//  BaekJoon
//
//  Created by Kyus'lee on 2022/05/03.
//

import Foundation
//Day 68 多様なアルゴリズム - (6)
//BaekJoon n.18870 (座標圧縮) 重要度: 🎖🎖🎖🎖🎖
//🎖 ソート
//時間超過になってしまったコード
let numbers = Int(readLine()!)!
let numberArray = readLine()!.split(separator: " ").map { Int(String($0))! }
var sortedArray = Set(numberArray).sorted()
var result = ""

for i in numberArray {
    result += String(sortedArray.firstIndex(of: i)!) + " "
}
result.removeLast()
print(result)

//時間超過にならないコード
let numbers = Int(readLine()!)!
let numberArray = readLine()!.split(separator: " ").map { Int(String($0))! }
var dictionary = [Int: Int]()
var value = 0

for i in numberArray.sorted() {
    if dictionary[i] == nil {
        dictionary[i] = value
        value += 1
    }
}
print("\(numberArray.map { String(dictionary[$0]!) }.joined(separator: " "))")

//BaekJoon n.1541 (失った括弧) 重要度: 🎖🎖🎖🎖🎖🎖🎖
//🎖 文字列 + Greedy + Parsing
// 通過できなかったコード
var data = readLine()!
if !data.contains("-") {
    print(data.split(separator: "+").map { Int(String($0))! }.reduce(0, +))
} else {
    let splitedData = data.split(separator: "-").map { String($0) }
    var result = 0
    var tempResult = 0

    for i in 0..<splitedData.count {
        if splitedData[i].contains("+") {
            tempResult += splitedData[i].split(separator: "+").map { Int($0)! }.reduce(0, +)
        } else {
            result = Int(splitedData[i])!
        }
    }
    print(result - tempResult)
}

//通過できたコード
// ‼️分析する必要があった問題
let minusSplit = readLine()!.split(separator: "-").map { String($0) }
let plus = minusSplit[0].split(separator: "+").map { Int(String($0))! }
var result = 0
var minusTotal = 0

for i in plus {
    result += i
}

for i in 1..<minusSplit.count {
    let minusOne = minusSplit[i].split(separator: "+").map { Int(String($0))! }
    minusTotal += minusOne.reduce(0, +)
}
print(result - minusTotal)

//BaekJoon n.9375 (ファッション王 へビン) 重要度: 🎖🎖🎖🎖🎖
// 🔥とてもいい問題
//🎖 組み合わせ + Hash
let cases = Int(readLine()!)!

for _ in 0..<cases {
    let clothes = Int(readLine()!)!
    guard clothes > 0 else {
        print(0)
        continue
    }

    var clothDictionary = [String: [String]]()

    for _ in 0..<clothes {
        let clothData = readLine()!.split(separator: " ").map { String($0) }
        if clothDictionary[clothData[1]] == nil {
            clothDictionary[clothData[1]] = [clothData[0]]
        } else {
            clothDictionary[clothData[1]]!.append(clothData[0])
        }
    }

    //  各itemの種類ごとの数に + 1をする理由は、そのitemを着用せずに他のitemを着用する可能性もあるから
    // 例) [eyewear: sunglasses], [shoes: [nike, adidas]]があるとする
    //    この場合、sunglassesだけをかけてもいいので、shoesを履かない場合を考慮しなければいけない そのため、そのitemを着用しない！ということを示すため $1 + 1をした
    //    ---> すると、eyewearの数: (1 + 1)   *   shoesの数: (2 + 1) = 6になり、最後に裸の状態 1を引けばいい
    // -1の理由は、何も着用していない状態、つまり裸の場合は問題の条件を満たさないから
    let result = clothDictionary.mapValues { $0.count }.values.reduce(1) { $0 * ($1 + 1) } - 1
    print(result)
}

//もっと効率的なコード
// 最初からitemの数だけを扱う配列を設けた方法
let cases = Int(readLine()!)!
for _ in 0..<cases {
    let itemsCount = Int(readLine()!)!
    var itemsDict = [String: Int]()

    for _ in 0..<itemsCount {
        let itemData = readLine()!.split(separator: " ").map { String($0) }
        if itemsDict[itemData[1]] == nil {
            itemsDict[itemData[1]] = 1
        } else {
            itemsDict[itemData[1]]! += 1
        }
    }

    let itemCombinationCounts = itemsDict.values.reduce(1) { $0 * ($1 + 1) } - 1
    print(itemCombinationCounts)
}

//BaekJoon n.17219 (パスワード探し) 重要度: 🎖🎖🎖🎖🎖
//🎖 Hash を用いた集合とmap
let input = readLine()!.split(separator: " ").map { Int(String($0))! }
let siteNumbers = input[0], wantPasswordsCounts = input[1]
var siteDictionary = [String: String]()
var result = ""

for _ in 0..<siteNumbers {
    let putData = readLine()!.split(separator: " ").map { String($0) }
    if siteDictionary[putData[0]] == nil {
        siteDictionary[putData[0]] = putData[1]
    }
}

for _ in 0..<wantPasswordsCounts {
    let wantFind = readLine()!
    result += "\(siteDictionary[wantFind]!)\n"
}
result.removeLast()
print(result)
