//
//  Day19.swift
//  BaekJoon
//
//  Created by Kyus'lee on 2022/02/25.
//

import Foundation

//Day 19: Class2 多様なアルゴリズムに慣れていこう(1)

//BaekJoon Algorithm Study n.10773 （ゼロゲーム）
let numCase = Int(readLine()!)!
var stackNum = [Int]()

for _ in 0..<numCase {
    let number = Int(readLine()!)!
    if number != 0 {
        stackNum.append(number)
    } else {
        stackNum.removeLast()
    }
}

print(stackNum.reduce(0) { $0 + $1 })

//上の文法をより効率よく書くためには、if number == 0を最初にして、その他のやつをstackに追加するようにすればいい
//問題の設定で、０が入力されたとき、消す数字があると保証されているため、popLast()じゃなくremoveLast()を使った
let numCase = Int(readLine()!)!
var stackNum = [Int]()

for _ in 0..<numCase {
    let number = Int(readLine()!)!
    if number == 0 {
        stackNum.removeLast()
    } else {
        stackNum.append(number)
    }
}

print(stackNum.reduce(0, +))

//BaekJoon Algoithm Study n.2164 (カードのルール２)
//Queueは、先に格納したデータが先に出るというFIFO構造である
//❗️この書き方だと時間オーバーになってしまう
let cardNum = Int(readLine()!)!
var cardQueue = [Int]()

for i in stride(from: 1, through:cardNum, by: 1) {
    cardQueue.append(i)
}

while true {
    cardQueue.removeFirst()
    guard cardQueue.count != 1 else {
        break
    }
    let moveCard = cardQueue.removeFirst()
    cardQueue.append(moveCard)
}
print(cardQueue[0])

//⬇️時間オーバーにならないコード
これも時間オーバーになってしまう
let numCase = Int(readLine()!)!
var cardQueue = [Int]()

for i in 1...numCase {
    cardQueue.insert(i, at:0)
}

while cardQueue.count != 1 {
    cardQueue.removeLast()
    cardQueue.insert(cardQueue.removeLast(), at: 0)
}
print(cardQueue[0])

//上記の２つのコードは、Queueのロジックを配列を用いて具現化しただけで、実際Queueを具現化していない
// Swiftでは、Queueがないため、配列２つを用いてQueueを具現する必要がある
// ‼️これも時間オーバーになる
struct Queue<Int> {
    private var queue: [Int] = []

    mutating func enqueue(_ value: Int) {
        queue.append(value)
    }

    mutating func dequeue() -> Int? {
        guard !queue.isEmpty else {
            return nil
        }
        return queue.removeFirst()
    }

    var head: Int? {
        return queue.first
    }

    var count: Int {
        return queue.count as! Int
    }
}

let cards = Int(readLine()!)!
var cardQueue = Queue<Int>()

for i in 1...cards {
    cardQueue.enqueue(i)
}

while cardQueue.count != 1 {
    cardQueue.dequeue()
    cardQueue.enqueue(cardQueue.dequeue()!)
}
print(cardQueue.head!)

//時間オーバーにならないコード
//他の人のコードを参考
let cards = Int(readLine()!)!
var cardQueue = Array(1...cards)

while cardQueue.count > 2 {
    var array: [Int] = []
    if cardQueue.count % 2 == 0 {
        for i in 0..<cardQueue.count {
            if i % 2 != 0 {
                array.append(cardQueue[i])
            }
        }
        cardQueue = array
    } else {
        array.append(cardQueue.last!)
        for i in 0..<cardQueue.count {
            if i % 2 != 0 {
                array.append(cardQueue[i])
            }
        }
        cardQueue = array
    }
}

if cardQueue.count == 2 {
    cardQueue.removeFirst()
}
print(cardQueue[0])

//時間オーバーにならないコード
let cards = Int(readLine()!)!
if cards == 1 {
    print("1")
} else {
    var cardArray = Array(1...cards)
    var headIdx = 0
    var count = cards

    //‼️このコードでは、削除の作業を行わず、headのindexを増やしながらindexを右に移動させながら、count も　-1ずつ減らして調査する配列の範囲を手動的に狭める
    while count > 1 {
        headIdx += 1
        count -= 1
        cardArray.append(cardArray[headIdx])
        headIdx += 1
    }
    print(cardArray.popLast()!)
}

