//
//  Day5_BaekJoon Algorithm Class_2 day2.swift
//  BaekJoon
//
//  Created by Kyus'lee on 2022/02/10.
//

import Foundation
//
//// -----------------------------------------------
////👋🌈 勉強ファイル + 新しく学んだアルゴリズムの復習及び練習
//// -----------------------------------------------
//
//
////Tuple 勉強
//
//let tuple1 = ("KyusokLee",26)
//var tuple2_name = tuple1.0
//var tuple2_age = tuple1.1
//
////Swift で改行の入力しなくても、改行が行われる
//print(tuple1)
//print(tuple2_name)
//print(tuple2_age)
//
////Splitとcomponents(separatedby:)の違い
//let intro = "Hello, my name is Kyulee!"
//
//var result11 = intro.split(separator:" ")
////separatorの""の中に、空白を入れることでintroを空白単位で分けられる
////splitはseparator 以外にもいろんな引数をもっている
//// splitのreturn値はsubstring
//print(result11)
//
////components　メッソドはsplitとほとんど変わらないが、引数をseparatedByしか持ってない
////また、return値はStringである。
//var result22 = intro.components(separatedBy:" ")
//print(result22)
//// result1とresult2の結果は同じくなる。しかし、components(separatedBy:) の場合は、import Foundationする必要があるため、余計にメモリと時間を食ってしまう。
////できれば、splitsを使ってみよう
//
//let sentence1 = "Last year was 2021 , this year is 2022 ."
//let resul_sen1 = sentence1.components(separatedBy:" ")
//print(resul_sen1)
//print("\(Int(resul_sen1[3])!) + \(Int(resul_sen1[8])!) = ", Int(resul_sen1[3])! + Int(resul_sen1[8])!)
//print(Int(resul_sen1[3])! + Int(resul_sen1[8])!)
//
//let num1:Int = 1
//let num2:Int = 3
//print(num1 + num2)
//
////readLine()はStringを受け取る
////split使用
//let put1 = readLine()!
//let putArr1 = put1.split(separator: " ")
//print(putArr1)
//
////なぜ、!を使って、Optional Wrappingをしなければならないのかがわからない。勉強すること！
//let putArr2 = putArr1.map { Int($0)! * 2 }
////mapは既存のデータを変形するとき使う
//print(putArr2)
//
////String 練習
//let word2 = "Mississipi"
//var dict2: [String:Int] = [:]
//
////for  A in B 文法で BがStringの場合、AはCharacter typeである。
//for i in word2 {
//    if (dict2[String(i)] == nil) {
//        dict2[String(i)] = 1
//    }
//    else {
//       dict2[String(i)]! += 1
//    }
//}
//
//print(dict2)
//
////array practice + 文字列の結合練習
//var practice1 = [Int]()
//for _ in 0..<10 {
//    practice1.append(Int(readLine()!)!)
//}
//
//let maxOfArr = practice1.max()!
////max()とmin()はOptional値を返す＞＞そのため、！をつけた
//let idxOfMax = practice1.firstIndex(of:maxOfArr)! //!する理由はなんでだろう。。
//let idxOfEnd = practice1.endIndex
////文字列の最後の文字であるendIndexは、配列の全長の値を返すので、注意する必要がある
//// [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]があるときendIndexは10を返す 実際の最後の要素はarray[9]である。
//print(practice1)
//print(maxOfArr)
//print(idxOfMax)
//print(idxOfEnd)
//practice1.insert(900, at: idxOfEnd)
//print(practice1)
//
////Mapの考察・練習
//var intArr = [Int]()
//var resultArr = [Int]()
//
//for _ in 0..<3 {
//    intArr.append(Int(readLine()!)!)
//}
//
//var mul = intArr.reduce(1){ $0 * $1 } // ->Type: Int
////Int型はmapを持っていない
////Intの数字をInt型の一字一字ずつ分けるときは、Stringに変換した後、また、Intに変換する必要がある。
//let splitmul = String(mul).map { $0 } //このままだと、"”がついているCharacter型を要素と持つ配列を返す
//print(splitmul)
//print(type(of:splitmul[0]))
//let splitmul2 = String(mul).map { String($0) } //""がついているString型の要素を持つ変換
//print(splitmul2)
//print(type(of:splitmul2[0]))
//let splitmul3 = String(mul).map { Int(String($0))! }//もう一回変換することで、Optionalになってるため、!がつける
//print(splitmul3)
//print(type(of:splitmul3[0]))
////character型から直接int型に変換はできない（？）けど、Stringに変えてからInt型に変えると可能である。
//
////let splitmul2 = String(mul).map {}
////mapは配列に変換してくれる
////配列をmapするとcharacterにタイプが変わる
//
////ASCIIコードへの変換とその逆変換の練習
//let a = 65
//let b = UnicodeScalar(a)! //Scalar型に変換する
//print(type(of:b))
//print(a)
//print(b)
//
////UnicodeScalarの意味：Asciiコードの値を文字（数字、アルファベット、日本語など）に変換してくれる
//let prac_word = Array(readLine()!) //入力したStringを一字ずつ分けて、配列にCharacterとして格納
//print(prac_word)
//print(type(of:prac_word))
//
////Typeの変換と結合、結合後の再変換の練習, reduceの勉強
//let prac_array_N = Array(readLine()!).map { String($0) }
//let prac_num_digits = prac_array_N.count
//let prac_int_N = Int(prac_array_N.reduce("") { $0 + $1 })! //reduceの時点でType: String
////Int()!で囲むことで、Int型になる
//
//print(prac_int_N)
//print(type(of:prac_int_N))
//
////Compactmap と　wholeNumbleValue　, ??の勉強
//let c = "2002"
//let d = c.compactMap { $0 }
//print(c)
//print(type(of:c))
//print(d)
//print(type(of:d))
//
//// ‼️compactMap(\.wholeNumberValue) は　compactMap{ $0.wholeNumberValue }のClosureを簡略化した文法
////      mapは nil　を除去しないまま配列として変えすが、compactMapは nilを除去した配列を返す！😳
//// ‼️wholeNumberValueは、　文字が表す数字値を返すが、　その値が必ずwhole number, つまり 0と自然数を返してくれる
////      負の整数は変換できない！
////      また、数字だけじゃなく　④,　万, 十三 のような数字の意味を持つ文字も数字の値として変換してくれる！😳
////      wholeNumberValueはOptional値を返すため、実際使うときは Optionalを無くす方法を用いましょう！
////      wholeNumberValueのメリットは：Character -> Int 型に直接変換ができるということ。😳
//let e = c.compactMap(\.wholeNumberValue)  // \.wholeNumbervalue >> Intに変換してくれる
//print(e)
//print(type(of:e))
//
//let f = c.compactMap{ $0.wholeNumberValue }
//print(f)
//print(type(of:f))
//
//let practice_1 = [0, 1, 2, 3, nil, 4]  //>> nilが入ったせいで、Array<Optional<Int>>型になっている
//print(type(of:practice_1))
//print(practice_1)
//
//let practice1_1 = practice_1.compactMap { $0 } //Optional を剥がしてくれるし、nilも除去してくれる！
//print(practice1_1)
//print(type(of:practice1_1))
//
//let practice_2 = [1, 2, 3, 4, 5]       //>> nilが入っていないので、Array<Int>型である
//print(type(of:practice_2))
//
////let practice_3 = [0, 1, 2, 3, nil, "a"]  >> [Any]はTypeを明示しないとダメ！必ず、Typeの宣言をしましょう！
//
//let practice_3: [Any?] = [0, 1, 2, 3, nil, "a", "2"] //nilがあることからTypeをAny?で宣言する！
//
//// ⚠️⁉️??文法はいつ使うのかについての勉強が必要！！！！
////let practice_4 = readLine()!
////print(
////    (practice_4 == "a") ?? 1
////)
//
////Typeの確認　復讐用
//let N_K1 = readLine()!.split(separator: " ") //Array<Substring>を生成
//print(type(of:N_K1))
//
////　⚠️‼️ enumerated と　filter　と　mapを用いてindexを求める方法
//var testArray = ["*", "S", "D", "*"]
//let x = testArray.enumerated().filter {$0.1 == "*" }.map { $0.0 }
//print(x)
//
//// 🔥IMPORTANT Bit Masking Operator　練習🔥
//var testArray33 = [2, 3, 4, 5, 6]
//let idx1 = 1 << testArray33[0]
//let idx2 = 1 << testArray33[1]
//let idx3 = 1 << testArray33[2]
//print(idx1)
//print(idx2)
//print(idx3)
//
//if idx1 & idx2 == 0 {
//    print("yes")
//}
//
//let a33 = 4
//let b33 = 444
//let c33 = a33 & b33
//print(c) // 共通の数字 4 が出力される
//
//// 下記のif文は実行されない
//if a33 & b33 == 1 {
//    print("have same Bit") //共通である部分があるため、出力されない
//}
//// 完全に同じ値であれば　1(True) , 共通の部分が完全にないときは 0(False)  また、共通の部分があれば 0も1もならない
//
////共通の部分があるときは.....
//if a33 & b33 != 1 {
//    print("have same Bit") // 出力: have same Bit
//}
//
//if a33 & b33 != 0 {
//    print("have same Bit") // 出力: have same Bit
//}
//
//let d33 = 44
//let e33 = 444
//let dANDe = d33 & e33
//print(dANDe) //44が出力される
//
//// OR 演算子 ( | 演算子 ) は、二つのBitを結合する演算子である
//
//// ex) 101 (5) OR 1000 (8) = 1101 (13)
//let practiceBit1 = 5
//let practiceBit2 = 8
//let Bit1ORBit2 = practiceBit1 | practiceBit2
//print(Bit1ORBit2) //13が出力される
//
//// ex) 111 (7) OR 100 (4) = 111 (7)
//let pracBit3 = 7
//let pracBit4 = 4
//let prac3OR4 = pracBit3 | pracBit4
//print(prac3OR4) //7が出力される

