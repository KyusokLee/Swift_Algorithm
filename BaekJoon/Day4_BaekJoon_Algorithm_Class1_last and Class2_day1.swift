
  BaekJoon_Algorithm_Class1_day3.swift
  BaekJoon

  Created by Kyus'lee on 2022/02/08.


import Foundation

//Day 4 : BaekJoon Algorithm Study
//å¾©è®ð®BaekJoon Algorithm Study num.10809 (ã¢ã«ãã¡ãããæ¢ã)
let line = Array(readLine()!)
for i in Character("a").asciiValue!...Character("z").asciiValue! {
    let char = Character(UnicodeScalar(i))
    if line.contains(char) {
        print("\(line.firstIndex(of:char)!)", terminator: " ")
    } else {
        print("-1", terminator: " ")
    }
}
print("")

//ifã®é¨åã§!ãç¨ãã¦å¼·å¶Unrappingãããçç±ã¯ããã®æå­ãlineã«å«ã¾ãã¦ããªãå¯è½æ§ãããããã§ããã

//BaekJoon Algorithm Study num.3052 (ä½ã)
//Setã¯appendããªãï¼insert()ã§æ ¼ç´ãã¦ãããã¨ã«æ³¨æ
var arr:[Int] = [Int]()
for _ in 0...9 {
    arr.append(Int(readLine()!)! % 42)
}
let result1: Set<Int> = Set(arr)
print(result1.count)

//Setã¨Array æ´»ç¨
let arr3 = [1, 2, 3, 4, 4, 5, 5, 11, 11]
let set_arr3 = Set(arr3)
//Arrayãä½ããSetã§ä½ã£ãéåãæ¬å¼§ã§å²ãã¨ãä½ã£ãéåããéè¤è¦ç´ ãé¤ããå¤ãSetã«è¿éãããã
print(set_arr3)

//BaekJoon Algorithm Study num.8958 (OXã¯ã¤ãº)
let line2 = Int(readLine()!)!
for _ in 0..<line2 {
    let answer = Array(readLine()!)
    var count = 0, sum = 0

    for j in 0..<answer.count {
        if answer[j] == "O" {
            count += 1
            sum += count
        } else if answer[j] == "X" {
            count = 0
        }
    }
    print(sum)
}

//BaekJoon Algorithm Study num.11720 (æ°å­ã®åè¨)
//nilãããå¯è½æ§ããããããå¤æ°ã®ã¿ã¤ããå¤ããã¨ããï¼ãå¥åãã¦Unwrappingãè¡ã
//æ¹æ³ï¼ãæå­æ°ã®å¶éããã¦ãªãã¨ã
let line3 = Int(readLine()!)!
var stringNum = readLine()!
var sum1 = 0

for i in stringNum {
    sum1 += Int(String(i))!
}
print(sum1)

//æ¹æ³ï¼æå­æ°ã®å¶éãæç¢ºã«è¡ãæ
let line4 = Int(readLine()!)!
var arr_line4 = [Int](repeating: 0, count: line4)
var stringNum4 = readLine()!

for j in stringNum4 {
    arr_line4.append(Int(String(j))!)
}
print("\(arr_line4.reduce(0) { $0 + $1 })")

//BaekJoon Algorithm Study num.2739 (ä¹ä¹)
let line5 = Int(readLine()!)!
for i in 1...9 {
    print("\(line5) * \(i) = \(line5 * i)")
}

//BaekJoon Algorithm Study num.10871 (Xããå°ããæ°å­)
//æ¹æ³ï¼. filter, joinedãä½¿ç¨ããªãæ¹æ³
let line6 = readLine()!.split(separator: " ").map { Int($0)! }
let num6 = readLine()!.split(separator: " ").map { Int($0)! }
var num_Arr6 = [Int]()

for i in 0..<line6[0] {
    if num6[i] < line6[1] {
        num_Arr6.append(num6[i])
    }
}
for j in 0..<num_Arr6.count {
    print("\(num_Arr6[j])", terminator:" ")
}
print("")

//æ¹æ³ï¼. filter, joinedæ´»ç¨ãã¼ã¸ã§ã³
//joinedã¯æå­åã®éåãä¸ã¤ã®ã®æå­åã¨ãã¦å¤æããã¡ãã½ãã§ããã
//joined(separator: " ")ã¯ç©ºç½ãæã¿ãªããæå­åã«å¤æãã
//ãã£ã¡ã®æ¹ãå¦çæéãç­ã
let line7 = readLine()!.split(separator: " ").map { Int($0)! }
let num7 = readLine()!.split(separator: " ")
let result2 = num7.filter { Int($0)! < line7[1] }.joined(separator: " ")
print(result2)

print("")

