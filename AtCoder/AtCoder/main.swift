//
//  main.swift
//  AtCoder
//
//  Created by Kyus'lee on 2022/04/29.
//

import Foundation

//// 🚴‍♂️************************🛫
////      コード遊び , 練習ノート
//// 🕰************************📚
//
////Bit探索練習
//let BitA = 2   // 00000010
//let BitB = 4   // 00000100
//let BitB2 = 5  // 00000110
//let BitB_B2 = BitB & BitB2  //   上記の2進数で 今日つである1が 2 ^ 2の部分にあるため、4が出力
//print(BitB_B2) // 出力: 4
//let BitA_B = BitA & BitB // 比較する2つの値の2進数が同値であるところを出力
//print(BitA_B)  // 出力: 0
//
//let BitC = 27
//let BitD = 27
//let BitC_D = BitC & BitD
//print(BitC_D)  //出力: 27
//
//

//let prac_Array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
//let prac_filter = prac_Array.filter { $0 % 2 == 0 } // filterの中のClosureの式に当てはまる要素だけ取り出して配列にする
//print(prac_filter)

////AtCoder Beginner Contest 251
////A.
//let input = readLine()!
//var result = ""
//if !conditionCheck(input) {
//    exit(0)
//}
//
//while result.count < 6 {
//    result += input
//}
//print(result)
//
//func conditionCheck(_ target: String) -> Bool {
//    guard 1 <= target.count && target.count <= 3 else {
//        return false
//    }
//
//    for i in target {
//        if Int(String(i)) != nil {
//            return false
//        }
//    }
//
//    let lowerStr = target.lowercased()
//
//    if target != lowerStr {
//        return false
//    }
//
//    return true
//}


////B. 処理時間が結構かかった
//let data = readLine()!.split(separator: " ").map { Int(String($0))! }
//let nums = data[0], W = data[1]
//let itemArray = readLine()!.split(separator: " ").map { Int(String($0))! }
//var checked = Array(repeating: false, count: nums)
//var sumArray: Set<Int> = []
//
//if nums == 1 {
//    print(itemArray.first! <= W ? 1 : 0)
//} else {
//    for i in 1...3 {
//        if nums < i {
//            break
//        }
//        combination(i, 0, 0, 0)
//    }
//    print(sumArray.count)
//}
//
//func combination(_ depth: Int, _ level: Int, _ sum: Int, _ startIndex: Int) {
//    if level == depth {
//        sumArray.insert(sum)
//        return
//    }
//
//    for i in startIndex..<itemArray.count {
//        if !checked[i] {
//            if sum + itemArray[i] > W {
//                continue
//            }
//            checked[i] = true
//            combination(depth, level + 1, sum + itemArray[i], startIndex + 1)
//            checked[i] = false
//        }
//    }
//}

////Brute Forceで探す方法 　-> より早い処理時間 (実行するテストケースが少ないから)
//let data = readLine()!.split(separator: " ").map { Int(String($0))! }
//let (N, W) = (data[0], data[1])
//let numArray = readLine()!.split(separator: " ").map { Int(String($0))! }
//
//print(findCountOfNiceNum())
//
//func findCountOfNiceNum() -> Int {
//    var result: Set<Int> = []
//    for i in 0..<N {
//        var sum = numArray[i]
//        if sum <= W {
//            result.insert(sum)
//        } else {
//            continue
//        }
//        for j in i + 1..<N {
//            sum = numArray[i] + numArray[j]
//            if sum <= W {
//                result.insert(sum)
//            } else {
//                continue
//            }
//            for k in j + 1..<N {
//                sum = numArray[i] + numArray[j] + numArray[k]
//                if sum <= W {
//                    result.insert(sum)
//                } else {
//                    continue
//                }
//            }
//        }
//    }
//    return result.count
//}


//C. 時間超過になったコード -> なんで、時間超過になるんだろう
let testCases = Int(readLine()!)!
var strArray = [String]()
var pointArray = [Int]()
var point = 0
var result = 0

for _ in 0..<testCases {
    let input = readLine()!.split(separator: " ").map { String($0) }
    strArray.append(input[0])
    pointArray.append(Int(input[1])!)
}

var setArray = [String]()

for i in 0..<testCases {
    if setArray.contains(strArray[i]) {
        continue
    }
    setArray.append(strArray[i])
    if point < pointArray[i] {
        point = pointArray[i]
        result = i + 1
    }
}

print(result)



//D.

