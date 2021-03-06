//
//  main.swift
//  AtCoder
//
//  Created by Kyus'lee on 2022/04/29.
//

import Foundation

//// ð´ââï¸************************ð«
////      ã³ã¼ãéã³ , ç·´ç¿ãã¼ã
//// ð°************************ð
//
////Bitæ¢ç´¢ç·´ç¿
//let BitA = 2   // 00000010
//let BitB = 4   // 00000100
//let BitB2 = 5  // 00000110
//let BitB_B2 = BitB & BitB2  //   ä¸è¨ã®2é²æ°ã§ ä»æ¥ã¤ã§ãã1ã 2 ^ 2ã®é¨åã«ããããã4ãåºå
//print(BitB_B2) // åºå: 4
//let BitA_B = BitA & BitB // æ¯è¼ãã2ã¤ã®å¤ã®2é²æ°ãåå¤ã§ããã¨ãããåºå
//print(BitA_B)  // åºå: 0
//
//let BitC = 27
//let BitD = 27
//let BitC_D = BitC & BitD
//print(BitC_D)  //åºå: 27
//
//

//let prac_Array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
//let prac_filter = prac_Array.filter { $0 % 2 == 0 } // filterã®ä¸­ã®Closureã®å¼ã«å½ã¦ã¯ã¾ãè¦ç´ ã ãåãåºãã¦éåã«ãã
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


////B. å¦çæéãçµæ§ããã£ã
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

////Brute Forceã§æ¢ãæ¹æ³ ã-> ããæ©ãå¦çæé (å®è¡ãããã¹ãã±ã¼ã¹ãå°ãªããã)
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


////C. æéè¶éã«ãªã£ãã³ã¼ã -> ãªãã§ãæéè¶éã«ãªããã ãã
//let testCases = Int(readLine()!)!
//var strArray = [String]()
//var pointArray = [Int]()
//var point = 0
//var result = 0
//
//for _ in 0..<testCases {
//    let input = readLine()!.split(separator: " ").map { String($0) }
//    strArray.append(input[0])
//    pointArray.append(Int(input[1])!)
//}
//
//var setArray = [String]()
//
//for i in 0..<testCases {
//    if setArray.contains(strArray[i]) {
//        continue
//    }
//    setArray.append(strArray[i])
//    if point < pointArray[i] {
//        point = pointArray[i]
//        result = i + 1
//    }
//}
//
//print(result)

//Dictionaryãç¨ããæ¹æ³ -> æéè¶éã«ãªããªã
// ðèå¯ : Dictionaryãä½¿ãã°ããåé¡ã ã£ãããDictionaryã¯ãéåããæéè¤éåº¦ãå¹ççã§ãã
// éåã¯ãæ±ããè³æãæ¢ç´¢ããéãææªã®å ´åå¨ã¦ã®indexã«ã¢ã¯ã»ã¹ãã¦æ¢ããããO(n)
// ä¸æ¹ãDictionaryã¯ãkey ã¨ãvalueãæã¤ãããO(1)ã§æ¸ã
// reverse() -> O(n)
// reversed() -> O(1)ãã¨ä¼¼ããããªæè¦ (reversed()ã¯ãéåã®é ãéã«ãããã®ãæ°ããä½æãããããæéè¤éåº¦ã¯O(1)


let testCases = Int(readLine()!)!
var poems = [String: Int]()
var point = 0
var result = 0

for i in 0..<testCases {
    let input = readLine()!.split(separator: " ").map { String($0) }
    let getPoint = Int(input[1])!
    
    if poems[input[0]] == nil {
        poems[input[0]] = getPoint
        if point < getPoint {
            point = getPoint
            result = i + 1
        }
    }
}

print(result)



//D.