//BaekJoon Algorithm Study n.10816 (数字カード2)　二分探索の問題 重要度: 🎖🎖🎖🎖🎖
// 再帰関数使った方がいいかな？？と思った問題
// ⚠️二分探索にしたら、ずっと時間エラーになってしまい、containsのメソッドを使う方法で解くことにした
// ⚠️Dictionaryを使うか、tuple typeの配列を使うかを少し迷って問題

// 方法１；Tupleを使ってみた方法
// この方法は、時間オーバーになった
let cards_Have = Int(readLine()!)!
var cards_Array = readLine()!.split(separator: " ").map { Int(String($0))! }
cards_Array.sort()

let cards_showNum = Int(readLine()!)!
let cards_showed = readLine()!.split(separator: " ").map { Int(String($0))! }
var tuple_cards: [(Int, Int)] = [(Int, Int)]()
var index = 0

for i in cards_showed {
    let card = (i, 0)
    tuple_cards.append(card)
}

while index < cards_showNum {
    var startCheck = tuple_cards[index]

    for i in cards_Array {
        if i == startCheck.0 {
            startCheck.1 += 1
        }
    }
    print("\(startCheck.1)", terminator: " ")

    index += 1
}

//for i in cards_showed {
//    let card = (i, 0)
//    tuple_cards.append(card)
//}
//
//for i in tuple_cards {
//    count_Havingcard(target: i.0)
//    index += 1
//}
//
//print(tuple_cards)
//
//func count_Havingcard(target: Int) {
//    var first = 0
//    var last = cards_Have - 1
//
//    while first <= last {
//        let middle = (first + last) / 2
//
//        if target == cards_Array[middle] {
//            tuple_cards[index].1 += 1
//            let first1 = 0
//            let last1 = middle - 1
//            let first2 = middle
//            let last2 = last
//        } else if target < cards_Array[middle] {
//            last = middle - 1
//        } else if target > cards_Array[middle] {
//            first = middle + 1
//        }
//    }
//}

//方法2. Dictionaryを使った解き方
// passはしたが、とんでもないメモリ量と処理時間がかかった
let cards_Have = Int(readLine()!)!
var cards_Array = readLine()!.split(separator: " ").map { Int(String($0))! }
cards_Array.sort()
let cards_ShowedCount = Int(readLine()!)!
let cards_Showed = readLine()!.split(separator: " ").map { Int(String($0))! }
var dict_card = [Int: Int]()
var result = [Int]()

for i in cards_Showed {
    dict_card[i] = 0
}

for i in cards_Array {
    if dict_card[i] != nil {
        dict_card[i]! += 1
    }
}

for i in cards_Showed {
    result.append(dict_card[i]!)
}

print(result.map { String($0)}.joined(separator: " "))

//BaekJoon Algorithm Study n.7568 (図体)　Brute Force 重要度: 🎖🎖🎖🎖🎖
// 🔥Brute force 完全探索のアルゴリズムに慣れていこう！

//この表現はなぜか、正しく反映されなかった
let testCase = Int(readLine()!)!
// (体重, 身長) の順
var peopleData = [((Int, Int), Int)]()
var rank_Array = [Int]()

for _ in 0..<testCase {
    let data = readLine()!.split(separator: " ").map { Int(String($0))! }
    peopleData.append(((data[0], data[1]), 0))
}

for i in 0..<peopleData.count {
    var person_1 = peopleData[i]
    var ranking = 1
    for j in 0..<peopleData.count {
        let person_2 = peopleData[j]
        if (person_1.0.0 < person_2.0.0) && (person_1.0.1 < person_2.0.1) {
            ranking += 1
        }
    }
    person_1.1 = ranking
    print(person_1.1)
}

//なぜ、ここで出力すると、全部初期値である、０になるんだろう。。
print(peopleData.map { String($0.1) }.joined(separator: " "))

// 他の方法
let testCase = Int(readLine()!)!
// (体重, 身長) の順
var peopleData = [(Int, Int)]()
var rank_Array = [Int]()

for _ in 0..<testCase {
    let data = readLine()!.split(separator: " ").map { Int(String($0))! }
    peopleData.append((data[0], data[1]))
}

for i in 0..<peopleData.count {
    let person_1 = peopleData[i]
    var ranking = 1
    for j in 0..<peopleData.count {
        let person_2 = peopleData[j]
        if (person_1.0 < person_2.0) && (person_1.1 < person_2.1) {
            ranking += 1
        }
    }
    rank_Array.append(ranking)
}
print(rank_Array.map { String($0) }.joined(separator: " "))


