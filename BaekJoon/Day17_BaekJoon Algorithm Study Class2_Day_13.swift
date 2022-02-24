//
//  day 17.swift
//  BaekJoon
//
//  Created by Kyus'lee on 2022/02/23.
//

import Foundation

//Day 17: DFS, BFSのアルゴリズムの整理と問題 (5)
//BaekJoon Algorithm Study n.1697 (隠れんぼ)　問題等級：Silver 1　重要度：🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖
//最短経路を求めるのと同じだから、BFS探索が望ましい
// ⚠️❗️🎖 DIFFICULT  かなり難しい問題 🎖
// ⚠️‼️途中の段階

//‼️このようにすると、答えは出るが、Runtime Error!になってしまった
let location_data = readLine()!.split(separator: " ").map { Int(String($0))! }
let subin = location_data[0]
let sister = location_data[1]
var currentVisitQueue: [(Int, Int)] = [(subin, 0)] //現在のsubinの位置から移動できる３つの位置候補を入れていく

print(BFS_findSister(currentLocation: subin, destination: sister))

func BFS_findSister(currentLocation: Int, destination: Int) -> Int {
    if currentLocation == destination {
        print(0)
        exit(0)
    }

    //問題で0 <= subin, sister <= 100000だと指定したため
    var visited = [Bool](repeating: false, count: 100001)
    var idx = 0
    var isFound = false
    var time_result = 0

    while true {
        // Tuple Decomposition 文法
        let (currentVisit, time) = currentVisitQueue[idx]
        idx += 1
        var nextVisit = 0

        for i in 0..<3 {
            if i == 0 { nextVisit = currentVisit - 1 }
            else if i == 1 { nextVisit = currentVisit + 1 }
            else { nextVisit = currentVisit * 2 }

            //問題で与えられる現在の位置は 0 <= subin, sister <= 100000だと指定したため
            if nextVisit < 0 || nextVisit > 100000 || visited[nextVisit] {
                continue
            }

            if nextVisit == destination {
                isFound = true
                time_result = currentVisitQueue[idx].1 + 1
                break
            }

            visited[nextVisit] = true
            currentVisitQueue.append((nextVisit, time + 1))
        }

        if isFound {
            break
        }
    }

    return time_result
}

//Run Time Error が出ないような他の方法
//方法２：関数の呼び出しを使わない方法
// この方法もRun Time Error がでちゃった

let read_location = readLine()!.split(separator: " ").map { Int(String($0))! }
let subin = read_location[0]
let sister = read_location[1]
var visited = [Bool](repeating: false, count: 100001)
var currentVisitQueue: [(Int, Int)] = [(subin, 0)]
var index = 0
var isFound = false

visited[subin] = true

if subin == sister {
    print(0)
} else {
    while true {
        let (currentVisit, time) = currentVisitQueue[index]
        index += 1
        var nextVisit = 0

        for i in 0..<3 {
            if i == 0 { nextVisit = currentVisit - 1 }
            else if i == 1 { nextVisit = currentVisit + 1 }
            else { nextVisit = currentVisit * 2 }

            if nextVisit < 0 || nextVisit > 100001 || visited[nextVisit] {
                continue
            }

            if nextVisit == sister {
                isFound = true
                break
            }
            visited[nextVisit] = true
            currentVisitQueue.append((nextVisit, time + 1))
        }
        if isFound {
            print(time + 1)
            break
        }
    }
}

//方法3: 通貨はしたけど、処理時間が長かった
struct Queue{
    var que: [Int] = []
    mutating func push(_ x: Int) {
        que.append(x)
    }
    mutating func pop() -> Int {
        que.reverse()
        if let a = que.popLast() {
            que.reverse()
            return a
        }
        return 0
    }
    func empty() -> Bool {
        return que.isEmpty
    }
    func size() -> Int{
        return que.count
    }
}

