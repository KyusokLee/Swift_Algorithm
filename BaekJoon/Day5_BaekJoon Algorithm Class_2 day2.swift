//
//  Day4-BaekJoon_Algorithm_Class1_last and Class2_day1.swift
//  BaekJoon
//
//  Created by Kyus'lee on 2022/02/09.
//

import Foundation


//BaekJoon Algorithm Study n.2798 (New Black Jack Rule) éè¦åº¦ï¼ðð
//å ´åã®æ°ããã¹ã¦èãã Brute Force ã¢ã«ã´ãªãºã ã«ã¤ãã¦ç¥ã£ã¦ããããè¦æ±ããåé¡
//ï¼æã®ã«ã¼ããåãã®ã§ãforæãï¼ã¤è¨­ããã®ãå¹çç
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
                    //ããã®sumãç¨ãããã¨ã§ãåã®loopã§æ´æ°ãããsumããå¤§ããsumãçºè¦ã§ãããã¾ãsumãæ´æ°
                }
            }
        }
    }
}

print("\(sum)")

//BaekJoon Algorithm Study n.2775 ï¼ãã³ã·ã§ã³ã®å±ä½èæ°ï¼ éè¦åº¦ï¼ðð
//ï¼æ¬¡åéåã®å®ç¾ãããè½åå¿è¦ï¼åé¡æã®ä¸­ã§ãåé¡ã§æç¤ºãããã«ã¼ã«ã®ååæãå¿è¦ã !
//ï¼æ¬¡åã®éåã®è¦ç´ ãæ±ãæãæåã®è¨­å®ãå¿è¦ã§ãããä¾)repeating:0, count: (ä»»æ)ã§åæå¤ã®è¨­å®ãè¡ã£ãå¾ããã®è¦ç´ ã®Valueãå¤æ´ããã®ãå®¹æã§ããã
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

//2æ¬¡åéåã®ç·´ç¿
let test_arr = [[1, 3, 5], [2, 4, 6], [7, 8, 9]]
print(test_arr[0][0]) // test_arr[0] = [1, 3, 5] ã§ãããã¾ãããã®ä¸­ã®ï¼ãåãåºãããã«ã¯ãtest_arr[0][0]ãããã°ãã
var test_arr2 = [[Int]]()
for i in 0...2 {
    for j in 0...2 {
        print("\(test_arr[(i)][(j)])", terminator:" ")
    }
}
print("")
//1 3 5 2 4 6 7 8 9ãè¡¨ç¤ºããã

//BaekJoon Algorithm Study n.2231 ï¼æ°å­ã®åè§£ã¨åè§£åè¨ï¼ éè¦åº¦ï¼ðð
//Brute Forceãã¢ã«ã´ãªãºã 
//âæªãä¾ï¼Run Time Error! çºçï¼â¼ï¸
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

//â­ï¸æ­£ããä¾: ããå¹ççãªã³ã¼ãã®ä½æãå¿è¦
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

//è¦ã¤ãããªãã¦resultãåæå¤ã®ã¾ã¾ã®0ã§ãããªãã0ãåºå
if result2 == 0 {
    print("0")
} else {
    print("\(result2)")
}

//â­ï¸â­ï¸ãã£ã¨å¹ççãªè§£ç­ä¾: å¤å°é£ããææ³ãå¥ã£ã¦ãããããã¤ãã¯å¾æãã¹ãææ³ï¼
let N = Int(readLine()!)!
let digit = String(N).count

let sort_Num = Array(N - digit * 9..<N)

print(sort_Num.first(where: { $0 + String($0).compactMap{ $0.wholeNumberValue }.reduce(0) { $0 + $1 } == N }) ?? 0
)
