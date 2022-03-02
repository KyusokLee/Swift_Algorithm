//
//  day24.swift
//  BaekJoon
//
//  Created by Kyus'lee on 2022/03/02.
//

import Foundation

//Day 24: 深化問題(1) : 具現問題(1) + BFS問題
//BaekJoon Algorithm Study n.7576 (トマト) Fisrt Gold Rate! 重要度:🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖
// 📮🌈やっと、ゴールドの等級の問題を解くようになった.. これからも精進していこう！🥰
// 🔥Very Hard🔥
// 🌈📮考察：今回の問題は、これまで解いた問題とは少し違くて、同時に回すことがkey pointだった。
//         また、どのように先に設計するかによって効率的なコードの作成ができることにきづいた
//         問題をどのように分析し、設計するかに時間を注ぐことは非常に重要である。
//🔥🔥問題の設計をどのようにするかを深く考えること

let boxSize = readLine()!.split(separator: " ").map { Int(String($0))! }
let columnSize = boxSize[0], rowSize = boxSize[1]
var boxData = [[Int]]()
var neededVisitQueue = [((Int, Int), Int)]()
var isRipenedBox = true
let directionRow = [0, 0, -1, 1]
let directionColumn = [1, -1, 0, 0]
var result_Day = 0

// ボックスに入るトマトのデータ入力(熟れたかないか)
for _ in 0..<rowSize {
    let tomatoes = readLine()!.split(separator: " ").map { Int(String($0))! }
    boxData += [tomatoes]
}

for i in 0..<rowSize {
    for j in 0..<columnSize {
        if boxData[i][j] == 1 {
            // 熟れたトマトがあるところから同時に回すために、neededVisitQueueに格納しておく
            neededVisitQueue.append(((i, j), 0))
        }
    }
}

// bfsを何回も回す必要はなく、bfs探索をすると、求めようとする最短、もしくは最小の値が求められる
bfs_CountDay()
//探索実施
loop: for i in 0..<rowSize {
    for j in 0..<columnSize {
        if boxData[i][j] == 0 {
            isRipenedBox = false
            break loop
        }
    }
}

if isRipenedBox {
    print(result_Day)
} else {
    print(-1)
}

func bfs_CountDay() {
    var dayCount = 0, index = 0

    while index < neededVisitQueue.count {
        let ((currentRow, currentColumn), day) = neededVisitQueue[index]

        for i in 0..<4 {
            let nextRow = currentRow + directionRow[i]
            let nextColumn = currentColumn + directionColumn[i]

            if (0 <= nextRow && nextRow < rowSize) && (0 <= nextColumn && nextColumn < columnSize) {
                if boxData[nextRow][nextColumn] == 0 {
                    neededVisitQueue.append(((nextRow, nextColumn), day + 1))
                    boxData[nextRow][nextColumn] = 1
                }
            }
        }
        index += 1
        dayCount = day
    }

    result_Day = dayCount
}

// ⚠️Baek Joon IDEに出してみたら、パスできなかった。。なんらかの反例があると思う
//for i in 0..<rowSize {
//    for j in 0..<columnSize {
//        if boxData[i][j] == -1 {
//            haveTomato[i][j] = false // -1があるとこは、トマトがないとこ
//            visited[i][j] = true //トマトがないとこを既に訪問したと仮定することで、トマトがないとこに訪問することを先に防ぐ
//        }
//    }
//}

//BaekJoon Algorithm Study n.15686 (チキン配達) 重要度：🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖
// ‼️🔥Very Difficult 🔥
// ⚠️途中の段階

let data = readLine()!.split(separator: " ").map { Int(String($0))! }
let citySize = data[0], notClosed = data[1]
// チキンのお店の中、最大　notClosedの個を選ぶってこと
// カードゲームと似たようなアルゴリズム

var cityData = [[Int]]()
var chickenDistace = [[Int]]()
var currentChickenHouse = [(Int, Int)]() //チキンのお店の座標だけを格納した配列
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
            currentChickenHouse.append((i + 1, j + 1))
        } else if cityData[i][j] == 1 {
            houses.append((i + 1, j + 1))
        }
    }
}

select([currentChickenHouse[0]], 1)
print(min_AllDistance)
//🔥⚠️組み合わせのアルゴリズム : 再帰関数を用いるコード
func select(_ selected: [(Int, Int)], _ index: Int) {
    if selected.count == notClosed {
        min_AllDistance = min(min_AllDistance, count_AllCityDistance(selected))
    } else {
        for i in index..<currentChickenHouse.count {
            select(selected + [currentChickenHouse[i]], i + 1)
            // 例えば、count = 5であり、i + 1が5になったと仮定する。その時、countより小さくないから、ここのfor文に入ることはない
        }
    }
}

//全体の距離を足す関数
func count_AllCityDistance(_ selectedChickens: [(Int, Int)]) -> Int {
    var allDistance = 0
    for house in houses {
        var minDistance = 987654321
        for chickenHouse in selectedChickens {
            let distance = countingDistance(house, chickenHouse)
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
