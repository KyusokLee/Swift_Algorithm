//
//  Day33.swift
//  BaekJoon
//
//  Created by Kyus'lee on 2022/03/14.
//

import Foundation

//Day33  Week4 ~ 5: 一週間の復習 (3) + BFS問題 (1問) + BitMasking (1)
//📝ここからは、明日の復習になる❗️
//BaekJoon Algorithm Study n.14503 (ロボット掃除機) 重要度：🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖
//掃除したところは2に変える作業をした
// ‼️📮Hard: ⭐️⭐️

let data = readLine()!.split(separator: " ").map { Int(String($0))! }
let rowSize = data[0], columnSize = data[1]
let robotData = readLine()!.split(separator: " ").map { Int(String($0))! }
var (robotRow, robotColumn) = (robotData[0], robotData[1]), robotDirection = robotData[2]
var result = 0
var field = [[Int]]()
let directionSetting: [(row: Int, column: Int)] = [(-1, 0), (0, 1), (1, 0), (0, -1)]

for _ in 0..<rowSize {
    field += [readLine()!.split(separator: " ").map { Int(String($0))! }]
}

loop: while true {
    if field[robotRow][robotColumn] == 0 {
        field[robotRow][robotColumn] = 2
        result += 1
    }

    for _ in 0..<4 {
        let checkLeft = directionChange(robotDirection)

        let nextRow = robotRow + directionSetting[checkLeft].row
        let nextColumn = robotColumn + directionSetting[checkLeft].column

        if field[nextRow][nextColumn] == 0 {
            robotDirection = checkLeft
            robotRow = nextRow
            robotColumn = nextColumn
            continue loop
        } else {
            robotDirection = checkLeft
        }
    }

    let backMove = (robotDirection + 2) % 4
    robotRow = robotRow + directionSetting[backMove].row
    robotColumn = robotColumn + directionSetting[backMove].column

    if field[robotRow][robotColumn] == 1 {
        break loop
    }
}

print(result)

func directionChange(_ num: Int) -> Int {
    if num == 0 {
        return 3
    } else {
        return num - 1
    }
}

//BaekJoon Algorithm Study n.15649 (NとM (1))  重要度:🎖🎖🎖🎖🎖🎖
// BackTrackingの基本となる問題
// ⚠️必ず、使いこなせるようにすること！

let N_M = readLine()!.split(separator: " ").map { Int(String($0))! }
let numberRange = N_M[0], selectRange = N_M[1]
var resultArray = [[Int]]()
var checked = [Bool](repeating: false, count: numberRange + 1)

dfs_find([])
for i in resultArray {
    print(i.map { String(Int($0)) }.joined(separator: " ") )
}

func dfs_find(_ num: [Int]) {
    if num.count == selectRange {
        resultArray.append(num)
        return
    }

    for i in 1..<checked.count {
        if !checked[i] {
            checked[i] = true
            dfs_find(num + [i])
            checked[i] = false
        }
    }
}

// もっと処理時間を減らせるコード
let data = readLine()!.split(separator: " ").map { Int(String($0))! }
let numRange = data[0], selectRange = data[1]
var checked = [Bool](repeating: false, count: numRange + 1)
var result = [String]()

for i in 1...numRange {
    checked[i] = true
    dfs_find(1, "\(i)")
    checked[i] = false
}

for i in 0..<result.count {
    print(result[i])
}

func dfs_find(_ depth: Int, _ str: String) {
    if depth == selectRange {
        result.append(str)
        return
    }

    for i in 1..<checked.count {
        if !checked[i] {
            checked[i] = true
            dfs_find(depth + 1, str + " \(i)")
            checked[i] = false
        }
    }
}

//BaekJoon Algorithm Study n.7562 (ナイトの移動(chess)) 重要度: 🎖🎖🎖🎖🎖🎖
let testCase = Int(readLine()!)!
let knightMove: [(row: Int, column: Int)] = [(-2, 1), (-1, 2), (1, 2), (2, 1), (2, -1), (1, -2), (-1, -2), (-2, -1)]

for _ in 0..<testCase {
    let fieldSize = Int(readLine()!)!
    let currentLocate = readLine()!.split(separator: " ").map { Int(String($0))! }
    let rowStart = currentLocate[0], columnStart = currentLocate[1]
    let targetLocate = readLine()!.split(separator: " ").map { Int(String($0))! }
    let (targetRow, targetColumn) = (targetLocate[0], targetLocate[1])

    print(bfs_moving(rowStart, columnStart, (targetRow, targetColumn), fieldSize))
}

func bfs_moving(_ row: Int, _ column: Int, _ destination: (Int, Int), _ mapSize: Int) -> Int {
    var field = Array(repeating: Array(repeating: false, count: mapSize), count: mapSize)
    var resultCount = 0
    var neededCheckQueue = [((row, column), 0)]
    var Index = 0
    field[row][column] = true

    while Index < neededCheckQueue.count {
        let ((currentRow, currentColumn), count) = neededCheckQueue[Index]
        if neededCheckQueue[Index].0 == destination {
            resultCount = count
            break
        }

        for i in 0..<8 {
            let nextRow = currentRow + knightMove[i].row
            let nextColumn = currentColumn + knightMove[i].column

            if nextRow < 0 || nextRow >= mapSize || nextColumn < 0 || nextColumn >= mapSize {
                continue
            }

            if !field[nextRow][nextColumn] {
                neededCheckQueue.append(((nextRow, nextColumn), count + 1))
                field[nextRow][nextColumn] = true
            }
        }
        Index += 1
    }

    return resultCount
}

