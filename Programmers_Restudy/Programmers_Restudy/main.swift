//
//  main.swift
//  Programmers_Restudy
//
//  Created by Kyus'lee on 2022/02/13.
//

import Foundation

//ð¥ðProgrammers Algorithm Study ReStart--Day 1ã& Day 2
//Coding Test Practice_ High Score Kit __ å®å¨æ¢ç´¢ (ç´ æ°æ¢ã) éè¦åº¦ï¼ððððð é£æåº¦ï¼ð¥ð¥
//åå¸°é¢æ°ã®çè§£ãã¨ã¦ãé£ãã

//Programmers ã®åé¡ã¯ãé¢æ°ã®å½¢ã§è§£ãåé¡ãå¤ã!
// é¢æ°ã®ä½ææ¹æ³ããã£ããã¨å­¦ãã§ãããã¨ï¼
//â ï¸éä¸­ã®æ®µé
//guardæãä½¿ãããªããããã«ãªããï¼
// if letãææ³ï¼if letã¯Optionalå¤ãUnwrappingããéç¨ã§ãã
//  ã¤ã¾ããif let ã®æ¡ä»¶æã®å¤ãnilã§ãããå¦ãããã§ãã¯ããææ³ã§ãã
//  æ¡ä»¶æãnilãããªãã£ããããã®è©²å½ãã­ãã¯ãå®è¡ãããä»çµã¿ã«ãªã£ã¦ãã


//â¼ï¸é åã¨çµåãã®ã¢ã«ã´ãªãºã ãå¿ãä½¿ãããªããããã«ãããã¨ï¼â¼ï¸

//func solution1(_ numbers: String) -> Int {
//    let char = numbers.map { String($0) } //StringãStringéåã«å¤ãã
//    var primeNumArray = [Int]()
//    var checkList = Array<Int>(repeating: 0, count: char.count) //Check: 1 , Non-Check: 0
//    // checkListæå³ï¼é¸æããæ°å­ãä¸çªåã®æ°å­ã«ãã¦ä½ããç´ æ°ããã§ãã¯ï¼
//    //ä¾ãã°ã1ãé¸ã¶ã¨ããã¨ã1ããå§ã¾ãç´ æ°ã11ã17ã101ãªã©ã®ç´ æ°ããã¹ã¦ä½ããããä»¥ä¸ä½ãç´ æ°ããªããã°æ¬¡ã®æ°å­ã«ç§»ãã¨ããã·ã¹ãã 
//    //ã¾ãã0ã«åæåããé¸æããæ°å­ã§ç´ æ°ã®ä½æä½æ¥­ãå§ã¾ãã¨1ã«ãããã¾ãããã®ä½æ¥­ãçµãã£ããåã³0ã«å¤æ´ããæ¬¡ã®ãã®ã1ã«ãã¦ãä½æ¥­ã®ãã­ã»ã¹ãé²ããæ§é 
//    var selectNum = ""
//
//    //ç´ æ°ã®å¤æ­
//    func checkPrime(_ num: Int) -> Bool {
//        guard num > 1 else {return false}
//        // num > 1ãããªãæãelseæå®è¡. ã¾ããnum > 1ã®æãããã®guard ä»¥éã®ã³ã¼ããå®è¡
//        guard num != 2 else {return true}
//        // num ã 2ãããªãã¨ããguardæä»¥éã®ã³ã¼ãå®è¡ numãï¼ã®ã¨ãã¯ãelseæã«ããtrueå®è¡ãã¦ãcheckPrimeé¢æ°ãæãã
//        // ãªããªãã2ãç´ æ°ã§ãããã
//
//        var isPrime = true
//        for i in 2..<num {
//            if num % i == 0 {
//                isPrime = false //å²ãåããæ°å­ããããªããå¥åããnumã¯ç´ æ°ãããªãï¼
//                break    //breakã§isPrime = falseå¤ãè¿ã
//            }
//        }
//        return isPrime
//    }
//
//    //é åã¢ã«ã´ãªãºã (åå¸°DFSæ¢ç´¢)
//    // DFSé¢æ°ã§ç¨ãããã©ã¡ã¼ã¿ã¯ä»¥ä¸ã®ããã«ãªã
//    //  1ï¸â£depth: ä»ã¾ã§ä½ãããæ°å­ã®æ¡æ°ï¼0ããå§ãã¦1ãã¤è¶³ãã¦ãã£ã¦countã«ãªãã¨æ°å­ãå®æããï¼
//    //  2ï¸â£string: é¸ãã æ°å­
//    //  3ï¸â£count: ä½ããã¨ããæ°å­ã®æ¡æ°
//    func DFS(_ depth: Int, _ string: String, _ count: Int) {
//        print("ä»¥ä¸ã®foræããã®å¼ã³åºãå¥ããã¼ï¼ \(checkList)")
//        var DFS_count = 0
//        if depth == count { //ä½ãæ°å­ã®æ¡æ°ãmaxã«ãªã£ãå ´å
//            if let num_toInt = Int(string) {
//                if checkPrime(num_toInt) && !primeNumArray.contains(num_toInt) {
//                    primeNumArray.append(num_toInt)
//                    print("->!!Find: \(primeNumArray) ")
//                }
//            }
//        } else {
//            for i in 0..<char.count {
//                if checkList[i] == 0 {
//                    print("DFSä¸­ã®foræå¥ããã¼ï¼ãç¾å¨ã®checkList[\(i)] = \(checkList[i])")
//                    selectNum += char[i]
//                    print("-> ä»é¸ãã æ°å­: \(selectNum)")
//                    checkList[i] = 1
//                    print("DFSå¼ã³åºãåã® checkList[\(i)] = \(checkList[i])")
//                    print(primeNumArray)
//                    print("DFSã®å¼ã³åºã: \(DFS_count + 1)åç®")
//                    DFS(depth + 1, selectNum, count) //åå¸°é¢æ° DFS ã®å¼ã³åºã
//                    DFS_count += 1
//                    print("DFSå¼ã³åºãå¾ã® checkList[\(i)] = \(checkList[i])")
//                    print(primeNumArray)
//                    checkList[i] = 0 // åå¸°é¢æ°ã®å¼ã³åºããçµäºå¾ããã§ãã¯ãè§£é¤ãã
//                    selectNum = string // selectNumã stringã«åæåãã
//                    print("DFSä¸­ã®foræãçµããæç¹ã-> DFSå¼ã³åºãå¾ã® checkList[\(i)] = \(checkList[i])")
//                }
//            }
//        }
//    }
//
//    for i in 1...char.count {
//        print(" >> foræããã®DFSå¼ã³åºãã«å¥ã: \(i)åç®")
//        DFS(0, "", i)
//    }
//
//    return primeNumArray.count
//}
//
//print(solution1("174"))