func bfs(_ n: Int, _ k: Int) -> Int {
    var queue = Queue()
    queue.push(n)

    while !queue.empty() {
        let data = queue.pop()
        if data == k {
            break
        }
        if data > 0 && !visited[data - 1] {
            queue.push(data - 1)
            visited[data - 1] = true
            depth[data - 1] = depth[data] + 1
        }
        if data < 100000 && !visited[data + 1] {
            queue.push(data + 1)
            visited[data + 1] = true
            depth[data + 1] = depth[data] + 1
        }
        if data * 2 < 100001 && !visited[2 * data] {
            queue.push(2 * data)
            visited[2 * data] = true
            depth[data * 2] = depth[data] + 1
        }
    }
    return depth[k]
}

let arr = readLine()!.split(separator: " ").map{Int(String($0))!}
let n = arr[0]
let k = arr[1]
var visited: [Bool] = Array(repeating: false, count: 100001)
var depth: [Int] = Array(repeating: 0, count: 100001)
let result = bfs(n, k)
print(result)

//⭕️‼️方法4: 他の人のコードを参考し、勉強したコード
//⭐️⚠️ちゃんと自分のスキルにすること
let read_location = readLine()!.split(separator: " ").map { Int(String($0))! }
let subin = read_location[0], sister = read_location[1]

print(bfs_findSister(nowLocation: subin, Target: sister))

func bfs_findSister(nowLocation: Int, Target: Int) -> Int {
    var possibleVisit = [(nowLocation, 0)]
    var visited = [Bool](repeating: false, count: 100001)
    var index = 0
    let result = 0

    //while true よりは確実に数が減る。。。理由：ある時間に至ると、もうすでに訪問したことがある選択肢が与えられ、possibleVisitに追加できる要素がだんだん減っていくためである

    while index < possibleVisit.count {
        let (currentVisit, time) = possibleVisit[index]

        //順序に time + 1をしながら訪問したことない拠点を追加していく。その拠点がsisterがいる所であるか否かは追加した後、indexが一個増えた状態で行った方が Run Time Errorも効率的に防げるし、コードも簡潔になる
        // つまり、possibleVisit上の各 Tuple要素のtimeは昇順になっているため、sisterがいるところに着いた時間は自動的に最短時間となる
        if currentVisit == Target {
            return time
        }

        let selectWay = [currentVisit - 1, currentVisit + 1, 2 * currentVisit]

        for nextVisit in selectWay {
            if 0 <= nextVisit && nextVisit <= 100000 && !visited[nextVisit] {
                visited[nextVisit] = true
                possibleVisit.append((nextVisit, time + 1))
            }
        }
        index += 1
    }

    return result
}

//BaekJoon Algorithm Study n.2644 (親等計算) 重要度：🎖🎖🎖🎖🎖
//DFSを用いた解き方
//入力された数字の中、数字が大きい方が親になることは不可能である

let peopleNum = Int(readLine()!)!
let resultRelation = readLine()!.split(separator: " ").map { Int(String($0))! }
let person1 = resultRelation[0], person2 = resultRelation[1]
let linkCount = Int(readLine()!)!
var people_Link = [Int :[Int]]()
var countArray = [Int](repeating: 0, count: peopleNum + 1)

for i in 1...peopleNum {
    people_Link[i] = []
}

for _ in 0..<linkCount {
    let put_Link = readLine()!.split(separator: " ").map { Int(String($0))! }
    people_Link[put_Link[0]]!.append(put_Link[1])
    people_Link[put_Link[1]]!.append(put_Link[0])
}

func dfs_CountRelation(compare: Int) {

    for i in people_Link[compare]! {
        if countArray[i] > 0 { continue }
        countArray[i] = countArray[compare] + 1

        if i == person2 { return }
        dfs_CountRelation(compare: i)
    }
}

countArray[person1] = 1
dfs_CountRelation(compare: person1)
print(countArray[person2] - 1)

//⭕️BFSを用いた解き方
let peopleNum2 = Int(readLine()!)!
let put_compare = readLine()!.split(separator: " ").map { Int(String($0))! }
let compareA = put_compare[0], compareB = put_compare[1]
let links = Int(readLine()!)!
var personLink = [Int: [Int]]()

