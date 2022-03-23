//
//  Day37.swift
//  BaekJoon
//
//  Created by Kyus'lee on 2022/03/23.
//

import Foundation

// 📝Day37: DFS、BFS シリーズ (4) + 最長部分数列(LIS)アルゴリズム

//BaekJoon Algorithm Study n.1965 (箱を入れよう) 重要度: 🎖🎖🎖🎖🎖🎖🎖
// DP + LIS(最長増加部分数列)アルゴリズム
//LIS(Longest Increasing Subsequence) : 部分的に増加する数列の中、最も長いものを探すアルゴリズム
//        🔥簡単に言えば、「小さい値 -> 大きい値」 に至る、繋げられる最大の個数を求めることである🔥
// 例: [1, 6, 2, 5, 7, 3, 5, 6]の場合
//     1 -> 6
//     1 -> 2 -> 5 -> 7
//     1 -> 2 -> 3 -> 5 -> 6   つまり、max: 5


let boxes = Int(readLine()!)!
let boxLine = readLine()!.split(separator: " ").map { Int(String($0))! }
var count = [Int]()
var max = 1

for i in 0..<boxes {
    count.append(1)

    for j in 0..<count.count {
        if boxLine[j] < boxLine[i] && count[i] <= count[j] {
            count[i] = count[j] + 1
        }
    }

    if max < count[i] {
        max = count[i]
    }

}

print(max)

//BaekJoon Algorithm Study n.16236 (Baby Shark) 重要度: 🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖
//　初の Gold Rank. 3　難易度の問題
// ‼️Very Hard‼️
// 🔥📚必ず、使いこなせるようにアルゴリズムの設計をちゃんと分析及び復習すること！！！🔥

//９があるマスが、赤ちゃんサメがいる場所。　赤ちゃんサメの大きさは、最初は2に固定(初期値)
// 0は、空のマス
// 1, 2, 3, 4, 5, 6　マスにいる魚の大きさ 7と8はない

let mapSize = Int(readLine()!)!
var map = [[Int]]()
let directionRow = [0, 0, 1, -1]
let directionColumn = [1, -1, 0, 0]
var sharkLocate = (-1, -1, -1)
var result = 0
var eatCount = 0

//データの入力後、スタート時点(9のところ)を０に変える
for i in 0..<mapSize {
    let mapData = readLine()!.split(separator: " ").map { Int(String($0))! }
    map += [mapData]

    if let j = mapData.firstIndex(of: 9) {
        sharkLocate = (i, j, 2)
        map[i][j] = 0
    }
}

while true {
    if !bfs_sharkMoving() {
        print(result)
        break
    }
}

//⚠️注意:魚を一個食べるたびに、赤ちゃんサメの現在位置が更新されるため、この関数を呼び出すたびに、近い距離にある魚は異なる
func bfs_sharkMoving() -> Bool {
    var fishArray = [(Int, Int)]()
    var index = 0
    var neededCheckQueue = [(sharkLocate.0, sharkLocate.1, 0)]
    var visited = Array(repeating: Array(repeating: false, count: mapSize), count: mapSize)
    var distance = 98765432
    visited[sharkLocate.0][sharkLocate.1] = true

    while index < neededCheckQueue.count {
        let (currentRow, currentColumn, distanceCount) = neededCheckQueue[index]
        //⚠️indexの位置がとても重要！！ -> 理由: 下記の if distanceCount > distance の文がcontinueされるため、continue文の上に記入する必要がある
        //もし、いつも私が作成したようにwhile文の一番下に書く場合、indexは増えずwhile文だけが繰り返されるため、break文に至らない
        index += 1
        //距離が同じ場合と既存の距離より小さい時だけ、このif文を省略できるようにする
        if distanceCount > distance {
            continue
        }

        if (1..<sharkLocate.2).contains(map[currentRow][currentColumn]) {
            distance = distanceCount
            fishArray.append((currentRow, currentColumn))
        }

        for i in 0..<4 {
            let nextRow = currentRow + directionRow[i]
            let nextColumn = currentColumn + directionColumn[i]

            if nextRow < 0 || nextRow >= mapSize || nextColumn < 0 || nextColumn >= mapSize {
                continue
            }

            if 0 <= map[nextRow][nextColumn] && map[nextRow][nextColumn] <= sharkLocate.2 && !visited[nextRow][nextColumn] {
                visited[nextRow][nextColumn] = true
                neededCheckQueue.append((nextRow, nextColumn, distanceCount + 1))
            }
        }
    }

    //食べれる魚がなかったら、関数がfalseをreturnし、関数を終了する
    if fishArray.isEmpty {
        return false
    }

    //赤ちゃんサメの現在位置から、最も近い距離に複数の候補がある場合、同じ行であれば一番左のマスにいる魚を、同じ行にある魚じゃない場合、なるべく上の行にある魚を食べる(問題の設定)
    //同じ距離に食べれる魚が複数ある場合、row(行)を優先、その後が、column(列)　（問題文の要求事項）
    fishArray.sort {
        if $0.0 == $1.0 {
            return $0.1 < $1.1
        }
        return $0.0 < $1.0
    }

    let targetFish = fishArray.first!
    eatCount += 1

    if eatCount == sharkLocate.2 {
        sharkLocate.2 += 1
        eatCount = 0
    }

    map[targetFish.0][targetFish.1] = 0
    sharkLocate = (targetFish.0, targetFish.1, sharkLocate.2)

    result += distance
    return true
}

