//
//  Day 30.swift
//  BaekJoon
//
//  Created by Kyus'lee on 2022/03/08.
//

import Foundation

//Day 30:　具現問題(6)
//BaekJoon Algorithm Study n. 14500 (テトロミノ)　重要度: 🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖
// ⚠️途中の段階
// 🔥Very Difficult 🔥
// Xcode上では、ちゃんと動くが、BaekJoon でテストしてみると、エラーになってしまったコード

let paper_size = readLine()!.split(separator: " ").map { Int(String($0))! }
let rowSize = paper_size[0], columnSize = paper_size[1]
let directionRow = [0, 0, -1, 1] //東西南北
let directionColumn = [1, -1, 0, 0]
var paper_data = [[Int]]()
var sum_max = 0
var visited1 = [[Bool]](repeating: Array(repeating: false, count: columnSize), count: rowSize)

//let specialCase: [[(row: Int, column: Int)]] = [[(0, 0), (1, 0), (2, 0), (1, 1)], [(0, 0), (0, 1), (0, 2), (1, 1)], [(0, 0), (0, 1), (0, 2), (-1, 1)], [(0, 0), (0, 1), (-1, 1), (1, 1)]]

let specialCase: [[(row: Int, column: Int)]] = [[(0, 0), (1, 0), (1, -1), (1, 1)], [(0, 0), (0, 1), (-1, 1), (1, 1)], [(0, 0), (0, -1), (-1, -1), (1, -1)], [(0, 0), (-1, 0), (-1, -1), (-1, 1)]]
//"ㅏ" "ㅜ" "ㅗ" "ㅓ"図形の順

//passできなかった座標の設計：let specialCase: [[(row: Int, column: Int)]] = [[(0, 0), (1, 0), (1, -1), (1, 1)], [(0, 0), (0, 1), (-1, 1), (1, 1)], [(0, 0), (0, -1), (-1, -1), (1, -1)], [(0, 0), (-1, 0), (-1, -1), (-1, 1)]]

for _ in 0..<rowSize {
    paper_data += [readLine()!.split(separator: " ").map { Int(String($0))! }]
}

for i in 0..<rowSize {
    for j in 0..<columnSize {
        visited1[i][j] = true
        dfs_matching(1, i, j, paper_data[i][j])
        visited1[i][j] = false
        
        special_matching(i, j)
    }
}

print(sum_max)

//"ㅗ" "ㅓ" "ㅏ" "ㅜ" のものを除いた図形は、全部この関数で探索できる
func dfs_matching(_ cnt: Int, _ rowStart: Int, _ columnStart: Int, _ sum: Int) {
    if cnt == 4 {
        sum_max = max(sum_max, sum)
        return
    }
    
    for i in 0..<4 {
        let nextRow = rowStart + directionRow[i]
        let nextColumn = columnStart + directionColumn[i]
        
        if (nextRow < 0 || nextRow >= rowSize) || (nextColumn < 0 || nextColumn >= columnSize) {
            continue
        }
            
        if !visited1[nextRow][nextColumn] {
            visited1[nextRow][nextColumn] = true
            dfs_matching(cnt + 1, nextRow, nextColumn, sum + paper_data[nextRow][nextColumn])
            visited1[nextRow][nextColumn] = false
        }
        
    }
}

//⚠️このアルゴリズムが特に難しかった
//"ㅗ" "ㅓ" "ㅜ" "ㅏ" のような形をする図形の探索 >> dfs_matchingで探索できない理由: 一度visitしたブロックをまたvisitして、その左右にあるブロックに探索するという探索方法なので、別途の関数を作る必要があった
func special_matching(_ rowStart: Int, _ columnStart: Int) {
    
    for i in 0..<4 {
        var sum = 0
        var canMatch = true
        
        for j in 0..<4 {
            let nextRow = rowStart + specialCase[i][j].row
            let nextColumn = columnStart + specialCase[i][j].column
            
            //"ㅗ" "ㅓ" "ㅜ" "ㅏ"のような図形が、現在選んだ座標(rowStart, columnStart)からpaperのサイズ内で作成できない場合、canMatch = falseにして、breakをかける
            guard 0 <= nextRow && nextRow < rowSize && 0 <= nextColumn && nextColumn < columnSize else {
                canMatch = false
                break
            }
                        
            sum += paper_data[nextRow][nextColumn]
        }
        
        if canMatch {
            sum_max = max(sum_max, sum)
        }
    }
}