for i in 1...peopleNum2 {
    personLink[i] = []
}

for _ in 0..<links {
    let link = readLine()!.split(separator: " ").map { Int(String($0))! }
    personLink[link[0]]!.append(link[1])
    personLink[link[1]]!.append(link[0])
}

print(bfs_CountRelation(personA: compareA, personB: compareB))

func bfs_CountRelation(personA: Int, personB: Int) -> Int {
    var checked = [Bool](repeating: false , count: peopleNum + 1)
    var canCheck: [(Int, Int)] = [(compareA, 0)]
    var index = 0

    checked[personA] = true

    while index < canCheck.count {
        let (currentCheck, relationCount) = canCheck[index]
        if currentCheck == personB {
            return relationCount
        }

        for i in personLink[currentCheck]! {
            if !checked[i] {
                checked[i] = true
                canCheck.append((i, relationCount + 1))
            }
        }
        index += 1
    }

    return -1
}

//BaekJoon Algorithm Study n.2468 (安全な領域) 重要度：🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖
//連結要素を求めるアルゴリズムを活用したコード
// コードはいい感じだと思うけど、なぜか値がおかしくなっている
// ⚠️‼️途中の段階

let district_size = Int(readLine()!)!
var area_data = [[Int]]()
var rain_size = 0
let directionColumn = [1, -1, 0, 0] //列の移動: 東西南北
let directionRow = [0, 0, -1, 1] //行の移動: 東西南北
var areaMax_height = 0
var safeArea_maxCount = 0

for _ in 0..<district_size {
    let put_data = readLine()!.split(separator: " ").map { Int(String($0))! }
    area_data.append(put_data)
    if areaMax_height < put_data.max()! {
        areaMax_height = put_data.max()!
    }
}

for _ in 0..<areaMax_height {
    Count_SafeArea(district: district_size, rainLevel: rain_size)
    print(safeArea_maxCount)
    rain_size += 1
}
//print(safeArea_maxCount)

func Count_SafeArea(district: Int, rainLevel: Int) {
    var linked = [[Bool]](repeating: Array(repeating: false, count: district), count: district)
    var isRainArea = [[Bool]](repeating: Array(repeating: false, count: district), count: district)
    var area_Count = 0
    
    //雨の量による浸水した地域設定
    for i in 0..<district {
        for j in 0..<district {
            if area_data[i][j] <= rainLevel {
                isRainArea[i][j] = true
            }
        }
    }
    
    if isRainArea == [[false]] {
        safeArea_maxCount = 1
        return
    } else {
        for i in 0..<district {
            for j in 0..<district {
                if !isRainArea[i][j] && !linked[i][j] {
                    print("現在のarea_Count: \(area_Count)")
                    area_Count += 1
                    dfs(startRow: i, startColumn: j)
                } else {
                    continue
                }
            }
        }
        
        if safeArea_maxCount < area_Count {
            safeArea_maxCount = area_Count
        }
    }
    
//    //‼️⚠️この書き方だと、全部浸水していなくても、このloopに入ってしまい、求めようとする値とは違う値が出てしまう
//    for i in 0..<district {
//        for j in 0..<district {
//            if !isRainArea[i][j] && !linked[i][j] {
//                print("現在のarea_Count: \(area_Count)")
//                area_Count += 1
//                dfs(startRow: i, startColumn: j)
//            }
//        }
//    }
    
    func dfs(startRow: Int, startColumn: Int) {
        linked[startRow][startColumn] = true
        
        for i in 0..<3 {
            let nextRow = startRow + directionRow[i]
            let nextColumn = startColumn + directionColumn[i]
            
            if (0 <= nextRow && nextRow <= district - 1) && (0 <= nextColumn && nextColumn <= district - 1) {
                if !isRainArea[nextRow][nextColumn] && !linked[nextRow][nextColumn] {
                    dfs(startRow: nextRow, startColumn: nextColumn)
                }
            }
        }
    }
    
}
