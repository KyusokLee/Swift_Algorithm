//
//  Day37.swift
//  BaekJoon
//
//  Created by Kyus'lee on 2022/03/23.
//

import Foundation

// ๐Day37: DFSใBFS ใทใชใผใบ (4) + ๆ้ท้จๅๆฐๅ(LIS)ใขใซใดใชใบใ 

//BaekJoon Algorithm Study n.1965 (็ฎฑใๅฅใใใ) ้่ฆๅบฆ: ๐๐๐๐๐๐๐
// DP + LIS(ๆ้ทๅขๅ ้จๅๆฐๅ)ใขใซใดใชใบใ 
//LIS(Longest Increasing Subsequence) : ้จๅ็ใซๅขๅ ใใๆฐๅใฎไธญใๆใ้ทใใใฎใๆขใใขใซใดใชใบใ 
//        ๐ฅ็ฐกๅใซ่จใใฐใใๅฐใใๅค -> ๅคงใใๅคใ ใซ่ณใใ็นใใใใๆๅคงใฎๅๆฐใๆฑใใใใจใงใใ๐ฅ
// ไพ: [1, 6, 2, 5, 7, 3, 5, 6]ใฎๅ ดๅ
//     1 -> 6
//     1 -> 2 -> 5 -> 7
//     1 -> 2 -> 3 -> 5 -> 6   ใคใพใใmax: 5


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

//BaekJoon Algorithm Study n.16236 (Baby Shark) ้่ฆๅบฆ: ๐๐๐๐๐๐๐๐๐๐๐
//ใๅใฎ Gold Rank. 3ใ้ฃๆๅบฆใฎๅ้ก
// โผ๏ธVery Hardโผ๏ธ
// ๐ฅ๐ๅฟใใไฝฟใใใชใใใใใซใขใซใดใชใบใ ใฎ่จญ่จใใกใใใจๅๆๅใณๅพฉ็ฟใใใใจ๏ผ๏ผ๏ผ๐ฅ

//๏ผใใใใในใใ่ตคใกใใใตใกใใใๅ ดๆใใ่ตคใกใใใตใกใฎๅคงใใใฏใๆๅใฏ2ใซๅบๅฎ(ๅๆๅค)
// 0ใฏใ็ฉบใฎใใน
// 1, 2, 3, 4, 5, 6ใใในใซใใ้ญใฎๅคงใใ 7ใจ8ใฏใชใ

let mapSize = Int(readLine()!)!
var map = [[Int]]()
let directionRow = [0, 0, 1, -1]
let directionColumn = [1, -1, 0, 0]
var sharkLocate = (-1, -1, -1)
var result = 0
var eatCount = 0

//ใใผใฟใฎๅฅๅๅพใในใฟใผใๆ็น(9ใฎใจใใ)ใ๏ผใซๅคใใ
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

//โ ๏ธๆณจๆ:้ญใไธๅ้ฃในใใใณใซใ่ตคใกใใใตใกใฎ็พๅจไฝ็ฝฎใๆดๆฐใใใใใใใใฎ้ขๆฐใๅผใณๅบใใใณใซใ่ฟใ่ท้ขใซใใ้ญใฏ็ฐใชใ
func bfs_sharkMoving() -> Bool {
    var fishArray = [(Int, Int)]()
    var index = 0
    var neededCheckQueue = [(sharkLocate.0, sharkLocate.1, 0)]
    var visited = Array(repeating: Array(repeating: false, count: mapSize), count: mapSize)
    var distance = 98765432
    visited[sharkLocate.0][sharkLocate.1] = true

    while index < neededCheckQueue.count {
        let (currentRow, currentColumn, distanceCount) = neededCheckQueue[index]
        //โ ๏ธindexใฎไฝ็ฝฎใใจใฆใ้่ฆ๏ผ๏ผ -> ็็ฑ: ไธ่จใฎ if distanceCount > distance ใฎๆใcontinueใใใใใใcontinueๆใฎไธใซ่จๅฅใใๅฟ่ฆใใใ
        //ใใใใใคใ็งใไฝๆใใใใใซwhileๆใฎไธ็ชไธใซๆธใๅ ดๅใindexใฏๅขใใwhileๆใ ใใ็นฐใ่ฟใใใใใใbreakๆใซ่ณใใชใ
        index += 1
        //่ท้ขใๅใๅ ดๅใจๆขๅญใฎ่ท้ขใใๅฐใใๆใ ใใใใฎifๆใ็็ฅใงใใใใใซใใ
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

    //้ฃในใใ้ญใใชใใฃใใใ้ขๆฐใfalseใreturnใใ้ขๆฐใ็ตไบใใ
    if fishArray.isEmpty {
        return false
    }

    //่ตคใกใใใตใกใฎ็พๅจไฝ็ฝฎใใใๆใ่ฟใ่ท้ขใซ่คๆฐใฎๅ่ฃใใใๅ ดๅใๅใ่กใงใใใฐไธ็ชๅทฆใฎใในใซใใ้ญใใๅใ่กใซใใ้ญใใใชใๅ ดๅใใชใในใไธใฎ่กใซใใ้ญใ้ฃในใ(ๅ้กใฎ่จญๅฎ)
    //ๅใ่ท้ขใซ้ฃในใใ้ญใ่คๆฐใใๅ ดๅใrow(่ก)ใๅชๅใใใฎๅพใใcolumn(ๅ)ใ๏ผๅ้กๆใฎ่ฆๆฑไบ้ ๏ผ
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

//๐ฅไปฅๅใซๆธใใใณใผใ
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

    //่ตคใกใใใตใกใฎ็พๅจไฝ็ฝฎใใใๆใ่ฟใ่ท้ขใซ่คๆฐใฎๅ่ฃใใใๅ ดๅใๅใ่กใงใใใฐไธ็ชๅทฆใฎใในใซใใ้ญใใๅใ่กใซใใ้ญใใใชใๅ ดๅใไธ็ชไธใฎ่กใฎ้ญใ้ฃในใ(ๅ้กใฎ่จญๅฎ)
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

//BaekJoon Algorithm Study n.7569 (ใใใ)ใ้่ฆๅบฆ:๐๐๐๐๐๐๐๐๐๐๐๐
//โ ๏ธ้ไธญใฎๆฎต้โ ๏ธ

let data = readLine()!.split(separator: " ").map { Int(String($0))! }
let columnSize = data[0], rowSize = data[1], heightSize = data[2]
var field = [[[Int]]](repeating: [[Int]](repeating: [Int](), count: rowSize), count: heightSize)
let directionRow = [0, 0, 1, -1]      //ๆฑ่ฅฟๅๅ
let directionColumn = [1, -1, 0, 0]   //ๆฑ่ฅฟๅๅ
let directionHeight = [1, 0, -1]         //ไธไธ
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
