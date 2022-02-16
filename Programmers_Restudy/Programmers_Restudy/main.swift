//
//  main.swift
//  Programmers_Restudy
//
//  Created by Kyus'lee on 2022/02/13.
//

import Foundation

//
//  main.swift
//  Programmers
//
//  Created by Kyus'lee on 2022/02/06.
//

import Foundation

//🔥🌈Programmers Algorithm Study ReStart--Day 1
//Coding Test Practice_ High Score Kit __ 完全探索 (素数探し) 重要度：🎖🎖🎖🎖🎖 難易度：🔥🔥
//再帰関数の理解がとても難しい

//Programmers の問題は、関数の形で解く問題が多い!
// 関数の作成方法をしっかりと学んでおくこと！
//⚠️途中の段階
//guard文を使いこなせるようになろう！
// if let　文法：if letはOptional値をUnwrappingする過程である
//  つまり、if let の条件文の値がnilであるか否かをチェックする文法である
//  条件文がnilじゃなかったら、その該当ブロックが実行される仕組みになっている


//‼️順列と組合せのアルゴリズムを必ず使いこなせるようにすること！‼️

func solution1(_ numbers: String) -> Int {
    let char = numbers.map { String($0) } //StringをString配列に変える
    var primeNumArray = [Int]()
    var checkList = Array<Int>(repeating: 0, count: char.count)
    // checkList意味：選択した数字を一番前の数字にして作れる素数をチェック！
    //例えば、1を選ぶとすると、1から始まる素数、11や17、101などの素数をすべて作り、これ以上作る素数がなければ次の数字に移るというシステム
    //まず、0に初期化し、選択した数字で素数の作成作業が始まると1にする。また、その作業が終わったら再び0に変更し、次のものを1にして、作業のプロセスを進める構造
    var selectNum = ""

    //素数の判断
    func checkPrime(_ num: Int) -> Bool {
        guard num > 1 else {return false}
        // num > 1じゃない時、else文実行. また、num > 1の時、ここのguard 以降のコードを実行
        guard num != 2 else {return true}
        // num が 2じゃないとき、guard文以降のコード実行 numが２のときは、else文にあるtrue実行して、checkPrime関数を抜ける
        // なぜなら、2も素数であるため

        var isPrime = true
        for i in 2..<num {
            if num % i == 0 {
                isPrime = false //割り切れる数字があるなら、入力したnumは素数じゃない！
                break    //breakでisPrime = false値を返す
            }
        }
        return isPrime
    }

    //順列アルゴリズム(再帰DFS探索)
    // DFS関数で用いたパラメータは以下のようになる
    //  1️⃣depth: 今まで作られた数字の桁数（0から始めて1ずつ足していってcountになると数字が完成する）
    //  2️⃣string: 選んだ数字
    //  3️⃣count: 作ろうとする数字の桁数
    func DFS(_ depth: Int, _ string: String, _ count: Int) {
        print("以下のfor文からの呼び出し入り　ー＞ \(checkList)")
        var DFS_count = 0
        if depth == count { //作る数字の桁数がmaxになった場合
            if let num_toInt = Int(string) {
                if checkPrime(num_toInt) && !primeNumArray.contains(num_toInt) {
                    primeNumArray.append(num_toInt)
                    print("->!!Find: \(primeNumArray) ")
                }
            }
        } else {
            for i in 0..<char.count {
                if checkList[i] == 0 {
                    print("DFS中のfor文入り　ー＞　現在のcheckList[\(i)] = \(checkList[i])")
                    selectNum += char[i]
                    print("-> 今選んだ数字: \(selectNum)")
                    checkList[i] = 1
                    print("DFS呼び出し前の checkList[\(i)] = \(checkList[i])")
                    print(primeNumArray)
                    print("DFSの呼び出し: \(DFS_count + 1)回目")
                    DFS(depth + 1, selectNum, count) //再帰関数 DFS の呼び出し
                    DFS_count += 1
                    print("DFS呼び出し後の checkList[\(i)] = \(checkList[i])")
                    print(primeNumArray)
                    checkList[i] = 0 // 再帰関数の呼び出しが終了後、チェックを解除する
                    selectNum = string // selectNumを stringに初期化する
                    print("DFS中のfor文が終わる時点　-> DFS呼び出し後の checkList[\(i)] = \(checkList[i])")
                }
            }
        }
    }

    for i in 1...char.count {
        print(" >> for文からのDFS呼び出しに入る: \(i)回目")
        DFS(0, "", i)
    }

    return primeNumArray.count
}

print(solution1("174"))


////練習
//let abcd = "abcd"
//let array1 = Array(abcd)
//print(type(of:array1)) // Array<Character>型



//// 入力された数字の文字列から、一桁も数字として一字ずつ取り出し、その取り出した数字で作られる数字を全部探すコード
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

//他の人のコード

//👋❌理解 NOT OKAY (Now Studying Step)
//🔥🔥[戦略] : Setを用いることで、重複をなくすことができる
func combinations(_ array: [String]) -> Set<String> {
    if array.count == 0 {
        return []
    }

    //🔥Closureの活用を身につけること！
    let answerArray = (0..<array.count).flatMap { i -> [String] in
        var removedArray = array
        let element = removedArray.remove(at: i)
        return [element] + combinations(removedArray).map { element + $0 }
    }

    return Set(answerArray)
}

//👋⭕️理解 OKAY
func isPrime2(_ number: Int) -> Bool {
    guard number > 1 else {
        return false
    }
    guard number != 2 else {
        return true
    }
    for i in 2..<number {
        if number % i == 0 {
            return false
        }
    }
    return true
}

func solution1_1(_ numbers: String) -> Int {
    let array = Array(numbers).map { String($0) }
    let set_Int = Set(combinations(array).compactMap { Int($0) }) //入力された数字で作れる全ての数字をOptionalを剥がして出力
    return set_Int.filter { isPrime2($0) }.count
}

print(solution1_1("17"))

//
////Closure 練習
////🌱❗️flatMap  の結果は、mapの結果をjoinedした後Arrayに変換するのと同じ！
////    flatMap : 順に全ての要素に対する変換作業を結合して返す
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
//    print("combinations関数 : \(call_func_count)回目")
//    print(array)
//    call_func_count += 1
//    if array.count == 0 {
//        return []
//    }
//
//    //🔥Closureの活用を身につけること！
//    let answerArray = (0..<array.count).flatMap { i -> [String] in
//        print("answerArray　の呼び出し: \(call_closure_count)回目")
//        call_closure_count += 1
//        var removedArray = array
//        let element = removedArray.remove(at: i)
//        print("現在選択した element = \(element)")
//        print("removedArray = \(removedArray)")
//        return [element] + combinations(removedArray).map { element + $0 }
//    }
//
//    return Set(answerArray)
//}
//
//print(combinations(["1", "7", "4"]))


