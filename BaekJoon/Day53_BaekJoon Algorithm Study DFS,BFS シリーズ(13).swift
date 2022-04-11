//
//  ss.swift
//  BaekJoon
//
//  Created by Kyus'lee on 2022/04/11.
//

import Foundation

//Day53 DFS,BFS シリーズ(13)
//BaekJoon Algorithm Study n.1389 (Kebin-bacon'sの6段階法則) 重要度: 🎖🎖🎖🎖🎖🎖🎖
//⚠️途中の段階
let data = readLine()!.split(separator: " ").map { Int(String($0))! }
let users = data[0], friendRelations = data[1]
var relations = [[Int]](repeating: [Int](), count: users)
var result = 100
var resultPerson = 0

for _ in 0..<friendRelations {
    let putData = readLine()!.split(separator: " ").map { Int(String($0))! - 1 }
    if !relations[putData[0]].contains(putData[1]) {
        relations[putData[0]].append(putData[1])
        relations[putData[1]].append(putData[0])
    }
}

for i in 0..<users {
    var finalSum = -1
    for j in 0..<users {
        if i == j {
            continue
        } else {
            var visited = [Bool](repeating: false, count: users)
            if !visited[i] {
                dfs_kebinBaconGame(i, j, 1, &finalSum, &visited)
            }
        }
    }
    if result > finalSum {
        result = finalSum
        resultPerson = i + 1
    }
}

print(resultPerson)

func dfs_kebinBaconGame(_ currentPerson: Int, _ targetPerson: Int, _ depth: Int, _ personSum: inout Int, _ check: inout [Bool]) {
    check[currentPerson] = true
    
    if relations[currentPerson].contains(targetPerson) {
        personSum += depth
        return
    } else {
        for i in relations[currentPerson] {
            if !check[i] {
                dfs_kebinBaconGame(i, targetPerson, depth + 1, &personSum, &check)
            }
        }
    }
}
