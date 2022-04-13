//
//  Day 54.swift
//  BaekJoon
//
//  Created by Kyus'lee on 2022/04/13.
//

import Foundation

//Day54 DFS,BFS シリーズ(13)の完成

//BaekJoon Algorithm Study n.1389 (Kebin-bacon'sの6段階法則) 重要度: 🎖🎖🎖🎖🎖🎖🎖
//BFSを用いた方法
let data = readLine()!.split(separator: " ").map { Int(String($0))! }
let users = data[0], friendRelations = data[1]
var relations = [[Int]](repeating: [Int](), count: users)
var result: (relationCount: Int, personNum: Int) = (98765432, 0)

//友達関係を二重配列に格納する
for _ in 0..<friendRelations {
    let putData = readLine()!.split(separator: " ").map { Int(String($0))! - 1 }
    if !relations[putData[0]].contains(putData[1]) {
        relations[putData[0]].append(putData[1])
        relations[putData[1]].append(putData[0])
    }
}

for i in 0..<users {
    // i + 1 番目の人がすべての人とゲームをして得られる和を求める
    let count = bfs(i)
    if result.relationCount > count {
        result = (count, i + 1)
    }
}
print(result.personNum)

func bfs(_ start: Int) -> Int {
    var neededCheckQueue: [(person: Int, relationStep: Int)] = [(start, 0)]
    var sum = 0
    var visit = [Bool](repeating: false, count: users)
    visit[start] = true
    
    while !neededCheckQueue.isEmpty {
        let removeOne = neededCheckQueue.removeFirst()
        
        for person in relations[removeOne.0] {
            if !visit[person] {
                visit[person] = true
                sum += removeOne.relationStep + 1
                neededCheckQueue.append((person, removeOne.relationStep + 1))
            }
        }
    }
    
    return sum
}

// Floyd-Wharshall (Greedy Algorithm の１つ)を用いた方法
//⚠️途中の段階
