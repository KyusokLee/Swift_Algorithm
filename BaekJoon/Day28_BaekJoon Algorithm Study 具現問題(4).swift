//
//  Day 28.swift
//  BaekJoon
//
//  Created by Kyus'lee on 2022/03/06.
//

import Foundation

//๐Day 28:  ๅท็พๅ้ก (ๅบ็คๅ้กใ+  ๆทฑๅๅ้ก)
//
// ๅท็พ ๏ผใBrute Force ใขใซใดใชใบใ 
//BaekJoon Algorithm Study n.4673 (ใปใซใใใณใใผ)

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

var selfNum_storage: Set<Int> = [] // setใงๅฆ็ใใ็็ฑ: setใฏhashใงใใผใฟใๅฆ็ใใใใใ้ๅใใๅฆ็ๆ้ใๆฉใ

for i in 1...10000 {
    selfNum_storage.insert(find_selfNum(i))
}

for i in 1...10000 {
    if !selfNum_storage.contains(i) {
        print(i)
    }
}

//ใใๅน็ใฎ่ฏใใณใผใ
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

//BaekJoon Algorithm Study n.1292 (่งฃใใใใๅ้ก)
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

//ใใฃใจๅน็ใใใณใผใ
var arr: [Int] = []
for i in 1..<50 {
    arr.append(contentsOf: [Int](repeating: i, count: i))
}
let input = readLine()!.split(separator: " ").map { Int($0)! - 1 }
print(arr[input[0]...input[1]].reduce(0, +))

//BaekJoon Algorithm Study n.14503 (ใญใใใๆ้คๆฉ) ้่ฆๅบฆ:๐๐๐๐๐๐๐๐๐๐
// SAMSUNGใฎๅ้ใณใผใใฃใณใฐใในใๅบ้กๅ้ก
// ้ฃใใใๅท็พๅ้ก
// ๅ้กใฎๅๆใใจใฆใ้ฃใใใฃใๅ้ก

//ๆนๆณ๏ผ:ๅ็ด whileๆใไฝฟใฃใๆนๆณ
// DFSใฎๆนๆณใงใ่งฃใใใจๆใ
let fieldSize = readLine()!.split(separator: " ").map { Int(String($0))! }
let rowSize = fieldSize[0], columnSize = fieldSize[1]
let start_Location = readLine()!.split(separator: " ").map { Int(String($0))! }
var (robotRow, robotColumn) = (start_Location[0], start_Location[1]), directionRobot = start_Location[2]
let direction = [(-1, 0), (0, 1), (1, 0), (0, -1)] //ๅ้กใง่จญๅฎใใใๆน่งใ่กจใๆฐๅญใซๅใใใฆใ่จญๅฎใใใ
var clean_count = 0

var field = [[Int]]()

for _ in 0..<rowSize {
    field += [readLine()!.split(separator: " ").map { Int(String($0))! }]
}

loop: while true {
    //ๆ้คใใใจใใใฏใ0ใงใ๏ผใใงใใชใๆฐๅญ2ใซๅคใใ
    if field[robotRow][robotColumn] == 0 {
        field[robotRow][robotColumn] = 2
        clean_count += 1
    }

    for _ in 0..<4 {
        let checkDirection = directionTurn(directionRobot)

        let (nextRow, nextColumn) = (robotRow + direction[checkDirection].0, robotColumn + direction[checkDirection].1)
        if field[nextRow][nextColumn] == 0 {
            //ๆ้คใใฆใชใใจใใใใใฃใใใใญใใใๆ้คๆฉใฎไฝ็ฝฎใๆดๆฐใใไฝๆฅญใใใฎifๆใง่กใ
            //ไฝ็ฝฎใๆดๆฐใใๅพใใญใใใๆ้คๆฉใฎๆนๅใๅคใใ
            robotRow = nextRow
            robotColumn = nextColumn
            directionRobot = checkDirection
            continue loop //ไธ่จใฎ้จๅใๅน็ใใ็็ฅใใใใใใWhileๆใซ namingๅฆ็ใใใ
        } else {
            //ใญใใใๆ้คๆฉใ็พๅจๅใใฆใใๆน่งใฎๅทฆใฎๆน่งใซๅฃ(1)ใใใฃใใใใใใใงใซๆ้คใใใจใใ(2)ใใใฃใใใใญใใใๆ้คๆฉใๅใๆนๅใ ใใๅคใใฆใใพใใforๆใๅใ
            directionRobot = checkDirection
        }
    }

    //ไธ่จใฎforๆใงๆนๅใๅคใใใใใญใใใๆ้คๆฉใฎไฝ็ฝฎใๆดๆฐใใใใฎๅใใฆใๆนๅใฎๅทฆใฎๆนๅใๆ้คใใไฝๆฅญใใใฆใใๅฝใฆใฏใพใใชใๆใฏๅพ้ฒใใ
    //ใญใใใๆ้คๆฉใฎไฝ็ฝฎใๅพ้ฒใใๅบงๆจใซๅคใใ
    //ใใคใพใใ็พๅจใญใใใๆ้คๆฉใฎไฝ็ฝฎใฎๅใใฎๅจใฆใฎๆนๅใซๅฃใใใใใใใใใงใซๆ้คใใฆใใจใใใใใฃใใใไธ่จใฎไฝๆฅญใใใใใจใซใชใ

    let backMove = (directionRobot + 2) % 4 // ๅ(0) ใจ ๅๆนๅ(2)ใใปใใใๆฑ(1)ใใจใ่ฅฟๆนๅ(3)ใใปใใใงใใใใ
    robotRow = robotRow + direction[backMove].0
    robotColumn = robotColumn + direction[backMove].1

    //ใใ ใใใใฎไธญใงใใใใใใๅพ้ฒใใๅ ดๆใซๅฃใใใฃใใใใญใใใๆ้คๆฉใฎๅไฝใๆญขใใฆใใใฎwhileๆใๆใใ
    if field[robotRow][robotColumn] == 1 {
        break loop
    }
}

//ใญใใใๆ้คๆฉใๅใใฆใๆนๅใๅคใใ้ขๆฐ
func directionTurn(_ num: Int) -> Int {
    if num == 0 {
        return 3
    } else {
        return num - 1
    }
}

print(clean_count)

//BaekJoon Algorithm Study n.1316 (ใฐใซใผใๅ่ชใใงใใฏ)
//โ ๏ธ้ไธญใฎๆฎต้

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
