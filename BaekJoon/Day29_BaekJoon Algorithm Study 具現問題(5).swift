//
//  Day 29.swift
//  BaekJoon
//
//  Created by Kyus'lee on 2022/03/07.
//

import Foundation

//📝Day 29: 具現問題(5)
//BaekJoon Algorithm Study n.1316 (グループ単語チェック)
//⚠️  意外と時間がかかった問題　＞＞　問題の分析とどのように実現するかをちゃんと考えること‼️
// 前の文字と比較する必要がある

let word_Case = Int(readLine()!)!
var group_Word_Count = 0

for _ in 0..<word_Case {
    let word = readLine()!
    if isGroupWord(word) {
        group_Word_Count += 1
    }
}

print(group_Word_Count)

func isGroupWord(_ word: String) -> Bool {
    var check = true
    var checked_array = [Character]()
    let word_array = Array(word)
    var beforeAlpha = Character("#")

    for i in 0..<word_array.count {
        let alphabet = word_array[i]
        if alphabet != beforeAlpha && !checked_array.contains(word_array[i]) {
            checked_array.append(word_array[i])
            beforeAlpha = alphabet
        } else if alphabet != beforeAlpha && checked_array.contains(alphabet) {
            check = false
        }
    }

    return check
}

//BaekJoon Algorithm Study n.2941 (クロアチアアルファベット)
// 自分の弱点：文字列を扱う問題に意外と時間がかかる場合が多い >> 頻繁に練習すること

let croatia_word = readLine()!
let firstAlphaCheck = ["c", "d", "l", "n", "s", "z"]
let croatia_Alphabet = ["c=", "c-", "d-", "lj", "nj", "s=", "z="]
var alpha_count = 0

find_CroatiaAlpha(croatia_word)
print(alpha_count)

func find_CroatiaAlpha(_ word: String) {
    let word_array = Array(word).map { String($0) }
    var check = ""
    var index = 0

    while index < word_array.count {
        // アルファベットをチェックするために、check の変数に一文字ずつ入れてチェックの作業を行う
        check += word_array[index]

        if firstAlphaCheck.contains(check) {
            //頭文字がfirstAlphaCheckにある場合、その次に来る一文字のチェエクを行う必要があるため、ここで作業を行う
            var nextCheckIndex = index + 1

            if nextCheckIndex < word_array.count {
                check += word_array[nextCheckIndex]

                if croatia_Alphabet.contains(check) {
                    //checkに入れた文字がcroatia_Alphabetに当てはまる場合、alpha_count += 1にし、checkを初期化する
                    // また、while文で繰り返すindexをnextCheckIndex + 1にする　＞＞理由：nextCheckIndexまでの文字がcroatia_Alphabetであるため、次のnextCheckIndex + 1からチェック作業を行う
                    alpha_count += 1
                    check = ""
                    index = nextCheckIndex + 1
                } else if check == "dz" {
                    // checkに入れた文字がdzになる場合、次に来る一文字が加えられて クロアチアアルファベットである dz= になるかないかをチェックする必要がある
                    // そのため、nextCheckIndex + 1にし、次に作業段階に行く
                    nextCheckIndex += 1

                    if nextCheckIndex < word_array.count {
                        check += word_array[nextCheckIndex]


                        if check == "dz=" {
                            //checkに入れた文字がクロアチアアルファベットの dz= に当てはまるため、alpha_count += 1にし、checkを初期化する
                            // また、while文で繰り返すindexをnextCheckIndex + 1にする　＞＞理由：nextCheckIndexまでの文字がcroatia_Alphabetであるため、次のnextCheckIndex + 1からチェック作業を行う
                            alpha_count += 1
                            check = ""
                            index = nextCheckIndex + 1
                        } else {
                            // checkに入れた文字が dz= にならず、　dzs、dziとかの文字になる場合、3番目の文字はその次の４番目に来る一文字が何かによってクロアチアアルファベットになるかどうかはまだ、判断できない　>> そのため、dzsの場合、dzまでをチェックしたことにし、indexをnextCheckIndex　つまり、sからwhile文を繰り返すようにしておく
                            // また、alpha_countは　dzの d と z それぞれクロアチアアルファベットにならないため、alpha_count += 2にする。そして、checkは初期化
                            alpha_count += 2
                            check = ""
                            index = nextCheckIndex
                        }
                    }
                } else {
                    // checkに入れた文字がdsとか　diの場合、上記で説明した通り、2番目からcheck作業を行う。そのため、index = nextCheckIndexになる
                    // また、alpha_count は　dまでをチェックしたと見なして、+= 1にする。checkは、初期化
                    alpha_count += 1
                    check = ""
                    index = nextCheckIndex
                }
            }
        } else {
            alpha_count += 1
            check = ""
            index += 1
        }
    }
}

//BaekJoon Algorithm Study n.2914 (著作権)

let data = readLine()!.split(separator: " ").map { Int(String($0))! }
let songs = data[0], average = data[1]

print(songs * (average - 1) + 1)

//BaekJoon Algorithm Study n. 14500 (テトロミノ)　重要度: 🎖🎖🎖🎖🎖🎖🎖🎖🎖🎖
// ⚠️途中の段階
// 🔥Very Difficult 🔥

let paper_size = readLine()!.split(separator: " ").map { Int(String($0))! }
let rowSize = paper_size[0], columnSize = paper_size[1]
let directionRow = [0, 0, -1, 1]
let directionColumn = [1, -1, 0, 0]
var paper_data = [[Int]]()
var sum_max1 = 0, sum_count1 = 0, sum_max2 = 0, sum_count2 = 0
var count = 0
var visited1 = [[Bool]](repeating: Array(repeating: false, count: columnSize), count: rowSize)
var visited2 = [[Bool]](repeating: Array(repeating: false, count: columnSize), count: rowSize)

for _ in 0..<rowSize {
    paper_data += [readLine()!.split(separator: " ").map { Int(String($0))! }]
}

for i in 0..<rowSize {
    for j in 0..<columnSize {
        if !visited1[i][j] {
            dfs_matching(i, j)
        }
        if !visited2[i][j] {
            special_matching(i, j)
        }
    }
}

print(sum_max1 > sum_max2 ? sum_max1 : sum_max2)

func dfs_matching(_ rowStart: Int, _ columnStart: Int) {
    visited1[rowStart][columnStart] =  true
    sum_count1 += paper_data[rowStart][columnStart]
    count += 1
    
    if count == 4 {
        if sum_max1 < sum_count1 {
            sum_max1 = sum_count1
        }
        return
    }
    
    for i in 0..<4 {
        let nextRow = rowStart + directionRow[i]
        let nextColumn = columnStart + directionColumn[i]
        
        if (0 <= nextRow && nextRow < rowSize) && (0 <= nextColumn && nextColumn < columnSize) {
            if !visited1[nextRow][nextColumn] {
                dfs_matching(nextRow, nextColumn)
                visited1[nextRow][nextColumn] = false
                sum_count1 -= paper_data[nextRow][nextColumn]
            }
        }
    }
}

func special_matching(_ rowStart: Int, _ columnStart: Int) {
    
}
