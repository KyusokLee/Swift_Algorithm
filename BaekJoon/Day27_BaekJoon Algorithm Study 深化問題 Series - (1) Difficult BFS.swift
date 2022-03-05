//
//  Day 27.swift
//  BaekJoon
//
//  Created by Kyus'lee on 2022/03/05.
//

import Foundation

//🔥Day 27: BaekJoon Algorithm 深化問題(2) : 同時に回しながら、更新する BFS アルゴリズム
// Rate: Gold 以上の問題を深化問題と自分で定義した

//BaekJoon Algorithm Study n.11559 (ぷよぷよ) 重要度:🎖🎖🎖🎖🎖🎖🎖🎖
// Rate: Gold 4 >> コーディングテスト中〜終盤
// 🔥Very Difficult🔥
// ⚠️アプローチはほぼ正解に近かったが、アルゴリズムの設計が少し複雑で、実現するのに行き詰まって、完璧に解ききれなかった。

//var count_Starting = [((row: Int, column: Int), color: String, count: Int)]() //Tuple型の配列を設ける
////このcount_Startingは、入力された最初の状態からcomboできる座標, 色を表す文字のみ格納される配列である
var field_data = [[String]]()
var combo_count = 0
let directionRow = [0, 0, -1, 1]  //東西南北
let directionColumn = [1, -1, 0, 0]

for _ in 0..<12 {
    let put_data = readLine()!.map { String($0) }
    //今回の問題では、一番最後に入力された列を配列のindexが最も低いとこに入れた。なぜなら、同じ色の文字４つを揃えて、comboになると、だんだん下にいくので、配列の設定を最初から最後に入力された要素を下に敷かれるよう設定した。
    field_data.insert(put_data, at: 0)
}

////出力はちゃんと出るが、なぜか、以下のコードを書くと、ずっと入力待機の状態になる >> debugすること！
//print(field_data)

while true {
    //visitedの効率的な更新を行うために、inout　パラメータを使って、変数を渡した
    var visited = Array(repeating: Array(repeating: false, count: 6), count: 12)
    var boom = false // 4つを揃えてなくなるのがあるかどうかを判別する Bool (つまり、comboになるかどうか)
    //⚠️‼️要注意: このboomを while true 文の外におき、全域変数として作ると、boomはfalseに更新されず、ずっとtrueになるから、ずっと上記の入力を受け取るfor 文が繰り返されてしまう
    // この間違いで、結構時間がかかってしまった。。
    for i in 0..<12 {
        for j in 0..<6 {
            if field_data[i][j] != "." {
                if bfs_select(i, j, field_data[i][j], &visited) {
                    //4つを揃えたものを同時に　"." に変え、格納されていた文字をなくして空スペースにさせる
                    //また、bfs_select関数でtrueになったら、4つを揃えたのが少なくても1つ以上あるということなので、boom = trueにする
                    boom = true
                }
            }
        }
    }

    if !boom {
        //４つを揃える文字がない場合、break
        break
    } else {
        puyopuyo()
        combo_count += 1
    }
}

print(combo_count)

//先にcombo(同じ文字４つ以上を揃え、なくなるやつ)になれそうなIndexを探す関数
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

//⚠️‼️この実現が特に難しかった
func puyopuyo() {
    //今回は、列を回りながら、下の方に移動させる必要があるので、先に列の数である i = 0 ~ 5までした
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
