//
//  Day 28.swift
//  BaekJoon
//
//  Created by Kyus'lee on 2022/03/06.
//

import Foundation

//📝Day 28:  具現問題 (基礎問題　+  深化問題)
//
// 具現 ＋　Brute Force アルゴリズム
//BaekJoon Algorithm Study n.4673 (セルフナンバー)

func find_selfNum(_ num: Int) -> Int {
    var sum = num
    var calculateNum = num

    while num != 0 {
        sum = sum + calculateNum % 10
        calculateNum /= 10

        if calculateNum == 0 {
            break
        }
    }
    return sum
}

var selfNum_storage: Set<Int> = [] // setで処理した理由: setはhashでデータを処理するため、配列より処理時間が早い

for i in 1...10000 {
    selfNum_storage.insert(find_selfNum(i))
}

for i in 1...10000 {
    if !selfNum_storage.contains(i) {
        print(i)
    }
}

//より効率の良いコード
func finding_noSelfNum(_ num: Int) -> Int {
    var calculateNum = num
    var sum = num

    while calculateNum != 0 {
        sum += calculateNum % 10
        calculateNum /= 10
    }

    return sum
}

var selfNum_array = Array(repeating: true, count: 10001)

for i in 1...10000 {
    let number = finding_noSelfNum(i)
    if number <= 10000 {
        selfNum_array[number] = false
    }
}

for i in 1...10000 {
    if selfNum_array[i] {
        print(i)
    }
}

//BaekJoon Algorithm Study n.1292 (解きやすい問題)
let data = readLine()!.split(separator: " ").map { Int(String($0))! }
var sum = 0
var number_array = [0]
var settingNum = 1

while number_array.count <= 1001 {
    number_array += counting(settingNum)
    settingNum += 1
}

for i in data[0]...data[1] {
    sum += number_array[i]
}

print(sum)

func counting(_ num: Int) -> [Int] {
    var add_num = [Int]()

    for _ in 0..<num {
        if number_array.count > 1001 {
            break
        }
        add_num.append(num)
    }

    return add_num
}

//もっと効率いいコード
var arr: [Int] = []
for i in 1..<50 {
    arr.append(contentsOf: [Int](repeating: i, count: i))
}
let input = readLine()!.split(separator: " ").map { Int($0)! - 1 }
print(arr[input[0]...input[1]].reduce(0, +))

//BaekJoon Algorithm Study n.14503 (ロボット掃除機) 重要度:🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖
// SAMSUNGの力量コーディングテスト出題問題
// 難しい　具現問題
// 問題の分析がとても難しかった問題

//方法１:単純 while文を使った方法
// DFSの方法でも解けると思う
let fieldSize = readLine()!.split(separator: " ").map { Int(String($0))! }
let rowSize = fieldSize[0], columnSize = fieldSize[1]
let start_Location = readLine()!.split(separator: " ").map { Int(String($0))! }
var (robotRow, robotColumn) = (start_Location[0], start_Location[1]), directionRobot = start_Location[2]
let direction = [(-1, 0), (0, 1), (1, 0), (0, -1)] //問題で設定された方角を表す数字に合わせて、設定した。
var clean_count = 0

var field = [[Int]]()

for _ in 0..<rowSize {
    field += [readLine()!.split(separator: " ").map { Int(String($0))! }]
}

loop: while true {
    //掃除したところは、0でも１えでもない数字2に変える
    if field[robotRow][robotColumn] == 0 {
        field[robotRow][robotColumn] = 2
        clean_count += 1
    }

    for _ in 0..<4 {
        let checkDirection = directionTurn(directionRobot)

        let (nextRow, nextColumn) = (robotRow + direction[checkDirection].0, robotColumn + direction[checkDirection].1)
        if field[nextRow][nextColumn] == 0 {
            //掃除してないところがあったら、ロボット掃除機の位置を更新する作業をこのif文で行う
            //位置を更新した後、ロボット掃除機の方向も変える
            robotRow = nextRow
            robotColumn = nextColumn
            directionRobot = checkDirection
            continue loop //下記の部分を効率よく省略させるため、While文に naming処理をした
        } else {
            //ロボット掃除機が現在向いている方角の左の方角に壁(1)があったり、もうすでに掃除したところ(2)があったら、ロボット掃除機が向く方向だけを変えて、また、for文を回す
            directionRobot = checkDirection
        }
    }

    //上記のfor文で方向を変えたり、ロボット掃除機の位置を更新し、その向いてる方向の左の方向を掃除する作業をしても、当てはまらない時は後進する
    //ロボット掃除機の位置を後進した座標に変える
    //　つまり、現在ロボット掃除機の位置の回りの全ての方向に壁があるか、もうすでに掃除してるところがあったら、下記の作業をすることになる

    let backMove = (directionRobot + 2) % 4 // 北(0) と 南方向(2)がセット、東(1)　と　西方向(3)がセットであるため
    robotRow = robotRow + direction[backMove].0
    robotColumn = robotColumn + direction[backMove].1

    //ただし、その中でも、これから後進する場所に壁があったら、ロボット掃除機の動作を止めて、このwhile文を抜ける
    if field[robotRow][robotColumn] == 1 {
        break loop
    }
}

//ロボット掃除機が向いてる方向を変える関数
func directionTurn(_ num: Int) -> Int {
    if num == 0 {
        return 3
    } else {
        return num - 1
    }
}

print(clean_count)

//BaekJoon Algorithm Study n.1316 (グループ単語チェック)
//⚠️途中の段階

let word_Case = Int(readLine()!)!
var group_Word_Count = 0

for _ in 0..<word_Case {
    let word = readLine()!
    if isGroupWord(word) {
        group_Word_Count += 1

    }
}

func isGroupWord(_ word: String) -> Bool {
    var check = false
    for i in word {
        let x = i
        for j in i {
            
        }
    }
    
    
    
    return check
}
