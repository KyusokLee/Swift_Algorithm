//
//  Day 27.swift
//  BaekJoon
//
//  Created by Kyus'lee on 2022/03/05.
//

import Foundation

//ð¥Day 27: BaekJoon Algorithm æ·±ååé¡(2) : åæã«åããªãããæ´æ°ãã BFS ã¢ã«ã´ãªãºã 
// Rate: Gold ä»¥ä¸ã®åé¡ãæ·±ååé¡ã¨èªåã§å®ç¾©ãã

//BaekJoon Algorithm Study n.11559 (ã·ãã·ã) éè¦åº¦:ðððððððð
// Rate: Gold 4 >> ã³ã¼ãã£ã³ã°ãã¹ãä¸­ãçµç¤
// ð¥Very Difficultð¥
// â ï¸ã¢ãã­ã¼ãã¯ã»ã¼æ­£è§£ã«è¿ãã£ãããã¢ã«ã´ãªãºã ã®è¨­è¨ãå°ãè¤éã§ãå®ç¾ããã®ã«è¡ãè©°ã¾ã£ã¦ãå®ç§ã«è§£ããããªãã£ãã

//var count_Starting = [((row: Int, column: Int), color: String, count: Int)]() //Tupleåã®éåãè¨­ãã
////ãã®count_Startingã¯ãå¥åãããæåã®ç¶æããcomboã§ããåº§æ¨, è²ãè¡¨ãæå­ã®ã¿æ ¼ç´ãããéåã§ãã
var field_data = [[String]]()
var combo_count = 0
let directionRow = [0, 0, -1, 1]  //æ±è¥¿åå
let directionColumn = [1, -1, 0, 0]

for _ in 0..<12 {
    let put_data = readLine()!.map { String($0) }
    //ä»åã®åé¡ã§ã¯ãä¸çªæå¾ã«å¥åãããåãéåã®indexãæãä½ãã¨ãã«å¥ããããªããªããåãè²ã®æå­ï¼ã¤ãæãã¦ãcomboã«ãªãã¨ãã ãã ãä¸ã«ããã®ã§ãéåã®è¨­å®ãæåããæå¾ã«å¥åãããè¦ç´ ãä¸ã«æ·ãããããè¨­å®ããã
    field_data.insert(put_data, at: 0)
}

////åºåã¯ã¡ããã¨åºããããªãããä»¥ä¸ã®ã³ã¼ããæ¸ãã¨ããã£ã¨å¥åå¾æ©ã®ç¶æã«ãªã >> debugãããã¨ï¼
//print(field_data)

while true {
    //visitedã®å¹ççãªæ´æ°ãè¡ãããã«ãinoutããã©ã¡ã¼ã¿ãä½¿ã£ã¦ãå¤æ°ãæ¸¡ãã
    var visited = Array(repeating: Array(repeating: false, count: 6), count: 12)
    var boom = false // 4ã¤ãæãã¦ãªããªãã®ããããã©ãããå¤å¥ãã Bool (ã¤ã¾ããcomboã«ãªããã©ãã)
    //â ï¸â¼ï¸è¦æ³¨æ: ãã®boomã while true æã®å¤ã«ãããå¨åå¤æ°ã¨ãã¦ä½ãã¨ãboomã¯falseã«æ´æ°ãããããã£ã¨trueã«ãªãããããã£ã¨ä¸è¨ã®å¥åãåãåãfor æãç¹°ãè¿ããã¦ãã¾ã
    // ãã®ééãã§ãçµæ§æéãããã£ã¦ãã¾ã£ããã
    for i in 0..<12 {
        for j in 0..<6 {
            if field_data[i][j] != "." {
                if bfs_select(i, j, field_data[i][j], &visited) {
                    //4ã¤ãæãããã®ãåæã«ã"." ã«å¤ããæ ¼ç´ããã¦ããæå­ããªããã¦ç©ºã¹ãã¼ã¹ã«ããã
                    //ã¾ããbfs_selecté¢æ°ã§trueã«ãªã£ããã4ã¤ãæããã®ãå°ãªãã¦ã1ã¤ä»¥ä¸ããã¨ãããã¨ãªã®ã§ãboom = trueã«ãã
                    boom = true
                }
            }
        }
    }

    if !boom {
        //ï¼ã¤ãæããæå­ããªãå ´åãbreak
        break
    } else {
        puyopuyo()
        combo_count += 1
    }
}

print(combo_count)

//åã«combo(åãæå­ï¼ã¤ä»¥ä¸ãæãããªããªããã¤)ã«ãªããããªIndexãæ¢ãé¢æ°
func bfs_select(_ rowIndex: Int, _ columnIndex: Int, _ targetColor: String, _ visited: inout [[Bool]]) -> Bool {
    var count = 1
    var isfulfilled = false
    var Index = 0
    var neededVisitQueue = [(rowIndex, columnIndex)]
    visited[rowIndex][columnIndex] = true

    while Index < neededVisitQueue.count {
        let (currentRow, currentColumn) = neededVisitQueue[Index]

        for i in 0..<4 {
            let nextRow = currentRow + directionRow[i]
            let nextColumn = currentColumn + directionColumn[i]

            if (0 <= nextRow && nextRow < 12) && (0 <= nextColumn && nextColumn < 6) {
                if field_data[nextRow][nextColumn] == targetColor && !visited[nextRow][nextColumn] {
                    visited[nextRow][nextColumn] = true
                    neededVisitQueue.append((nextRow, nextColumn))
                    count += 1
                }
            }
        }
        Index += 1
    }

    if count >= 4 {
        for (x, y) in neededVisitQueue {
            field_data[x][y] = "."
        }
        isfulfilled = true
    }

    return isfulfilled
}

//â ï¸â¼ï¸ãã®å®ç¾ãç¹ã«é£ããã£ã
func puyopuyo() {
    //ä»åã¯ãåãåããªãããä¸ã®æ¹ã«ç§»åãããå¿è¦ãããã®ã§ãåã«åã®æ°ã§ãã i = 0 ~ 5ã¾ã§ãã
    for i in 0..<6 {
        for j in stride(from: 0, to: 11, by: 1) {
            for k in stride(from: j + 1, to: 12, by: 1) {
                if field_data[k][i] != "." && field_data[j][i] == "." {
                    field_data[j][i] = field_data[k][i]
                    field_data[k][i] = "."
                    break
                }
            }
        }
    }
}