//🔥以前に書いたコード
let mapSize = Int(readLine()!)!
var map = [[Int]]()
let directionRow = [0, 0, 1, -1]
let directionColumn = [1, -1, 0, 0]
var sharkLocate = (-1, -1, -1)
var result = 0
var eatCount = 0

for i in 0..<mapSize {
    let mapData = readLine()!.split(separator: " ").map { Int(String($0))! }
    map += [mapData]

    if let j = mapData.firstIndex(of: 9) {
        sharkLocate = (i, j, 2)
        map[i][j] = 0
    }
}

while true {
    if !bfs_sharkMoving(sharkLocate.0, sharkLocate.1, sharkLocate.2) {
        print(result)
        break
    }
}

func bfs_sharkMoving(_ rowStart: Int, _ columnStart: Int, _ size: Int) -> Bool {
    var fishArray = [(Int, Int)]()
    var index = 0
    var neededCheckQueue: [(row: Int, column: Int, moveStack: Int)] = [(rowStart, columnStart, 0)]
    var visited = Array(repeating: Array(repeating: false, count: mapSize), count: mapSize)
    var distance = 98765432
    visited[rowStart][columnStart] = true

    while index < neededCheckQueue.count {
        let (currentRow, currentColumn, distanceCount) = neededCheckQueue[index]
        index += 1

        if distanceCount > distance {
            continue
        }

        if (1..<size).contains(map[currentRow][currentColumn]) {
            distance = distanceCount
            fishArray.append((currentRow, currentColumn))
        }

        for i in 0..<4 {
            let nextRow = currentRow + directionRow[i]
            let nextColumn = currentColumn + directionColumn[i]

            if nextRow < 0 || nextRow >= mapSize || nextColumn < 0 || nextColumn >= mapSize || map[nextRow][nextColumn] > size || visited[nextRow][nextColumn] {
                continue
            }

            visited[nextRow][nextColumn] = true
            neededCheckQueue.append((nextRow, nextColumn, distanceCount + 1))
        }
    }

    if fishArray.isEmpty {
        return false
    }

    //赤ちゃんサメの現在位置から、最も近い距離に複数の候補がある場合、同じ行であれば一番左のマスにいる魚を、同じ行にある魚じゃない場合、一番上の行の魚を食べる(問題の設定)
    fishArray.sort {
        if $0.0 == $1.0 {
            return $0.1 < $1.1
        }
        return $0.0 < $1.0
    }

    let targetFish = fishArray.first!
    eatCount += 1

    if eatCount == size {
        sharkLocate.2 += 1
        eatCount = 0
    }

    map[targetFish.0][targetFish.1] = 0
    sharkLocate = (targetFish.0, targetFish.1, sharkLocate.2)

    result += distance

    return true
}

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
