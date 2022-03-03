//
//  Day 25.swift
//  BaekJoon
//
//  Created by Kyus'lee on 2022/03/03.
//

import Foundation


//Day 25: 具現問題(2) + Greedy Algorithm(1)

//BaekJoon Algorithm Study n.15686 (チキン配達) 重要度：🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖
// ‼️🔥Very Difficult 🔥
// ⚠️途中の段階

let data = readLine()!.split(separator: " ").map { Int(String($0))! }
let citySize = data[0], notClosed = data[1]
// チキンのお店の中、最大　notClosedの個を選ぶってこと
// カードゲームと似たようなアルゴリズム

var cityData = [[Int]]()
var chickenDistace = [[Int]]()
var chickenHouse = [(Int, Int)]() //チキンのお店の座標だけを格納した配列
var houses = [(Int, Int)]() //家があるとこの座標だけを格納した配列
var min_AllDistance = 98765431
// ここで、0じゃなく充分大きい数字を初期値として設定しなければ、select関数のmin_AllDistance = min(min_AllDistance, count_AllCityDistance(selected))が反映されない。なぜかというと、ずっと0になってしまうから!

for _ in 0..<citySize {
    let putData = readLine()!.split(separator: " ").map { Int(String($0))! }
    cityData += [putData]
}

// チキンのお店があるとこだけ、新しい配列に格納する >> 場合の数を求めやすくするため
for i in 0..<citySize {
    for j in 0..<citySize {
        if cityData[i][j] == 2 {
            chickenHouse.append((i, j))
        } else if cityData[i][j] == 1 {
            houses.append((i, j))
        }
    }
}

select([], 0) // ⚠️エラー問題の解決: ここで、最初に渡す値がchickienHouse[0]になると、select関数は、elseのfor文を繰り返すことなく、ifの文で終わってしまう。注意しよう！
print(min_AllDistance)

//反例の問題: チキンハウスが1個しかないときに間違った値が出る
//🔥⚠️組み合わせのアルゴリズム : 再帰関数を用いるコード
func select(_ selected: [(Int, Int)], _ index: Int) {
    if selected.count == notClosed {
        min_AllDistance = min(min_AllDistance, count_AllCityDistance(selected))
    } else {
        for i in index..<chickenHouse.count {
            select(selected + [chickenHouse[i]], i + 1)
            // 例えば、count = 5であり、i + 1が5になったと仮定する。その時、countより小さくないから、ここのfor文に入ることはない
        }
    }
}

//全体の距離を足す関数
func count_AllCityDistance(_ selectedChickens: [(Int, Int)]) -> Int {
    var allDistance = 0
    for house in houses {
        var minDistance = 987654321

        for chicken in selectedChickens {
            let distance = countingDistance(house, chicken)
            minDistance = min(minDistance, distance)
            //比較する対象となる変数を設けることが大事　＞＞　理由：それぞれのチキンのお店との距離を求め、その中で最小値となる値が正解になるため
        }
        allDistance += minDistance
    }

    return allDistance
}

//　2つの座標間の距離を求める関数
func countingDistance(_ data1: (Int, Int), _ data2: (Int, Int)) -> Int {
    return abs(data1.0 - data2.0) + abs(data1.1 - data2.1)
}

//反例:BaekJoon Site で示された5 1の場合がエラーになる

//BaekJoon Algorithm Study n.1436 (映画監督 Shom)
//　アイデアが難しい
// 数字の順位を比較する問題は、一つずつ足しながら条件に代入してみると、解決しやすい傾向がある

//方法１:１ずつ足していくBruteForce計算
// ただし、Brute Forceであるとしても、このコードは処理時間がすごいかかってしまう

let movieCount = Int(readLine()!)!
var count = 0
var target = 665

while true {
    target += 1
    let char_target = String(target)
    var check = 0
    for i in char_target {
        if i == "6" {
            check += 1
        } else {
            check = 0
        }

        if check == 3 {
            count += 1
        }
    }

    if movieCount == count {
        print("\(target)")
        break
    }
}

//方法２:パターンを分析した方法
let N = Int(readLine()!)!
var start = 0
var targetNum = 666

while start != N {
    if isTargetNum(number: targetNum) {
        start += 1
    }
    targetNum += 1
}

print(targetNum - 1)

func isTargetNum(number: Int) -> Bool {
    var n = number
    var count = 0
    while n > 0 {
        // 入力した数字を % 10、n /= 10 することで、連続的に6がある数字かないかが判別できる
        if n % 10 == 6 {
            count += 1
        } else {
            count = 0
        }

        if count == 3 {
            break
        }
        n /= 10
    }

    return count == 3 ? true: false
}

//BaekJoon Algorithm Study n.5585 (お釣り)
var N = 1000 - Int(readLine()!)!
//最も大きい基準である500円を優先してコードを作成
// ifで全部繋げるのではなく、else ifでするのが大事
var result = 0

while true {
    if N == 0 {
        break
    }

    if N >= 500 {
        N = N - 500
    } else if N >= 100 {
        N = N - 100
    } else if N >= 50 {
        N = N - 50
    } else if N >= 10 {
        N = N - 10
    } else if N >= 5 {
        N = N - 5
    } else {
        N = N - 1
    }
    result += 1
}
print(result)

//配列を用いた方法
var N = Int(readLine()!)!
var money = 1000 - N
let changeCoins = [500, 100, 50, 10, 5, 1]
var result = 0, index = 0

while money > 0 {
    let count = money / changeCoins[index]
    result += count
    money -= count * changeCoins[index]
    index += 1
}
print(result)

//もっと効率いいコード
// NからchangeCoinsの数字が大きい方を優先して引き算を続ける
// お釣りのcoinの枚数をなるべく少なくしたいから
var N = 1000 - Int(readLine()!)!
let changeCoins = [500, 100, 50, 10, 5, 1]
var count = 0

for coin in changeCoins {
    while N >= coin {
        N -= coin
        count += 1
    }
}
print(count)

//BaekJoon Algorithm Study n.11866 (ヨセプス問題0) 重要度：🎖🎖🎖🎖🎖🎖
//順列問題
// 🔥%演算をうまく活用できるように慣れていこう
//このアルゴリズムをよく覚えて今度活用すること
let N_K = readLine()!.split(separator: " ").map { Int(String($0))! }
let people = N_K[0], the_Num = N_K[1]

var circleArray = Array(1...people)
var count = the_Num - 1

print("<", terminator: "")
while circleArray.count != 1 {
    if count >= circleArray.count {
        count = count % circleArray.count
    }
    
    let target = circleArray.remove(at: count)
    print("\(target),", terminator: " ")
    count += (the_Num - 1)
}

print("\(circleArray[0])>")
