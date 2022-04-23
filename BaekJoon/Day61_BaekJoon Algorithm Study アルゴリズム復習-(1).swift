//
//  Filess.swift
//  BaekJoon
//
//  Created by Kyus'lee on 2022/04/23.
//

import Foundation

//Day 61: アルゴリズム復習 - (1)
//🎖Brute Force_ Back Tracking
//BaekJoon n.9663 (N-Queen)
let boardSize = Int(readLine()!)!
print(putQueen(boardSize))

func putQueen(_ queen: Int) -> Int {
    var safeCasesCount = 0
    var map = [Int](repeating: -1, count: queen) //列の数ほど配列を要素の数を設ける

    func isSafe (_ row: Int, _ column: Int) -> Bool {
        for i in 0..<column {
            if map[i] == row || row - map[i] == column - i || map[i] - row == column - i {
                return false // そこの場所にQueenを置くことができない (攻撃可能なので)
            }
        }
        return true
    }

    func dfs_selectPlace(_ depth: Int) {
        if depth == queen {
            // 最後の列(boardの端っこに到達することができ、Queenを安全に置くことができた)
            //　depthは列を指すようにした
            safeCasesCount += 1
            return
        }

        for i in 0..<queen {
            if isSafe(i, depth) {
                map[depth] = i // その列のQueenがある場所は i (行)である。
                dfs_selectPlace(depth + 1) // 次の列に
                map[depth] = -1 // ①現在のdepth(列)で次の列を探索した結果見つけなかった場合と、②最後の列まで行って result + 1させてから戻ってくる場合は -1に初期化する
            }
        }
    }

    dfs_selectPlace(0)
    return safeCasesCount
}

//BaekJoon n.10809 (アルファベット探し)
// 🎖文字列
let word = Array(readLine()!)
var result = ""
alphabetCount(word)
result.removeLast()
print(result)

func alphabetCount(_ array: [Character]) {
    for alphabet in Character("a").asciiValue!...Character("z").asciiValue! {
        if array.contains(Character(UnicodeScalar(alphabet))) {
            let char = array.firstIndex(of: Character(UnicodeScalar(alphabet)))!
            result += "\(char) "
        } else {
            result += "-1 "
        }
    }
}

//BaekJoon n.1181 (単語整列)
// 🎖文字列の整列 (ソート)
let words = Int(readLine()!)!
var wordArray = [String]()

for _ in 0..<words {
    wordArray.append(readLine()!)
}
wordArray = Array(Set(wordArray)) //重複防止
var tuples = [(String, Int)]()
wordArray.forEach {
    tuples.append(($0, $0.count))
}

tuples.sort { $0.0 < $1.0 }
tuples.sort { $0.1 < $1.1 }

tuples.forEach {
    print("\($0.0)")
}

// fatalErrorとguardについての練習
var prac = "abcDE"
var prac2 = "aaaa"
guard prac2 == prac2.lowercased() else {
    fatalError("Error! 2")
}
print(prac2)

guard prac != prac.lowercased() else {
    fatalError("Error!")
}