//BaekJoon Algorithm Study n.11723 (集合) 重要度: 🎖🎖🎖🎖
//⚠️Class, 構造体の解き方を必ず習うこと
// ⚠️Xcode上では、時間オーバーにならないが、BaekJoonでは時間超過になってしまった
// BaekJoon　サイトでは、swiftに優しくない。。処理時間をプログラミング言語ごとに再設定してくれない。。
class Commander {
    var array: [Int] = []

    func Add(_ x: Int) -> Void {
        if !array.contains(x) {
            array.append(x)
        }
    }

    func Remove(_ x: Int) -> Void {
        if array.contains(x) {
            for _ in 0..<array.count {
                if let i = array.firstIndex(of: x) {
                    array.remove(at: i)
                }
            }
        }
    }

    func Check(_ x: Int) {
        print(array.contains(x) ? "1" : "0")
    }

    func Toggle(_ x: Int) {
        array.contains(x) ? Remove(x) : Add(x)
    }

    func All() {
        array = Array(1...20)
    }

    func Empty() {
        array = []
    }
}

let testCase = Int(readLine()!)!
let S = Commander.init()

for _ in 0..<testCase {
    let command = readLine()!.split(separator: " ").map { String($0) }
    let str = command[0]

    switch str {
    case "add":
        S.Add(Int(command[1])!)
    case "remove":
        S.Remove(Int(command[1])!)
    case "check":
        S.Check(Int(command[1])!)
    case "toggle":
        S.Toggle(Int(command[1])!)
    case "all":
        S.All()
    case "empty":
        S.Empty()
    default:
        exit(0)
    }
}

// 時間超過にならないコードの作成
// wapasさん、JCSooHwanChoさんのコードを参考

// JCSooHwanChoさんの FileIO
// https://gist.github.com/JCSooHwanCho/30be4b669321e7a135b84a1e9b075f88
// Wapasさん
// https://www.acmicpc.net/user/wapas

//WapasさんのFileIO
class FileIO {
    @inline(__always) private var buffer: [UInt8] = Array(FileHandle.standardInput.readDataToEndOfFile()) + [0], byteIdx = 0
    
    @inline(__always) private func readByte() -> UInt8 {
        defer { byteIdx += 1 }
        return buffer.withUnsafeBufferPointer { $0[byteIdx] }
    }
    
    @inline(__always) func readInt() -> Int {
        var number = 0, byte = readByte(), isNegative = false
        while byte == 10 || byte == 32 { byte = readByte() }
        if byte == 45 { byte = readByte(); isNegative = true }
        while 48...57 ~= byte { number = number * 10 + Int(byte - 48); byte = readByte() }
        return number * (isNegative ? -1 : 1)
    }
    
    @inline(__always) func readStirngSum() -> Int {
        var byte = readByte()
        while byte == 10 || byte == 32 { byte = readByte() }
        var sum = Int(byte)
        while byte != 10 && byte != 32 && byte != 0 { byte = readByte(); sum += Int(byte) }
        return sum - Int(byte)
    }
    
    @inline(__always) private func write(_ output: String) {
        FileHandle.standardOutput.write(output.data(using: .utf8)!)
    }
}
let fileIO = FileIO()
let N = fileIO.readInt()
var arr = Array(repeating: false, count: 20)
var ans = ""

for _ in 0..<N {
    switch fileIO.readStirngSum() {
    case 297: //"add"
        arr[fileIO.readInt()-1] = true
    case 654: //"remove"
        arr[fileIO.readInt()-1] = false
    case 510: //"check":
        ans.write(arr[fileIO.readInt()-1] == true ? "1\n" : "0\n")
    case 642: //"toggle":
        let num = fileIO.readInt()-1
        arr[num] = !arr[num]
    case 313: //"all":
        arr = Array(repeating: true, count: 20)
    case 559: //"empty":
        arr = Array(repeating: false, count: 20)
    default:
        break
    }
}
print(ans)

//📮‼️BitMasking 練習‼️

// ######### 公式 ##########
var S = 0

//Sに 数字 Nを追加したいのであれば
S |= (1<<N)
//⚠️注意: ただのprint()を使うと、10進法として計算されるため、print(String(S, radix:2))を使わなければならない
// ########################

var S1 = 0
var S2 = 0


S1 |= (1<<3)
S1 |= (1<<3)

S2 += (1<<3)
S2 += (1<<3)

print(S1) //8
print(S2) //16
// radixは、進法の基準を表す
print(String(S1,radix: 2))// = 00000000 00000000 00000000 00010000
print(String(S2,radix: 2))// = 00000000 00000000 00000000 00100000

var S3:UInt32 = 0
//print(String(S3,radix:2) = 00000000 00000000 00000000 00000000
//print(S3) = 0

//add 3
S3 |= (1<<(3)) //表記方法 - (1)
//表記方法 - (2) S3 |= (1<<(3-1))
//私は2番方式を使ったが、1番方式は見やすいが、0番目のビット一つを使わない。 実際、1ビットなので大きな差はないかもしれないが、32ビットまでの数では1番方式を使うためには64ビットを使わなければならない。

//print(String(S3,radix:2) = 00000000 00000000 00000000 00001000
//print(S3) = 8

//add 5
S3 |= (1<<5)
//print(String(S3,radix:2) = 00000000 00000000 00000000 00101000
//print(S3) = 8+32 = 40

//add 1
S3 |= (1<<1)
//S3 = 00000000 00000000 00000000 00101010
//print(S3) = 8+32+2 = 42
