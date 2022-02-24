//
//  Day18.swift
//  BaekJoon
//
//  Created by Kyus'lee on 2022/02/24.
//

import Foundation


//Day 18: DFS, BFSのアルゴリズムの整理と問題 (6) ＋　数学的実現問題 (1)

//BaekJoon Algorithm Study n.2468 (安全な領域) 重要度：🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖
//連結要素を求めるアルゴリズムを活用したコード
// コードはいい感じだと思うけど、なぜか値がおかしくなっている
// ⚠️‼️途中の段階
// 🔥for文の範囲設定のミスで５時間くらい時間を注いだ問題... エラーがどこでなっているかを把握するのも大事！🔥
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

for _ in 0...areaMax_height {
    Count_SafeArea(district: district_size, rainLevel: rain_size)
    rain_size += 1
}
print(safeArea_maxCount)

func Count_SafeArea(district: Int, rainLevel: Int) {
    var linked = [[Bool]](repeating: Array(repeating: false, count: district), count: district)
    var isRainedArea = [[Bool]](repeating: Array(repeating: false, count: district), count: district)
    var checked_area:[((Int, Int), Int)]
    var area_Count = 0
    var index = 0

    //雨の量による浸水した地域設定
    for i in 0..<district {
        for j in 0..<district {
            if area_data[i][j] <= rainLevel {
                isRainedArea[i][j] = true
            }
        }
    }
//    guard isRainedArea.contains(where: {$0.contains(true)}) else {
//        safeArea_maxCount = 1
//        return
//    }

    for i in 0..<district {
        for j in 0..<district {
            if !linked[i][j] {
                if !isRainedArea[i][j] {
                    area_Count += 1
                    checked_area = [((i, j), area_Count)]
                    bfs(startRow: i, startColumn: j)
                    index = 0
                }
            }
        }
    }

    if safeArea_maxCount < area_Count {
        safeArea_maxCount = area_Count
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

    func bfs(startRow: Int, startColumn: Int) {
        linked[startRow][startColumn] = true

        while index < checked_area.count {
            let ((checkRow, checkColumn), areaNum) = checked_area[index]

            //  ⚠️‼️⚠️ミス注意！！！ここで、0..<4にしなきゃいけなかったのをずっと0..<3にしてたからエラーになった。。。
            for i in 0..<4 {
                let nextRow = checkRow + directionRow[i]
                let nextColumn = checkColumn + directionColumn[i]

                if (0 <= nextRow && nextRow <= district - 1) && (0 <= nextColumn && nextColumn <= district - 1) {
                    if !isRainedArea[nextRow][nextColumn] && !linked[nextRow][nextColumn] {
                        linked[nextRow][nextColumn] = true
                        checked_area.append(((nextRow, nextColumn), areaNum))
                    }
                }
            }
            index += 1
        }
    }

}

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

//ここで、areaMax_heightより小さく設定する理由は、全ての地域が沈水されたら安全な地域は0になり、計算に入れる意味がないためである
for _ in 0..<areaMax_height {
    Count_SafeArea(district: district_size, rainLevel: rain_size)
    rain_size += 1
}

print(safeArea_maxCount)

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

    for i in 0..<district {
        for j in 0..<district {
            if !isRainArea[i][j] && !linked[i][j] {
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


    func dfs(startRow: Int, startColumn: Int) {
        linked[startRow][startColumn] = true

        for i in 0..<4 {
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

//BaekJoon Algorithm Study n.9012 (括弧) 重要度：🎖🎖🎖🎖🎖
//removeLast と popLast の違いをよく覚えておくこと！
// removeLast() は、collection　が 空いているなら、エラーになる
// popLast()は、collectionが　空のとき、nilを返す
let data_Num = Int(readLine()!)!

for _ in 0..<data_Num {
    let readData = readLine()!
    var count = 0

    for i in readData {
        if i == "(" {
            count += 1
        } else if i == ")" {
            count -= 1
            if count < 0 {
                break
            }
        }
    }

    print(count == 0 ? "YES" : "NO")
}

//stack構造体を用いた解き方
let testCount = Int(readLine()!)!
var parenthesis = [String]()

for _ in 0..<testCount {
    parenthesis.append(readLine()!)
}

for i in parenthesis {
    if isPossible(parenthesis: i) {
        print("YES")
    } else {
        print("NO")
    }
}

func isPossible(parenthesis: String) -> Bool {
    var stack = [Character]()
    for char in parenthesis {
        if char == "(" {
            stack.append(char)
        }
        if char == ")" {
            guard stack.popLast() != nil else {return false}
        }
    }

    return stack.isEmpty
}

//stack と　popLast()の練習
// popLast()は後ろのやつをpopし、その要素を返す

var prac1 = [1, 3, 5]
for _ in 0..<prac1.count {
    print(prac1.popLast()!)
    print(prac1)
}

BaekJoon Algorithm Study n.2108 (統計学) 重要度：🎖🎖🎖🎖🎖🎖
この書き方だと、Run Time Errorになる
方法:１　関数を使った方法

let testNum = Int(readLine()!)!
var dictNum = [Int: Int]()

for _ in 0..<testNum {
    let number = Int(readLine()!)!
    dictNum[number] = 1
    if dictNum[number] != nil {
        dictNum[number]! += 1
    }
}

arithmeticAverage(compare:dictNum)
medianValue(compare:dictNum)
maxFrequentValue(compare:dictNum)
range(compare:dictNum)

func arithmeticAverage(compare: Dictionary<Int, Int>) {
    let sum = compare.keys.reduce(0) { $0 + $1 }
    let result = round(Double(sum) / Double(testNum))

    print(Int(result))
}

//この書き方だと、要素が２個の場合、Index out of range になる
func medianValue(compare: Dictionary<Int, Int>) {
    let sortedDict = compare.keys.sorted()
    print(sortedDict[testNum / 2])
}

//⚠️この関数の実現がちょっと難しかった。
func maxFrequentValue(compare: Dictionary<Int, Int>) {
    let filteredDict = dictNum.filter { $0.value == compare.values.max()!}
    let sortedDict = filteredDict.sorted(by: { $0.key < $1.key })

    print(sortedDict[sortedDict.count > 1 ? 1 : 0].key)
}

func range(compare: Dictionary<Int, Int>) {
    let maxValue = compare.keys.max()!
    let minValue = compare.keys.min()!

    print(maxValue - minValue)
}

//方法:２　関数を使わなかった方法

let testCount = Int(readLine()!)!
var dictNum = [Int: Int]()
var array1 = [Int]()
var maxFrequent = 0
var sum = 0

for _ in 0..<testCount {
    let number = Int(readLine()!)!
    sum += number
    
    if dictNum[number] != nil {
        dictNum[number]! += 1
    } else {
        dictNum[number] = 1
    }
    maxFrequent = maxFrequent < dictNum[number]! ? dictNum[number]! : maxFrequent
    array1.append(number)
}

let array2 = array1.sorted()
let filteredDict = dictNum.filter { $0.value == maxFrequent } //Dictionaryの形として返される
//print(filteredDict)
//print(type(of:filteredDict))
let sortedDict = filteredDict.sorted { $0.key < $1.key } //この文法は、(key: Int, value: Int)のtupleを要素として持つ配列を返す
//print(sortedDict)
//print(type(of:sortedDict))

print( Int(round( Double(sum) / Double(testCount) )))
print(array2[testCount / 2])
print(sortedDict[sortedDict.count > 1 ? 1 : 0].key)
print(array2.last! - array2.first!)