//ð¥ð¥ðèªåã®åã§ããä¸åº¦ã³ã¼ããä½æãã¦ãçè§£ãããã¨ï¼
// ððèå¯: åå¸°é¢æ°DFS_permutaionã¯ãç°¡åãããã¨ãå¤éloopã¨ä¼¼ããããªæãã«ãªã£ã¦ãã
// â­ï¸â­ï¸éè¦ãã¤ã³ã ----------------------------
//  DFSã®foræã«å¥ãi = 0ããloopãããæ®µéã§DFSãå¼ã³åºãã
//             -> å¼ã³åºããDFSã§ã¾ããforæã«å¥ãi = 0ããloopããã!
//        ããããcheck_List ã§ãcheck_List[0]ã®é¨åãtrueã«ãªã£ã¦ãããããDFSä¸­ã®DFSã¯i = 1ããåã
//             ->ãã®ä½æ¥­ãçµãã£ãããDFSä¸­ã®DFSã forãæã® i = 2ã«ãªã£ã¦æ¢ç´¢ãå§ãããã®ä½æ¥­ãçµãã£ããä¸ä½ã®DFSã i = 1ã«ãªã
// â­ï¸â­ï¸ -------------------------------------

func solution2(_ numbers: String) -> Int {
    let char_numbers = numbers.map { String($0) }
    var result: [Int] = [Int]()
    var check_List = Array<Bool>(repeating: false, count: char_numbers.count)
    var currentNum = ""
    
    func DFS_permutation(_ depth: Int, _ select: String, _ digits: Int) {
        if depth == digits {
            if let isInt = Int(select) {
                if checkPrime(isInt) && !result.contains(isInt) {
                    result.append(isInt)
                }
            }
        } else {
            for i in 0..<char_numbers.count {
                if check_List[i] == false {
                    check_List[i] = true
                    currentNum += char_numbers[i]
                    DFS_permutation(depth + 1, currentNum, digits)
                    check_List[i] = false
                    currentNum = select
                }
            }
            
        }
    }
    
    func checkPrime(_ number: Int) -> Bool {
        guard number > 1 else { return false }
        guard number != 2 else { return true } //ããã§ä¸åº¦2ã ãããµããã«ãããä½æ¥­ãããã
        // ä»¥ä¸ã®for æã§ % 2 == 0 ä½æ¥­ãç®åãã«ãã­ã»ã¹ãé²ãããããããã§æ°å­2 ããµããã«ãããä½æ¥­ã¯ã³ã¼ããããå¹ççã«ãã¦ãããã
        
        var isPrime = true
        for i in 2...Int((sqrt(Double(number))))+1 {
            if number % i == 0 {
                isPrime = false
                break
            }
        }
        return isPrime
    }
    
    for i in 1...char_numbers.count {
        DFS_permutation(0, "", i)
        //åæè¨­å®ã¯ãæ·±ãã0ããã¹ã¿ã¼ããããã¨ã«ããï¼
    }
    
    return result.count
}
print(solution2("17"))
print(solution2("011"))


////ç·´ç¿
//let abcd = "abcd"
//let array1 = Array(abcd)
//print(type(of:array1)) // Array<Character>å