//// 🔥 Tuple 型の contains活用 🔥
//var visited: [(Int, Int)] = []
//var index = 0
//visited.append((1, 2))
//visited.append((2, 3))
//visited.append((4, 7))
//visited.append((5, 6))
//print(visited)
//if visited.contains(where: { $0 == (5, 6) }) {
//    index = visited.firstIndex(where: { $0 == (5, 6) })!
//    print(index)
//    print("wow")
//}

////  🔥 配列の活用練習🔥
//var pracArrayA = [0, 1, 2, 3, 4]
//var newPracA = [[Int]]()
//if pracArrayA.contains(4) {
//    newPracA.append(Array(pracArrayA[pracArrayA.firstIndex(of: 4)!...]))
//}
//print(newPracA) // [[4]]が出力される
//
//var newPracC = Array(pracArrayA.firstIndex(of: 2)!...4)
//print(newPracC) // [2, 3, 4]が出力される
//
//var newPracB = [[Int]]()
//if pracArrayA.contains(2) {
//    newPracB.append(Array(pracArrayA.firstIndex(of: 2)!...pracArrayA.endIndex))
//}
//print(newPracB) // [[2, 3, 4, 5]]が出力される --> つまり、endIndexは、配列上でのindexではなく、そのindexが配列で何番目のindexであるかを表すメッソドである
//
//var newPracBB = [[Int]]()
//if pracArrayA.contains(2) {
//    newPracBB.append(Array(pracArrayA.firstIndex(of: 2)!...pracArrayA.endIndex - 1))
//    // 上の表記でendIndexを記入しないと、newPracBBが正しく出力されずに加え、プログラムが正しく終わらなくなる --- (*)
//}
//print(newPracBB) // [[2, 3, 4]]が出力される
//
//var newPracBBB = [[Int]]()
//if pracArrayA.contains(2) {
//    newPracBBB.append(Array(pracArrayA[pracArrayA.firstIndex(of: 2)!...]))
//    //　上の表記では、上記で示した (*)とは違って、配列に格納された要素の数はすでに決まっており、パソコンが配列の最後の要素のindexが何かを認識することができる
//    //   --> そのため、このような表記方法は、(*) と異なり、newPracBBBが正しく出力されると共に、プログラムが正しく終わる
//}
//print(newPracBBB) // [[2, 3, 4]]が出力される

