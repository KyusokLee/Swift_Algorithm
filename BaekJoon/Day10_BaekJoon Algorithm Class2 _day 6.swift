//
//  day10.swift
//  BaekJoon
//
//  Created by Kyus'lee on 2022/02/15.
//

import Foundation

//ðDay10. Stackæ°ååé¡ã®å¾©ç¿
//BaekJoon Algorithm Study n.1874 (ã¹ã¿ãã¯æ°å) éè¦åº¦ï¼ððð
let put_n = Int(readLine()!)!
var stack_prac = [Int]()
var result_print = [String]()
var start_cnt = 1

for _ in 0..<put_n {
    let test_number = Int(readLine()!)!

    while start_cnt <= test_number {
        stack_prac.append(start_cnt)
        result_print.append("+")
        start_cnt += 1
    }

    if stack_prac.last == test_number {
        stack_prac.popLast()
        result_print.append("-")
    } else {
        print("NO")
        exit(0)
    }
}

print(result_print.joined(separator: "\n"))
//print(type(of:result_print.joined(separator: "\n"))) //ä¸ã¤ã®æå­åã¨ãã¦çµåããã®ãä¸å­ãã¤æ¹è¡ãè¡ããåºåãã
//print(type(of:result_print)) //Array<String>å
//print(type(of:result_print.joined())) // è¦ç´ ãä¸ã¤ã®æå­åã¨ãã¦ã®Stringåã«è¿ãï¼

//BaekJoon Algorithm Study n.1929 (ç´ æ°æ¢ã) éè¦åº¦ï¼ðððð
// ð¹ã¨ã©ãã¹ããã¹ã®ç¯©ãç¨ããæåãªã¢ã«ã´ãªãºã 
// ã³ã¼ãã£ã³ã°ãã¹ãã®å®çªåé¡ã§ããã
// â­ï¸æ¹æ³1. ã·ã³ãã«ãªã¨ã©ãã¹ããã¹ã®ç¯©ã®æ´»ç¨
let M_N = readLine()!.split(separator: " ").map { Int($0)! }
let M = M_N[0]
let N = M_N[1]

var arr_num: [Int] = Array(repeating: 0, count: N + 1)
for i in 2...N {
    arr_num[i] = i
}

for j in 2...N {
    for k in stride(from: j + j, through: N, by: j) {
        if arr_num[k] == 0 {
            continue
        } else {
            arr_num[k] = 0
        }
    }
}

for i in M...N {
    if arr_num[i] != 0 {
        print("\(arr_num[i])")
    }
}

//Good Tryðâï¸: print(arr_num.filter( { $0 != 0 } ).reduce("") { String($0) + String($1) + "\n" } ) -> 2ãå«ã¾ãããªã©ãè¨­å®ããç¯å²åã®è¦ç´ ã ããè¡¨ç¤ºããããã¨ã¯ã§ããªãã£ãã

// â­ï¸æ¹æ³ï¼. Bool Typeãç¨ããã¨ã©ãã¹ããã¹ã®ç¯©ãï¼ï¼å¦çæéãããæ©ããªãï¼
let M_N_1 = readLine()!.split(separator: " ").map { Int($0)! }
let M_1 = M_N_1.first!
let N_1 = M_N_1.last!
var primes = [Int]()
var clear = Array(repeating: false, count: N_1 + 1) //ç´ æ°ãããªãè¦ç´ ãtrueã«ããã
//åæå¤ã¯falseã«è¨­å®

for i in 2...N_1 {
    if !clear[i] {
        primes.append(i) // !clear[i] ã®æå³ï¼clear[i]ã®çå½å¤ãfalseã®æãæå³
        //â ï¸ã¤ã¾ããclear[i] ãtrue ã«ãªã£ã¦ãã¦ããfalse ã«ãªã£ã¦ãã¦ãã!clear[i]ã¯å¸¸ã«falseãæãã¦ããã¨ãããã¨ï¼

        for j in stride(from: i * 2, through: N_1, by: i) {
            clear[j] = true
        }
    }
}

for prime in primes {
    if prime < M_1 {
        continue
    }
    print(prime)
}

//BaekJoon Algorithm Study n.1654 (LANç·ã®ã«ãã) éè¦åº¦ï¼ððððð
//â¼ï¸äºåæ¢ç´¢ãç¨ããä½è¡¨çãªåé¡ã§ããï¼
// ð¥Difficult: é£ããåé¡
//â ï¸å¿ããç¿å¾ãã¦ãããã¨â¼ï¸

//âæ¹æ³ï¼ããRun Time Error
let put_LAN = readLine()!.split(separator: " ").map { Int($0)! }
let have_num = put_LAN.first!
let want_num = put_LAN.last!

