//
//  Day 51.swift
//  BaekJoon
//
//  Created by Kyus'lee on 2022/04/09.
//

import Foundation

//Day 51: 具現問題(8)
//BaekJoon Algorithm Study n.14499 (サイコロ転がし) 重要度: 🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖
// 🔥Hard!!考えるのが難しかった問題 🔥

// 1 : 東, 2: 西, 3:　北, 4: 南
//         up
//   left  top  right
//         down
//         botton       のようなサイコロの展開
typealias DiceRoll = (top: Int, bottom: Int, left: Int, right: Int, up: Int, down: Int)
class DiceRule {
    var top = 0, bottom = 0, left = 0, right = 0, up = 0, down = 0

    // command(方向) と　移動した位置の値(value)をパラメータとして受け取る --> この関数は、mapの値とサイコロの値を変える作業を行う関数
    func diceMove(_ command: Int, _ value: Int) -> Int {
        let temp: (DiceRoll) = (top, bottom, left, right, up, down)

        switch command {
        case 1:
            top = temp.left
            left = temp.bottom
            right = temp.top
            bottom = temp.right
        case 2:
            top = temp.right
            left = temp.top
            right = temp.bottom
            bottom = temp.left
        case 3:
            up = temp.top
            top = temp.down
            down = temp.bottom
            bottom = temp.up
        case 4:
            up = temp.bottom
            top = temp.up
            down = temp.top
            bottom = temp.down
        default:
            return value
        }

        print(top)

        if value == 0 {
            // もし、今サイコロが接しているmapの値が0であれば、そのmapの位置の値をサイコロの底の面に格納された値に変える
            return self.bottom
        } else {
            // そうじゃなかったら、サイコロのmapと接している面(サイコロの底の面)がサイコロと接しているmapの位置に格納された値になる
            bottom = value
            return 0 // mapの値を0にさえるため --> 値の変更があったらその位置は0になる(問題文の設定)
        }
    }
}

let dice = DiceRule()
let data = readLine()!.split(separator: " ").map { Int(String($0))! }
let rowSize = data[0], columnSize = data[1]
var diceLocate: (row: Int, column: Int) = (data[2], data[3])
let orderNums = data[4]
var map = [[Int]]()

for _ in 0..<rowSize {
    map += [readLine()!.split(separator: " ").map { Int(String($0))! }]
}
let orderArray = readLine()!.split(separator: " ").map { Int(String($0))! }
var index = 0

while index < orderNums {
    // 1 = 東、 2 = 西, 3 = 北, 4 = 南
    let nextOrder = orderArray[index]

    switch nextOrder {
    case 1:
        if diceLocate.column + 1 < columnSize {
            map[diceLocate.row][diceLocate.column + 1] = dice.diceMove(nextOrder, map[diceLocate.row][diceLocate.column + 1])
            diceLocate.column += 1
        }
    case 2:
        if diceLocate.column - 1 >= 0 {
            map[diceLocate.row][diceLocate.column - 1] = dice.diceMove(nextOrder, map[diceLocate.row][diceLocate.column - 1])
            diceLocate.column -= 1
        }
    case 3:
        if diceLocate.row - 1 >= 0 {
            map[diceLocate.row - 1][diceLocate.column] = dice.diceMove(nextOrder, map[diceLocate.row - 1][diceLocate.column])
            diceLocate.row -= 1
        }
    case 4:
        if diceLocate.row + 1 < rowSize {
            map[diceLocate.row + 1][diceLocate.column] = dice.diceMove(nextOrder, map[diceLocate.row + 1][diceLocate.column])
            diceLocate.row += 1
        }
    default:
        exit(0)
    }

    index += 1
}

// より効率的なコード
typealias DiceRoll = (top: Int, bottom: Int, left: Int, right: Int, up: Int, down: Int)
class DiceRule {
    var top = 0, bottom = 0, left = 0, right = 0, up = 0, down = 0
    
    // command(方向) と　移動した位置の値(value)をパラメータとして受け取る --> この関数は、mapの値とサイコロの値を変える作業を行う関数
    func diceMove(_ command: Int, _ value: Int) -> Int {
        let temp: (DiceRoll) = (top, bottom, left, right, up, down)
        
        switch command {
        case 1:
            top = temp.left
            left = temp.bottom
            right = temp.top
            bottom = temp.right
        case 2:
            top = temp.right
            left = temp.top
            right = temp.bottom
            bottom = temp.left
        case 3:
            up = temp.top
            top = temp.down
            down = temp.bottom
            bottom = temp.up
        case 4:
            up = temp.bottom
            top = temp.up
            down = temp.top
            bottom = temp.down
        default:
            return value
        }
        
        print(top)
        
        if value == 0 {
            // もし、今サイコロが接しているmapの値が0であれば、そのmapの位置の値をサイコロの底の面に格納された値に変える
            return self.bottom
        } else {
            // そうじゃなかったら、サイコロのmapと接している面(サイコロの底の面)がサイコロと接しているmapの位置に格納された値になる
            bottom = value
            return 0 // mapの値を0にさえるため --> 値の変更があったらその位置は0になる(問題文の設定)
        }
    }
}

let dice = DiceRule()
let data = readLine()!.split(separator: " ").map { Int(String($0))! }
let rowSize = data[0], columnSize = data[1]
var diceLocate: (row: Int, column: Int) = (data[2], data[3])
let orderNums = data[4]
var map = [[Int]]()

for _ in 0..<rowSize {
    map += [readLine()!.split(separator: " ").map { Int(String($0))! }]
}
let orderArray = readLine()!.split(separator: " ").map { Int(String($0))! }

orderArray.forEach { order in
    switch order {
    case 1:
        if diceLocate.column + 1 < columnSize {
            map[diceLocate.row][diceLocate.column + 1] = dice.diceMove(order, map[diceLocate.row][diceLocate.column + 1])
            diceLocate.column += 1
        }
    case 2:
        if diceLocate.column - 1 >= 0 {
            map[diceLocate.row][diceLocate.column - 1] = dice.diceMove(order, map[diceLocate.row][diceLocate.column - 1])
            diceLocate.column -= 1
        }
    case 3:
        if diceLocate.row - 1 >= 0 {
            map[diceLocate.row - 1][diceLocate.column] = dice.diceMove(order, map[diceLocate.row - 1][diceLocate.column])
            diceLocate.row -= 1
        }
    case 4:
        if diceLocate.row + 1 < rowSize {
            map[diceLocate.row + 1][diceLocate.column] = dice.diceMove(order, map[diceLocate.row + 1][diceLocate.column])
            diceLocate.row += 1
        }
    default:
        break
    }
}