////Day 74 多様なアルゴリズム - (12)
////BaekJoon n.11053 (最長増加部分数列) 重要度: 🎖🎖🎖🎖🎖
//// 🎖DP (LIS)
//let size = Int(readLine()!)!
//let array = readLine()!.split(separator: " ").map { Int(String($0))! }
//var dp = Array(repeating: 1, count: size + 1)
//
//for i in 1..<size {
//    for j in 0..<i {
//        if array[j] < array[i] {
//            dp[i] = max(dp[i], dp[j] + 1)
//        }
//    }
//}
//
//print(dp.max()!)

////BaekJoon n.1932  (整数三角形) 重要度: 🎖🎖🎖🎖🎖🎖🎖
//// 🎖DP
//let size = Int(readLine()!)!
//var arrayPyramid: [[Int]] = [[]]
//var dp = Array(repeating: Array(repeating: 0, count: 501), count: 501) // (問題文のデータ上限値)
//
//for _ in 0..<size {
//    arrayPyramid.append(readLine()!.split(separator: " ").map { Int(String($0))! })
//}
//
////arrayPyramid[0][0] は、現在 []の空列が入っている
//dp[1][0] = arrayPyramid[1][0]
//for i in stride(from: 2, through: size, by: 1) {
//    for j in 0..<arrayPyramid[i].count {
//        if j == 0 {
//            // 左端
//            dp[i][j] = dp[i - 1][j] + arrayPyramid[i][j]
//        } else if j == arrayPyramid[i].count - 1 {
//            // 右端
//            dp[i][j] = dp[i - 1][j - 1] + arrayPyramid[i][j]
//        } else if j < arrayPyramid[i].count - 1 {
//            // 上記に当てはまらない　左端 ~ 右端の間にある値
//            dp[i][j] = max(dp[i - 1][j - 1] + arrayPyramid[i][j], dp[i - 1][j] + arrayPyramid[i][j])
//        }
//    }
//}
//
//print(dp[size].max()!)