//// å¥åãããæ°å­ã®æå­åãããä¸æ¡ãæ°å­ã¨ãã¦ä¸å­ãã¤åãåºãããã®åãåºããæ°å­ã§ä½ãããæ°å­ãå¨é¨æ¢ãã³ã¼ã
//let prac_Num = "174"
//let array_Num = prac_Num.map { String($0) }
//var possible_num = [Int]()
//
//for i in 0..<array_Num.count  {
//    let select_num = array_Num[i]
//    if !possible_num.contains(Int(select_num)!) {
//        possible_num.append(Int(select_num)!)
//    } else {
//        for j in stride(from:i + 1, to: array_Num.count, by: 1) {
//            let select_num2 = array_Num[j]
//            let make_num = Int(select_num + select_num2)!
//            if !possible_num.contains(make_num) {
//                possible_num.append(make_num)
//            }
//        }
//    }
//}
//
//print(array_Num)
//print(possible_num)

//ä»ã®äººã®ã³ã¼ã

////ðâçè§£ NOT OKAY (Now Studying Step)
////ð¥ð¥[æ¦ç¥] : Setãç¨ãããã¨ã§ãéè¤ããªãããã¨ãã§ãã
//func combinations(_ array: [String]) -> Set<String> {
//    if array.count == 0 {
//        return []
//    }
//
//    //ð¥Closureã®æ´»ç¨ãèº«ã«ã¤ãããã¨ï¼
//    let answerArray = (0..<array.count).flatMap { i -> [String] in
//        var removedArray = array
//        let element = removedArray.remove(at: i)
//        return [element] + combinations(removedArray).map { element + $0 }
//    }
//
//    return Set(answerArray)
//}
//
////ðâ­ï¸çè§£ OKAY
//func isPrime2(_ number: Int) -> Bool {
//    guard number > 1 else {
//        return false
//    }
//    guard number != 2 else {
//        return true
//    }
//    for i in 2..<number {
//        if number % i == 0 {
//            return false
//        }
//    }
//    return true
//}
//
//func solution1_1(_ numbers: String) -> Int {
//    let array = Array(numbers).map { String($0) }
//    let set_Int = Set(combinations(array).compactMap { Int($0) }) //å¥åãããæ°å­ã§ä½ããå¨ã¦ã®æ°å­ãOptionalãå¥ããã¦åºå
//    return set_Int.filter { isPrime2($0) }.count
//}
//
//print(solution1_1("17"))

//
////Closure ç·´ç¿
////ð±âï¸flatMap  ã®çµæã¯ãmapã®çµæãjoinedããå¾Arrayã«å¤æããã®ã¨åãï¼
////    flatMap : é ã«å¨ã¦ã®è¦ç´ ã«å¯¾ããå¤æä½æ¥­ãçµåãã¦è¿ã
//
//let test_array1 = ["1", "3", "5"]
//print(type(of: test_array1)) //Array<String>
//let closure_Prac1 = (0..<test_array1.count).flatMap { i -> String in
//    var setting = test_array1
//    let element1 = setting.remove(at: i)
//    return element1
//}
//
//print(test_array1)
//print(closure_Prac1)
//print(type(of: closure_Prac1)) //Array<Character>
//
//
////    let answerArray = (0..<array.count).flatMap { i -> [String] in
////        var removedArray = array
////        let element = removedArray.remove(at: i)
////        return [element] + combinations(removedArray).map { element + $0 }
////    }
//
//var call_func_count = 1
//var call_closure_count = 1
//
//func combinations(_ array: [String]) -> Set<String> {
//    print("combinationsé¢æ° : \(call_func_count)åç®")
//    print(array)
//    call_func_count += 1
//    if array.count == 0 {
//        return []
//    }
//
//    //ð¥Closureã®æ´»ç¨ãèº«ã«ã¤ãããã¨ï¼
//    let answerArray = (0..<array.count).flatMap { i -> [String] in
//        print("answerArrayãã®å¼ã³åºã: \(call_closure_count)åç®")
//        call_closure_count += 1
//        var removedArray = array
//        let element = removedArray.remove(at: i)
//        print("ç¾å¨é¸æãã element = \(element)")
//        print("removedArray = \(removedArray)")
//        return [element] + combinations(removedArray).map { element + $0 }
//    }
//
//    return Set(answerArray)
//}
//
//print(combinations(["1", "7", "4"]))

////for æã®ä¸­ã®ãIfæã®å¦çãã­ã»ã¹ã«é¢ããèå¯
//
//let number_select = ["2", "0", "4"].map { Int($0)! }
//let check_list2 = [1, 1, 0]
//
//for i in 0..<number_select.count {
//    if check_list2[i] == 0 {
//        let select_idx = number_select[i]
//        print("ç¾å¨foræã¯ã\(i)åç®")
//        print("é¸æããè¦ç´ ï¼ \(select_idx)")
//        print(check_list2)
//    }
//}
////ãððèå¯ï¼for æã®ä¸­ã®ifæã¯ãå¿ã0ããåãã®ã§ã¯ãªããæ¡ä»¶ãæºããã¨ãã ãloopããããã¨ãããã
////          âï¸åå¸°é¢æ°ãä½¿ãæãå±ã«ä½¿ããããã¨ãå¤ãã®ã§ããã®ä»çµã¿ãã¡ããã¨çè§£ãã¦ãããã¨ï¼


