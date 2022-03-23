//
//  Day5_BaekJoon Algorithm Class_2 day2.swift
//  BaekJoon
//
//  Created by Kyus'lee on 2022/02/10.
//

import Foundation

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


////BaekJoon Algorithm Study n.16236 (Baby Shark) 重要度: 🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖
////　初の Gold Rank. 3　難易度の問題
//// ‼️Very Hard‼️
//// 🔥📚必ず、使いこなせるようにアルゴリズムの設計をちゃんと分析及び復習すること！！！🔥
//
////９があるマスが、赤ちゃんサメがいる場所。　赤ちゃんサメの大きさは、最初は2に固定(初期値)
//// 0は、空のマス
//// 1, 2, 3, 4, 5, 6　マスにいる魚の大きさ 7と8はない
//
//let mapSize = Int(readLine()!)!
//var map = [[Int]]()
//let directionRow = [0, 0, 1, -1]
//let directionColumn = [1, -1, 0, 0]
//var sharkLocate = (-1, -1, -1)
//var result = 0
//var eatCount = 0
//
////データの入力後、スタート時点(9のところ)を０に変える
//for i in 0..<mapSize {
//    let mapData = readLine()!.split(separator: " ").map { Int(String($0))! }
//    map += [mapData]
//
//    if let j = mapData.firstIndex(of: 9) {
//        sharkLocate = (i, j, 2)
//        map[i][j] = 0
//    }
//}
//
//while true {
//    if !bfs_sharkMoving() {
//        print(result)
//        break
//    }
//}
//
////⚠️注意:魚を一個食べるたびに、赤ちゃんサメの現在位置が更新されるため、この関数を呼び出すたびに、近い距離にある魚は異なる
//func bfs_sharkMoving() -> Bool {
//    var fishArray = [(Int, Int)]()
//    var index = 0
//    var neededCheckQueue = [(sharkLocate.0, sharkLocate.1, 0)]
//    var visited = Array(repeating: Array(repeating: false, count: mapSize), count: mapSize)
//    var distance = 98765432
//    visited[sharkLocate.0][sharkLocate.1] = true
//
//    while index < neededCheckQueue.count {
//        let (currentRow, currentColumn, distanceCount) = neededCheckQueue[index]
//        //⚠️indexの位置がとても重要！！ -> 理由: 下記の if distanceCount > distance の文がcontinueされるため、continue文の上に記入する必要がある
//        //もし、いつも私が作成したようにwhile文の一番下に書く場合、indexは増えずwhile文だけが繰り返されるため、break文に至らない
//        index += 1
//        //距離が同じ場合と既存の距離より小さい時だけ、このif文を省略できるようにする
//        if distanceCount > distance {
//            continue
//        }
//
//        if (1..<sharkLocate.2).contains(map[currentRow][currentColumn]) {
//            distance = distanceCount
//            fishArray.append((currentRow, currentColumn))
//        }
//
//        for i in 0..<4 {
//            let nextRow = currentRow + directionRow[i]
//            let nextColumn = currentColumn + directionColumn[i]
//
//            if nextRow < 0 || nextRow >= mapSize || nextColumn < 0 || nextColumn >= mapSize {
//                continue
//            }
//
//            if 0 <= map[nextRow][nextColumn] && map[nextRow][nextColumn] <= sharkLocate.2 && !visited[nextRow][nextColumn] {
//                visited[nextRow][nextColumn] = true
//                neededCheckQueue.append((nextRow, nextColumn, distanceCount + 1))
//            }
//        }
//    }
//
//    //食べれる魚がなかったら、関数がfalseをreturnし、関数を終了する
//    if fishArray.isEmpty {
//        return false
//    }
//
//    //赤ちゃんサメの現在位置から、最も近い距離に複数の候補がある場合、同じ行であれば一番左のマスにいる魚を、同じ行にある魚じゃない場合、なるべく上の行にある魚を食べる(問題の設定)
//    //同じ距離に食べれる魚が複数ある場合、row(行)を優先、その後が、column(列)　（問題文の要求事項）
//    fishArray.sort {
//        if $0.0 == $1.0 {
//            return $0.1 < $1.1
//        }
//        return $0.0 < $1.0
//    }
//
//    let targetFish = fishArray.first!
//    eatCount += 1
//
//    if eatCount == sharkLocate.2 {
//        sharkLocate.2 += 1
//        eatCount = 0
//    }
//
//    map[targetFish.0][targetFish.1] = 0
//    sharkLocate = (targetFish.0, targetFish.1, sharkLocate.2)
//
//    result += distance
//    return true
//}

////🔥以前に書いたコード
//let mapSize = Int(readLine()!)!
//var map = [[Int]]()
//let directionRow = [0, 0, 1, -1]
//let directionColumn = [1, -1, 0, 0]
//var sharkLocate = (-1, -1, -1)
//var result = 0
//var eatCount = 0
//
//for i in 0..<mapSize {
//    let mapData = readLine()!.split(separator: " ").map { Int(String($0))! }
//    map += [mapData]
//
//    if let j = mapData.firstIndex(of: 9) {
//        sharkLocate = (i, j, 2)
//        map[i][j] = 0
//    }
//}
//
//while true {
//    if !bfs_sharkMoving(sharkLocate.0, sharkLocate.1, sharkLocate.2) {
//        print(result)
//        break
//    }
//}
//
//func bfs_sharkMoving(_ rowStart: Int, _ columnStart: Int, _ size: Int) -> Bool {
//    var fishArray = [(Int, Int)]()
//    var index = 0
//    var neededCheckQueue: [(row: Int, column: Int, moveStack: Int)] = [(rowStart, columnStart, 0)]
//    var visited = Array(repeating: Array(repeating: false, count: mapSize), count: mapSize)
//    var distance = 98765432
//    visited[rowStart][columnStart] = true
//
//    while index < neededCheckQueue.count {
//        let (currentRow, currentColumn, distanceCount) = neededCheckQueue[index]
//        index += 1
//
//        if distanceCount > distance {
//            continue
//        }
//
//        if (1..<size).contains(map[currentRow][currentColumn]) {
//            distance = distanceCount
//            fishArray.append((currentRow, currentColumn))
//        }
//
//        for i in 0..<4 {
//            let nextRow = currentRow + directionRow[i]
//            let nextColumn = currentColumn + directionColumn[i]
//
//            if nextRow < 0 || nextRow >= mapSize || nextColumn < 0 || nextColumn >= mapSize || map[nextRow][nextColumn] > size || visited[nextRow][nextColumn] {
//                continue
//            }
//
//            visited[nextRow][nextColumn] = true
//            neededCheckQueue.append((nextRow, nextColumn, distanceCount + 1))
//        }
//    }
//
//    if fishArray.isEmpty {
//        return false
//    }
//
//    //赤ちゃんサメの現在位置から、最も近い距離に複数の候補がある場合、同じ行であれば一番左のマスにいる魚を、同じ行にある魚じゃない場合、一番上の行の魚を食べる(問題の設定)
//    fishArray.sort {
//        if $0.0 == $1.0 {
//            return $0.1 < $1.1
//        }
//        return $0.0 < $1.0
//    }
//
//    let targetFish = fishArray.first!
//    eatCount += 1
//
//    if eatCount == size {
//        sharkLocate.2 += 1
//        eatCount = 0
//    }
//
//    map[targetFish.0][targetFish.1] = 0
//    sharkLocate = (targetFish.0, targetFish.1, sharkLocate.2)
//
//    result += distance
//
//    return true
//}

////📝🔥 - - - - -- DPでLISを求めるアルゴリズム - - - - - --
//
//let testCase = [1, 3, 2, 5, 4, 6] //入力数列
//var countArray = [Int]() //入力数列の要素ごとに、当該要素までの最長数列を保存するための配列
//var max = 1 // count配列に保存される最長数列の長さの中、最も長い長さの値を保存するための変数
//
////コードの説明:
////     testCase配列の一番目から最後の要素まで、順番通りチェックするための二重for文を使用
////     繰り返すたびに、まずcount配列に1を追加しておいた
////       ->> 自分自身以外、増加する数がないとしても、最小限自分自身を含んだ長さ１の数列になり得るため、基本的に１を追加する
////     1を追加したcountArray配列の長さほど、下位loop文を実行するが、まず、testCase配列でindex jにある数が index iにある数より小さいかどうかをチェック
////     小さかったら、countArrayに保存したj番目の要素とi番目の要素を比較する
////       ->> i番目の要素、つまりcountArrayに追加した最後の要素である1がcountArray[j]より小さいか同値であれば、i番目の要素はj番目の要素が持つ最長増加数列の個数に１を足した分、最長増加数列を持つという意味で解釈できる
////     上記の施行を繰り返すと、最長増加数列を持つ要素とその長さを求めることができる
//
//for i in 0..<testCase.count {
//    countArray.append(1)
//
//    for j in 0..<countArray.count {
//        if testCase[j] < testCase[i] && countArray[i] <= countArray[j] {
//            countArray[i] = countArray[j] + 1
//        }
//    }
//
//    print(countArray)
//
//    if max < countArray[i] {
//        max = countArray[i]
//    }
//}
//print(countArray)
//
//print(max)

////BaekJoon Algorithm Study n.1965 (箱を入れよう) 重要度: 🎖🎖🎖🎖🎖🎖🎖
//// DP + LIS(最長増加部分数列)アルゴリズム
////LIS(Longest Increasing Subsequence) : 部分的に増加する数列の中、最も長いものを探すアルゴリズム
////        🔥簡単に言えば、「小さい値 -> 大きい値」 に至る、繋げられる最大の個数を求めることである🔥
//// 例: [1, 6, 2, 5, 7, 3, 5, 6]の場合
////     1 -> 6
////     1 -> 2 -> 5 -> 7
////     1 -> 2 -> 3 -> 5 -> 6   つまり、max: 5
//
//
//let boxes = Int(readLine()!)!
//let boxLine = readLine()!.split(separator: " ").map { Int(String($0))! }
//var count = [Int]()
//var max = 1
//
//for i in 0..<boxes {
//    count.append(1)
//
//    for j in 0..<count.count {
//        if boxLine[j] < boxLine[i] && count[i] <= count[j] {
//            count[i] = count[j] + 1
//        }
//    }
//
//    if max < count[i] {
//        max = count[i]
//    }
//
//}
//
//print(max)

////📝🔥 - - - - -- 位相ソートアルゴリズム - - - - - --
////⚠️途中の段階⚠️
//struct Graph<T>: Equatable where T: Equatable {
//    var childs: [T]
//
//    mutating func push(_ child: T) {
//        self.childs.append(child)
//    }
//}
//
//var nodes = 5
//var inDegree = [Int](repeating:0, count: nodes) //各　Nodesの進入次数情報
//var trees = [Graph<Int>]()
//inDegree[1] = 1
//inDegree[2] = 1
//inDegree[3] = 2
//inDegree[4] = 1
//
//toPologicalSort()
//
//func toPologicalSort() -> [Int] {
//    var result = [Int]()
//    var Queue = [Int]()
//
//    for i in 0..<nodes {
//        print(i)
//        if inDegree[i] == 0 {
//            Queue.append(inDegree[i])
//        }
//    }
//
//    for _ in 0..<nodes {
//
//        if Queue.isEmpty {
//            print("サイクルができてしまいました!!")
//            exit(0)
//        }
//
//        result.append(Queue.first!)
//        let node = Queue.removeFirst()
//
//        for child in trees[node].childs {
//            // ⚠️上記のchildsの部分でindex　out of rangeエラーがでてしまう
//            inDegree[child] -= 1
//            if inDegree[child] == 0 {
//                Queue.append(child)
//            }
//        }
//    }
//
//    return result
//}

