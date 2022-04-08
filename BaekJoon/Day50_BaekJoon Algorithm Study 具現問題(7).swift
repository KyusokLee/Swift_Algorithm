//
//  Day50.swift
//  BaekJoon
//
//  Created by Kyus'lee on 2022/04/08.
//

import Foundation

//Day 50: 具現問題(7)

//BaekJoon Algorithm Study n.3190 (ヘビ) 重要度: 🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖
// 具現・シミュレーション問題
// ヘビの移動のルール
// step1. まず、自分の体の長さを伸ばして頭を次のマスに位置させる
// step2. もし、移動したマスにAppleがあったら、そのマスにあったAppleがなくなり、ヘビの尻尾は動かない
// step3. もし、移動したマスにAppleがなかったら、体の長さを減らして尻尾があったマスを空にする

// 結果: このゲームが何秒に終わるかを計算する -->> 壁にぶつかったり、自分自身の体とぶつかったらゲーム終了となる

typealias Order = (timePassed: Int, command: Character)
let mapSize = Int(readLine()!)!
let appleCount = Int(readLine()!)!
var orderArray = [Order]()
var appleLocate: [(row: Int, column: Int)] = []
let directionWay = [(0, 1), (-1, 0), (0, -1), (1, 0)] //right, up, left, down //0 , 1, 2, 3
var currentDirection = 0 // 最初がヘビが右に進むから　direction[0]を実行するようにする
var result = 0
var visitedQueue: [(Int, Int)] = []

for _ in 0..<appleCount {
    let putApple = readLine()!.split(separator: " ").map { Int(String($0))! }
    appleLocate.append((putApple[0] - 1, putApple[1] - 1))
}

let snakeOrder = Int(readLine()!)!
for _ in 0..<snakeOrder {
    let putOrder = readLine()!.split(separator: " ").map { String($0) }
    orderArray.append((Int(putOrder[0])!, Character(putOrder[1])))
}

visitedQueue.append((0, 0))
snakeMove(0, 0, 0)
print(result)

//Queueの追加、削除をうまく操作すること
func snakeMove(_ row: Int, _ column: Int, _ time: Int) {
    if !orderArray.isEmpty {
        if time == orderArray.first!.timePassed {
            let orderChange = orderArray.removeFirst()
            currentDirection = directionChange(orderChange.command, currentDirection)
        }
    }

    let (nextRow, nextColumn) = (row + directionWay[currentDirection].0, column + directionWay[currentDirection].1)
    if nextRow < 0 || nextRow >= mapSize || nextColumn < 0 || nextColumn >= mapSize || visitedQueue.contains(where: { $0 == (nextRow, nextColumn) }) {
        result = time + 1
        return
    } else {
        if checkApple(nextRow, nextColumn) {
            visitedQueue.append((nextRow, nextColumn))
            snakeMove(nextRow, nextColumn, time + 1)
        } else {
            visitedQueue.removeFirst()
            visitedQueue.append((nextRow, nextColumn))
            snakeMove(nextRow, nextColumn, time + 1)
        }
    }

}
// 🌱数字でこれから進む方向を指定した方が効率的かなと思う
// Okay
func directionChange(_ order: Character, _ curDirection: Int) -> Int {
    var newDirection = 0
    if order == "L" {
        newDirection = (curDirection + 1) % 4
    } else if order == "D" {
        newDirection = (curDirection + 3) % 4
    }

    return newDirection
}

func checkApple(_ row: Int, _ column: Int) -> Bool {
    if !appleLocate.isEmpty {
        for i in 0..<appleLocate.count {
            if (row, column) == (appleLocate[i].0, appleLocate[i].1) {
                appleLocate.remove(at: i)
                return true
            }
        }
    }
    return false
}

//BaekJoon Algorithm Study n.14499 (サイコロ転がし) 重要度: 🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖
// ⚠️途中の段階

let data = readLine()!.split(separator: " ").map { Int(String($0))! }
let rowSize = data[0], columnSize = data[1], diceStartLocate = (data[2], data[3])
var orderNums = data[4]
var map = [[Int]]()
let directionMove = [(0, 1), (0, -1), (-1, 0), (1, 0)] // 東西北南　(問題文の設定)
var dice = [0, 0, 0, 0, 0, 0] // 上、前、右、裏、左、下
var currentDirection = 0

for _ in 0..<rowSize {
    map += [readLine()!.split(separator: " ").map { Int(String($0))! }]
}
let orderArray = readLine()!.split(separator: " ").map { Int(String($0))! }




func diceMove(_ row: Int, _ column: Int) {
    
}