var arr_LANS1 = [Int]()
var result = 0

for _ in 0..<have_num {
    arr_LANS1.append(Int(readLine()!)!)
}

var first1 = 0
var last1 = arr_LANS1.max()!

while first1 <= last1 {
    let middle1 = (first1 + last1) / 2
    var max_count = 0
    for lan in arr_LANS1 {
        max_count += lan / middle1
    }

    if max_count >= want_num {
        if result < middle1 {
            result = middle1
        }
        first1 = middle1 + 1
    } else {
        last1 = middle1 - 1
    }
}

print(result)

//â­ï¸æ¹æ³2ããtrueãã¨ãfalseã®çå½å¤ãè¿ãé¢æ°ãå®ç¾©ï¼
//        ðð±èå¯ï¼trueãã¨ãfalse ã®çå½å¤ãç¨ããã¨ãå¦çæéãããæ©ããªããã¨ã«æ°ã¥ããï¼ï¼ä»ãã¨ããããèãã¦ãï¼
//          â¬ï¸ä¿®æ­£å¯è½æ§: ãããâ­ï¸

var first = 1
//â¡ï¸â ï¸âï¸ fisrt = 0ã«ããã¨ãã£ã¨ãRun Time Error ! ãåºãã®ã«ãfirst = 1ã«è¨­å®ããã¨ãRun Time Error ãã§ãªããããªãã§ã ããããã
var last = 0
let read = readLine()?.components(separatedBy: " ")
let have_LAN: Int = Int(read?[0] ?? "") ?? 0
let want_LAN: Int = Int(read?[1] ?? "") ?? 0
var arr_LANS = Array<Int>(repeating: 0, count: have_LAN)
var max_length: Int = 0

//middle ã®å¤ã§ãæ±ãããã¨ããåæ°ï¼è¶ãã¦ãããï¼ãä½ããããèª¿æ»
func possible(mid: Int) -> Bool {
    var count = 0
    for i in 0..<have_LAN {
        count += (arr_LANS[i] / mid)
    }
    if count >= want_LAN {
        //æ±ãããã¨ããLANç·ã®åæ°ãæºãããªããtrueã§è¿ã
        return true
    }
    //æºããã¦ããªãå ´åã¯ãfalseãè¿ã
    return false
}

for i in 0..<have_LAN {
    let read_LAN = Int(readLine() ?? "") ?? 0
    arr_LANS[i] = read_LAN
    last = max(last, read_LAN)
}

//â­ï¸â­ï¸éè¦: äºåæ¢ç´¢
// å¿ãããã®ã¢ã«ã´ãªãºã ãè¦ãã¦ãããã¨ï¼
while first <= last {
    let middle = (first + last) / 2
    if possible(mid: middle) {
        if max_length < middle {
            max_length = middle
        }
        first = middle + 1
        //ð¥ çæãããLANç·æ°ãæ±ããLANç·æ°ããå¤ããããããã¯åãã§ããã°ç¹°ãè¿ãç¯å²ã®startç¹ãmiddleå¤ã+ 1ã«æ°ããæ´æ°ããã
        // ãã®åé¡ã§ã¯ãLANç·ã®é·ããã§ããã°æå¤§éã«ãã¦åãåºããããããæ´æ°ããmax_lengthããå¤§ããé·ãã®LANç·ãä½ããããè¦ç¹ï¼
        // ãã®ãããfirst ã middle + 1ã«ãã¦ããã®å¯è½æ§ãå¨ã¦èª¿ã¹ãã®ããã®åé¡ã®ãã¤ã³ãã§ãã
    } else {
        last = middle - 1 //æ´æ°ããmiddleå¤ã§æ±ãããã¨ããLANç·ã®åæ°ãè¶ããªãã£ãå ´åï¼å³ã®å¤ãmiddle - 1ã«ãã¦ãç¹°ãè¿ãç¯å²ãç­ãã
    }
}
print(max_length)

////ð ä»¥ä¸ã®ææ³ãããªãã¦ããå¯è½
//// max()ãæ±ããæãä¸å¯§ã§ãããåªããææ³ (å¯èª­æ§ã¯ä¸ããã But, ã³ã¼ãã®é·ããé·ããªããã)
//for _ in 0..<want_LAN {
//    let data_LAN = Int(readLine()!)!
//    arr_LANS.append(data_LAN)
//    last = max(last, data_LAN) //max(a, b) ã¡ãã½ãï¼aã¨bã®ä¸­ãå¤§ããå¤ãè¿ãã ãããa ã¨ãbãåå¤ãªããbãè¿ã
//}