//BaekJoon Algorithm Study num.10171 (ç«)
let cat: String = #"""
\    /\
 )  ( ')
(  /  )
 \(__)|
"""#
print(cat)

//BaekJoon Algorithm Study num.10250 (ACMããã«)
//ç§ã®ãã¹ï¼éåã§æ½è±¡çã«ããã«ãå®ç¾ãããã¨ããã®ããéã¡ã ã£ããï¼ï¼éåä½ãã®ã«ã¡ã¢ãªéã¨å¦çæéãæµªè²»ãã¡ãã
//ã¨ã¬ãã¼ã¿ã¼ãä¸çªå·¦å´ã«ãã£ã¦ä¸çªè¿ãåéã®1å·å®¤ãå¥½ããå®¢ããã®ç¹æ§ä¸ãåéã®1å·å®¤ãåã«ãå®¢ããã«å²ãå½ã¦ããã®æ¬¡ã«åéã®2å·å®¤ãå²ãå½ã¦ãé åºãã¤ã¾ããfor in ã«ã¼ããä½¿ç¨ããæãå¤å´foræã«ã¯åéã®é¨å±ã®åæ°ãåå´foræã«ã¯éã®åæ°ããããã¨ãæã¾ããã åå´ã®foræãåã£ã¦ã å¤å´ã®foræãåãããã
let testCase = Int(readLine()!)!
for _ in 0..<testCase {
    let data_Hotel = readLine()!.split(separator: " ").map { Int($0)! }
    let floor_count = data_Hotel[0]
    let room_count = data_Hotel[1]
    let guest_num = data_Hotel[2]
    var count = 0

    for r in 1...room_count {
        for f in 1...floor_count {
            let room_num = r + f * 100
            count += 1
            if count == guest_num {
                print("\(room_num)")
            }
        }
    }
}

//Array ã®è¦ç´ ã®ç¹°ãè¿ãæ´»ç¨
let a = 6
let b = 12
let test1 = Array<Int>(1...b)
print(test1)

//BaekJoon Algorithm Study num.15829 (Hashingé¢æ°) éè¦åº¦ï¼ð
//âééã£ãä¾ : ãã®æ¹æ³ã¯ãæå­ãå¤æããã®ã§ã¯ãªããå¥ã®å¤æ°char_countãå©ç¨ãã¦è¨ç®ããããããã¡ã ã£ã
var hash_num1 = 31
var degree = 1
var sum = 0
var char_count = 0
let put_num1 = Int(readLine()!)!
var put_string1 = Array(readLine()!) //ããã¨Arrayã«å¥ãã¦Characterã«å¤ããªãã¦ããfor in æãç¨ãã¦ãStringåã¨ãã¦åãåã£ãreadLine()ã characteråã«å¤ãããã¨ãå¯è½ã§ãã
var result_hash = [Int]()

for i in Character("a").asciiValue!...Character("z").asciiValue! {
    let alphabet = Character(UnicodeScalar(i))
    char_count += 1

    for s in 0..<put_string1.count {
        if put_string1[s] == alphabet {
            result_hash.append(char_count)
        }
    }
}

for k in 0..<result_hash.count {
    if k == 0 {
        sum = result_hash[k]
    } else {
        degree *= hash_num
        sum += result_hash[k] * degree
    }
}

print(sum)

//â­ï¸æ­£ããä¾ : åé¡ã§ãæå®ããrã¨Mãç¨ãã¦å¤æãããã¨ï¼
//âï¸ç´ãã¹ãç¹_1ï¸â£:åé¡æãããèª­ããã¨ï¼

//ã¹ãä¹ãæ±ããé¢æ° pow ã®ä½æ
let mod = 1234567891
let hash_num = 31

func pow(_ num: Int, _ degree: Int) -> Int {
    var nowNum = num
    if degree == 0 {
        return 1
    } else if degree == 1 {
        print("\(nowNum)")
        return nowNum % mod
    } else {
        for _ in 2...degree {
            print("\(nowNum)")
            nowNum *= num //ä½ã§ nowNum *= nowNumã¯ãã¡ãªã®ããçåâï¸â ï¸ >> nowNumã«ãã¡ããã¨æãç®ããå¤ãnowNumèªä½ã«ãªãã®ã§ã31 * 31 * 31ã®ãããªè¨ç®ããããã®ã«ã31 * 31 = 961, 961 * 961ã¿ãããªå¤ã«ãªã£ã¦ãã¾ã
                //âï¸ç´ãã¹ãç¹_2ï¸â£ï¼ç¹°ãè¿ãããå¤æ°ã®åæè¨­å®ã«æ°ãä»ãããã¨ï¼
            print("\(nowNum)")
            nowNum %= mod
        }
        return nowNum
    }
}

let put_num = Int(readLine()!)!
var put_string = String(readLine()!)
var result = 0
let char_a: Character = "a"
let int_a = Int(char_a.asciiValue!) //aã¯ASCIIã³ã¼ãã§97 (asciiValue)ã¯UInt8ï¼ã«å¤æãã
var count = 0

for i in put_string {
    result += (Int(String(i.asciiValue!))! - (int_a - 1)) * pow(hash_num, count) % mod
    count += 1
}

print(result % mod)

//for (Character) in (String)ç·´ç¿ ï¼ãASCIIã³ã¼ãã®ç·´ç¿
//ASCII ã³ã¼ã
let a_: Character = "a"
let A_: Character = "A"
print(a_)

let ascii_a_ = a_.asciiValue!
let ascii_A_ = A_.asciiValue!
print(type(of:ascii_a_))
print(ascii_a_)

let scalar_a_ = UnicodeScalar(ascii_a_)
let scalar_A_ = UnicodeScalar(ascii_A_)
print(type(of:scalar_a_))
print(scalar_a_)

let int_again_a_ = Character(scalar_a_)
let int_again_A_ = Character(scalar_A_)
print(type(of:int_again_a_))
print(int_again_a_)

let int_a_ = Int(ascii_a_)
let int_A_ = Int(ascii_A_)
print(type(of:int_a_))
print(int_a_)

//for (Character) in (String) ç·´ç¿
let test_str = "LeeKyusok"

var count_str = 0
for t in test_str {
    print(t, terminator: "")
    count_str += 1
}
print("")
print("\(test_str.count)") //Stringã®countã¯ãã ããã®æå­åãæ§æãã¦ããæå­ã®æ°ãè¡¨ã
print("\(count_str)")