////BaekJoon n.1991  (ツリー巡回) 重要度: 🎖🎖🎖🎖🎖🎖🎖🎖🎖
//// 🎖HARD Tree ❗️
//
//// "A" == ASCII 65
//// "." == ASCII 46
//class TreeNode {
//    let value: String
//    var leftChild: TreeNode?
//    var rightChild: TreeNode?
//
//    init(_ value: String, _ left: TreeNode?, _ right: TreeNode?) {
//        self.value = value
//        self.leftChild = left
//        self.rightChild = right
//    }
//}
//
//func preOrder(current: TreeNode?) {
//    guard let curr = current else {
//        // nilの場合: return
//        return
//    }
//    resultPreOrder.append(curr.value)
//
//    preOrder(current: curr.leftChild)
//    preOrder(current: curr.rightChild)
//}
//
//func inOrder(current: TreeNode?) {
//    guard let curr = current else {
//        return
//    }
//    inOrder(current: curr.leftChild)
//    resultInOrder.append(curr.value)
//    inOrder(current: curr.rightChild)
//}
//
//func postOrder(current: TreeNode?) {
//    guard let curr = current else {
//        return
//    }
//    postOrder(current: curr.leftChild)
//    postOrder(current: curr.rightChild)
//
//    resultPostOrder.append(curr.value)
//}
//
//extension TreeNode: CustomStringConvertible {
//    var description: String {
//        return [value].joined()
//    }
//}
//
//let nodeNums = Int(readLine()!)!
//var nodes = [TreeNode]() //nodesは、配列である
////-> しかし、出力すると、 このファイルが入っている  (プロジェクトの名前.TreeNode) が出てくる
//// CustomStringConvertibleのプロトコルが必要だった
//
//var resultPreOrder = [String]()
//var resultInOrder = [String]()
//var resultPostOrder = [String]()
//let alphaArr = Array(65...90).map { String(Character(UnicodeScalar($0))) }
////入力された数字をUnicodeScalarにデータmappingしてそれをまた、文字（Character）に変更する文法
//
//for i in 0..<nodeNums {
//    nodes.append(TreeNode(alphaArr[i], nil, nil))
//}
//
//// UInt8 事態が Optinonal Typeであるため、次のmap では、 Int($0)!じやなく、Int($0)にした
//
//for _ in 0..<nodeNums {
//    let input = readLine()!.split(separator: " ").map { Character(String($0)).asciiValue! }.map { Int($0) - 65 }
//    //UInt8に変換してまたInt型に変換
//    //"."は、ASCII 46である
//
//    if input[1] >= 0 {
//        nodes[input[0]].leftChild = nodes[input[1]]
//    }
//    if input[2] >= 0 {
//        nodes[input[0]].rightChild = nodes[input[2]]
//    }
//}
//
//let root = nodes[0]
//
//preOrder(current: root)
//inOrder(current: root)
//postOrder(current: root)
//
//print(resultPreOrder.joined())
//print(resultInOrder.joined())
//print(resultPostOrder.joined())

////BaekJoon n.1629  (掛け算 (大数)) 重要度: 🎖🎖🎖🎖🎖
//// 🎖数学 + 分割統治
//let numData = readLine()!.split(separator: " ").map { Int(String($0))! }
//let (A, B, C) = (numData[0], numData[1], numData[2])
//print(dfs_mul(B))
//
//func dfs_mul(_ num: Int) -> Int {
//    if num == 0 {
//        return 1
//    }
//
//    if num % 2 == 0 {
//        let resultValue = dfs_mul(num / 2)
//        return ((resultValue % C) * resultValue) % C
//    } else {
//        let resultValue = dfs_mul((num - 1) / 2)
//        return ((((resultValue % C) * resultValue) % C) * A) % C
//    }
//}

//BaekJoon n.1039  (交換) 重要度: 🎖🎖🎖🎖🎖🎖🎖🎖
// 🎖BFS
let data = readLine()!.split(separator: " ").map { Int(String($0))! }
let targetNum = data[0], caseCount = data[1]
var checked = Array(repeating: Array(repeating: false, count: 11), count: 1000001)
var index = 0


//📝➡️ここからは、明日から
//BaekJoon Algorithm Study n.11725 (treeの親探し)

//⬇️復習まだ、やってない問題
//BaekJoon Algorithm Study n. 14500 (テトロミノ)　重要度: 🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖
