//
//  day67.swift
//  BaekJoon
//
//  Created by Kyus'lee on 2022/05/01.
//

import Foundation

//Day 67 多様なアルゴリズム - (5)
//BaekJoon n.11726 (2 x n タイル) 重要度: 🎖🎖🎖🎖🎖🎖
//🎖 DP
let squareSize = Int(readLine()!)!
var dp = Array(repeating: 0, count: squareSize + 1)
if squareSize == 1 {
    print(1)
} else if squareSize == 2 {
    print(2)
} else {
    dp[1] = 1
    dp[2] = 2
    for i in 3...squareSize {
        dp[i] = (dp[i - 1] + dp[i - 2]) % 10007
    }

    print(dp[squareSize])
}

// もっと効率的なコード
let nSize = Int(readLine()!)!
var dp = Array(repeating: 0, count: 1001)
dp[1] = 1
dp[2] = 2

if nSize > 2
{
    for i in 3...nSize
    {
        dp[i] = (dp[i-1] + dp[i-2]) % 10007
    }
}
print(dp[nSize])

//BaekJoon n.11047 (コイン 0) 重要度: 🎖🎖🎖🎖🎖🎖
//🎖 Greedy
let data = readLine()!.split(separator: " ").map { Int(String($0))! }
let coinTypes = data[0], targetValue = data[1]
var coinValues = Array(repeating: 0, count: coinTypes)

for i in 0..<coinTypes {
    let putCoinValue = Int(readLine()!)!
    if i == 0 {
        guard putCoinValue == 1 else {
            exit(0)
        }
        coinValues[i] = putCoinValue
    } else {
        if putCoinValue < coinValues[i - 1] {
            exit(0)
        }
        coinValues[i] = putCoinValue
    }
}

print(checkMinNeededCoins(targetValue))

func checkMinNeededCoins(_ target: Int) -> Int {
    var tempTarget = target
    var result = 0

    for i in stride(from: coinTypes - 1, through: 0, by: -1) {
        if tempTarget >= coinValues[i] {
            result += tempTarget / coinValues[i]
            tempTarget %= coinValues[i]
        }
        if tempTarget == 0 {
            break
        }
    }

    return result
}

//より効率的なコード
let data = readLine()!.split(separator: " ").map { Int(String($0))! }
let coinTypes = data[0]
var targetValue = data[1]
var coins = [Int]()
var result = 0

for _ in 0..<coinTypes {
    coins.append(Int(readLine()!)!)
}

for coin in coins.reversed() {
    if targetValue < coin {
        continue
    } else {
        result += targetValue / coin
        targetValue %= coin
    }
}

print(result)

//BaekJoon n.11403 (経路探し) 重要度: 🎖🎖🎖🎖🎖🎖
// 🎖Floyd Warshall
// 問題の設定: 有向グラフの場合, 重みなし
let nodes = Int(readLine()!)!
var from_To_Graph = [[Int]]()
var result = ""

for _ in 0..<nodes {
    from_To_Graph += [readLine()!.split(separator: " ").map { Int(String($0))! }]
}

floydWharshall()

for i in 0..<nodes {
    result += from_To_Graph[i].map { String($0) }.joined(separator: " ") + "\n"
}

result.removeLast()
print(result)

func floydWharshall() {
    for midPerson in 0..<nodes {
        for from in 0..<nodes {
            for to in 0..<nodes {
                if from_To_Graph[from][midPerson] == 1 && from_To_Graph[midPerson][to] == 1 {
                    from_To_Graph[from][to] = 1
                }
            }
        }
    }
}

//より効率的なコード
let nodes = Int(readLine()!)!
var adjacencyMatrix = [[Int]]()

// あるnodeAからあるnodeBまでの有向の辺がないんだったら  (その位置に0が入力された場合)、987654321という値を格納し、無限大だと表現する
// もし、1が入力された場合 ( nodeA から nodeBまでの有向の辺がある (AからBにはいけるけど、BからAにはいけない))は、そのまま入力された1を格納する
for _ in 0..<nodes {
    adjacencyMatrix += [readLine()!.split(separator: " ").map { Int(String($0))! }.map { $0 == 0 ? 987654321 : $0 }]
}

// floyd Warshallのアルゴリズム
for via in 0..<nodes {
    for from in 0..<nodes {
        for to in 0..<nodes {
            if adjacencyMatrix[from][to] > adjacencyMatrix[from][via] + adjacencyMatrix[via][to] {
                adjacencyMatrix[from][to] = adjacencyMatrix[from][via] + adjacencyMatrix[via][to]
            }
        }
    }
}

for i in 0..<nodes {
    let line = adjacencyMatrix[i].map { $0 == 987654321 ? 0 : 1 }

    //stringを用いた結果がもっと早い
    print(line.map { String($0) }.joined(separator: " "))
}

//BaekJoon n.1764 (聞いたことも見たこともない人) 重要度: 🎖🎖🎖🎖🎖🎖
// 🎖BinarySearch (二分探索)
// BinarySearchは、ソートされたデータじゃないと適用が不可能である
//順次探索を用いる場合、時間超過になってしまう -> データとして与えられる数の上限が500000であるため、順次探索だと500000まで全部探索してしまう
//  全数調査のオーダー記法 : O(N)
//  二分探索のオーダー記法 : O(logN) -> 理由: middle　（真ん中）を基準に探索対象を半分ずつ減らして探索するから

let data = readLine()!.split(separator: " ").map { Int(String($0))! }
let notHeardPeople = data[0], notSeenPeople = data[1]
var notHeardNames = [String]()
var notSeenNames = [String]()

for _ in 0..<notHeardPeople {
    notHeardNames.append(readLine()!)
}
notHeardNames.sort() //アルファベット辞書順に並べ替える

for _ in 0..<notSeenPeople {
    let putName = readLine()!
    if binarySearch_FindName(notHeardNames, putName) {
        notSeenNames.append(putName)
    }
}

notSeenNames.sort()

print(notSeenNames.count)
notSeenNames.forEach {
    print($0)
}

func binarySearch_FindName(_ notHeard: [String], _ notSee: String) -> Bool {
    var start = 0
    var end = notHeard.count - 1

    while start <= end {
        let mid = (start + end) / 2

        if notHeard[mid] == notSee {
            return true
        } else if notSee < notHeard[mid] {
            //notSee の方がnotHeard[mid]よりアルファベット辞書順が早いならendのborderを下げる
            end = mid - 1
        } else {
            //notSee の方がnotHeard[mid]よりアルファベット辞書順が後ろの方であるなら、startのborderを上げる
            start = mid + 1
        }
    }

    return false
}

//BaekJoon n.11659 (区間の和を求めよう) 重要度: 🎖🎖🎖🎖🎖
let data = readLine()!.split(separator: " ").map { Int(String($0))! }
let numbers = data[0], shouldFindOutCounts = data[1]
var numberArray = readLine()!.split(separator: " ").map { Int(String($0))! }
var stimulatedSum = Array(repeating: 0, count: numbers)
stimulatedSum[0] = numberArray[0]

for i in 1..<numbers {
    stimulatedSum[i] = numberArray[i] + stimulatedSum[i - 1]
}

for _ in 0..<shouldFindOutCounts {
    let sectionSetting = readLine()!.split(separator: " ").map { Int(String($0))! - 1 }
    let i = sectionSetting[0], j = sectionSetting[1]
    print(stimulatedSum[j] - (i == 0 ? 0 : stimulatedSum[i - 1]))
}