////他の方法1
//let Nodes = Int(readLine()!)!
//var graph = [[Int]](repeating: [], count: Nodes + 1)
//var indegree = [Int](repeating: 0, count: Nodes + 1)
//var cost = [Int](repeating: 0, count: Nodes + 1)
//var result = [Int](repeating: 0, count: Nodes + 1)
//
//for i in 1...Nodes {
//    let input = readLine()!.split(separator: " ").map { Int(String($0))! }
//    cost[i] = input[0]
//    result[i] = input[0]
//    for j in 2..<2 + input[1] {
//        graph[i].append(input[j])
//        indegree[input[j]] += 1
//    }
//}
//
//func topologySort(_ start: Int) -> [Int] {
//    var queue = indegree[1...].enumerated().filter { $0.element == 0 }.map { $0.offset + 1 }
//    var stack = [Int]()
//
//    while !queue.isEmpty {
//        let first = queue.removeFirst()
//        result.append(first)
//        if graph[first].isEmpty {
//            stack.append(result[first])
//        }
//
//        for element in graph[first] {
//            result[element] = max(result[element], result[first] + cost[element])
//            indegree[element] -= 1
//            if indegree[element] == 0 {
//                queue.append(element)
//            }
//        }
//    }
//    return stack
//}
//
//print(topologySort(Nodes).max()!)


////BaekJoon Algorithm Study n.2252 (列を並ばせよう) 重要度: 🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖
//// 🔥Very Hard🔥
//// DP + 位相ソートアルゴリズム
//// ⚠️途中の段階⚠️
//// 二人の学生の情報が入力される
////  例えば、A B --> 学生Aが　学生Bの前にいなければいけないってことを意味（問題条件）
//
//let data = readLine()!.split(separator: " ").map { Int(String($0))! }
//let students = data[0], compareNums = data[1]
//var resultArray = [Int]()
//var count = [Int]()
//
//for _ in 0..<compareNums {
//
//
//
//}

//BaekJoon Algorithm Study n.7569 (トマト)　重要度:🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖
//⚠️途中の段階⚠️

let data = readLine()!.split(separator: " ").map { Int(String($0))! }
let columnSize = data[0], rowSize = data[1], heightSize = data[2]
var field = [[[Int]]](repeating: [[Int]](repeating: [Int](), count: rowSize), count: heightSize)
let directionRow = [0, 0, 1, -1]      //東西南北
let directionColumn = [1, -1, 0, 0]   //東西南北
let directionHeight = [1, 0, -1]         //上下
var result = 0
var neededCheckQueue: [(height: Int, row: Int, column: Int, day: Int)] = []

for i in 0..<heightSize {
    for j in 0..<rowSize {
        let rowData = readLine()!.split(separator: " ").map { Int(String($0))! }
        field[i][j].append(contentsOf: rowData)
    }
}

for z in 0..<heightSize {
    for y in 0..<rowSize {
        for x in 0..<columnSize {
            if field[z][y][x] == 1 {
                neededCheckQueue.append((z, y, x, 0))
            }
        }
    }
}

bfs_CountingRipeningData()
print(field)

var isPossible = true

loop: for z in 0..<heightSize {
    for y in 0..<rowSize {
        for x in 0..<columnSize {
            if field[z][y][x] == 0 {
                isPossible = false
                break loop
            }
        }
    }
}

if !isPossible {
    print(-1)
} else {
    print(result)
}

func bfs_CountingRipeningData() {
    var index = 0
    var resultDay = 0
    
    while index < neededCheckQueue.count {
        let (currentHeight, currentRow, currentColumn, dayCount) = neededCheckQueue[index]
        resultDay = dayCount
        
        for i in 0..<3 {
            let nextHeight = currentHeight + directionHeight[i]
            
            if nextHeight < 0 || nextHeight >= heightSize {
                continue
            }
            
            for j in 0..<4 {
                let nextRow = currentRow + directionRow[j]
                let nextColumn = currentColumn + directionColumn[j]
                
                if nextRow < 0 || nextRow >= rowSize || nextColumn < 0 || nextColumn >= columnSize {
                    continue
                }
                
                if field[nextHeight][nextRow][nextColumn] == 0 {
                    field[nextHeight][nextRow][nextColumn] = 1
                    neededCheckQueue.append((nextHeight, nextRow, nextColumn, dayCount + 1))
                }
            }
        }
        index += 1
    }
    result = resultDay
}


//📝➡️ここからは、明日から
//BaekJoon Algorithm Study n.11725 (treeの親探し)

//⬇️復習まだ、やってない問題
//BaekJoon Algorithm Study n. 14500 (テトロミノ)　重要度: 🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖


