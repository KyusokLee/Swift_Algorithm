//
//  Day 29.swift
//  BaekJoon
//
//  Created by Kyus'lee on 2022/03/07.
//

import Foundation

//ðDay 29: å·ç¾åé¡(5)
//BaekJoon Algorithm Study n.1316 (ã°ã«ã¼ãåèªãã§ãã¯)
//â ï¸  æå¤ã¨æéãããã£ãåé¡ãï¼ï¼ãåé¡ã®åæã¨ã©ã®ããã«å®ç¾ããããã¡ããã¨èãããã¨â¼ï¸
// åã®æå­ã¨æ¯è¼ããå¿è¦ããã

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

//BaekJoon Algorithm Study n.2941 (ã¯ã­ã¢ãã¢ã¢ã«ãã¡ããã)
// èªåã®å¼±ç¹ï¼æå­åãæ±ãåé¡ã«æå¤ã¨æéããããå ´åãå¤ã >> é »ç¹ã«ç·´ç¿ãããã¨

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
        // ã¢ã«ãã¡ãããããã§ãã¯ããããã«ãcheck ã®å¤æ°ã«ä¸æå­ãã¤å¥ãã¦ãã§ãã¯ã®ä½æ¥­ãè¡ã
        check += word_array[index]

        if firstAlphaCheck.contains(check) {
            //é ­æå­ãfirstAlphaCheckã«ããå ´åããã®æ¬¡ã«æ¥ãä¸æå­ã®ãã§ã¨ã¯ãè¡ãå¿è¦ããããããããã§ä½æ¥­ãè¡ã
            var nextCheckIndex = index + 1

            if nextCheckIndex < word_array.count {
                check += word_array[nextCheckIndex]

                if croatia_Alphabet.contains(check) {
                    //checkã«å¥ããæå­ãcroatia_Alphabetã«å½ã¦ã¯ã¾ãå ´åãalpha_count += 1ã«ããcheckãåæåãã
                    // ã¾ããwhileæã§ç¹°ãè¿ãindexãnextCheckIndex + 1ã«ãããï¼ï¼çç±ï¼nextCheckIndexã¾ã§ã®æå­ãcroatia_Alphabetã§ãããããæ¬¡ã®nextCheckIndex + 1ãããã§ãã¯ä½æ¥­ãè¡ã
                    alpha_count += 1
                    check = ""
                    index = nextCheckIndex + 1
                } else if check == "dz" {
                    // checkã«å¥ããæå­ãdzã«ãªãå ´åãæ¬¡ã«æ¥ãä¸æå­ãå ãããã¦ ã¯ã­ã¢ãã¢ã¢ã«ãã¡ãããã§ãã dz= ã«ãªãããªããããã§ãã¯ããå¿è¦ããã
                    // ãã®ãããnextCheckIndex + 1ã«ããæ¬¡ã«ä½æ¥­æ®µéã«è¡ã
                    nextCheckIndex += 1

                    if nextCheckIndex < word_array.count {
                        check += word_array[nextCheckIndex]


                        if check == "dz=" {
                            //checkã«å¥ããæå­ãã¯ã­ã¢ãã¢ã¢ã«ãã¡ãããã® dz= ã«å½ã¦ã¯ã¾ããããalpha_count += 1ã«ããcheckãåæåãã
                            // ã¾ããwhileæã§ç¹°ãè¿ãindexãnextCheckIndex + 1ã«ãããï¼ï¼çç±ï¼nextCheckIndexã¾ã§ã®æå­ãcroatia_Alphabetã§ãããããæ¬¡ã®nextCheckIndex + 1ãããã§ãã¯ä½æ¥­ãè¡ã
                            alpha_count += 1
                            check = ""
                            index = nextCheckIndex + 1
                        } else {
                            // checkã«å¥ããæå­ã dz= ã«ãªããããdzsãdziã¨ãã®æå­ã«ãªãå ´åã3çªç®ã®æå­ã¯ãã®æ¬¡ã®ï¼çªç®ã«æ¥ãä¸æå­ãä½ãã«ãã£ã¦ã¯ã­ã¢ãã¢ã¢ã«ãã¡ãããã«ãªããã©ããã¯ã¾ã ãå¤æ­ã§ããªãã>> ãã®ãããdzsã®å ´åãdzã¾ã§ããã§ãã¯ãããã¨ã«ããindexãnextCheckIndexãã¤ã¾ããsããwhileæãç¹°ãè¿ãããã«ãã¦ãã
                            // ã¾ããalpha_countã¯ãdzã® d ã¨ z ããããã¯ã­ã¢ãã¢ã¢ã«ãã¡ãããã«ãªããªããããalpha_count += 2ã«ãããããã¦ãcheckã¯åæå
                            alpha_count += 2
                            check = ""
                            index = nextCheckIndex
                        }
                    }
                } else {
                    // checkã«å¥ããæå­ãdsã¨ããdiã®å ´åãä¸è¨ã§èª¬æããéãã2çªç®ããcheckä½æ¥­ãè¡ãããã®ãããindex = nextCheckIndexã«ãªã
                    // ã¾ããalpha_count ã¯ãdã¾ã§ããã§ãã¯ããã¨è¦ãªãã¦ã+= 1ã«ãããcheckã¯ãåæå
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

//BaekJoon Algorithm Study n.2914 (èä½æ¨©)

let data = readLine()!.split(separator: " ").map { Int(String($0))! }
let songs = data[0], average = data[1]

print(songs * (average - 1) + 1)

//BaekJoon Algorithm Study n. 14500 (ããã­ãã)ãéè¦åº¦: ðððððððððð
// â ï¸éä¸­ã®æ®µé
// ð¥Very Difficult ð¥

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
