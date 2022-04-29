//
//  main.swift
//  AtCoder
//
//  Created by Kyus'lee on 2022/04/29.
//

import Foundation

//Bit探索練習
let BitA = 2   // 00000010
let BitB = 4   // 00000100
let BitB2 = 5  // 00000110
let BitB_B2 = BitB & BitB2  //   上記の2進数で 今日つである1が 2 ^ 2の部分にあるため、4が出力
print(BitB_B2) // 出力: 4
let BitA_B = BitA & BitB // 比較する2つの値の2進数が同値であるところを出力
print(BitA_B)  // 出力: 0

let BitC = 27
let BitD = 27
let BitC_D = BitC & BitD
print(BitC_D)  //出力: 27


let m = 8
for i in 1..<10 {
    let indices = (0..<m).filter { i & (1 << $0) != 0 } // 10進数 i を2進数の表現と、1を $0　ほど左シフトした２進数の表現で共通してるところがあればfilterする
    //　ex) i = 9  -> 1001(2進数) --> つまり、3の位置と0の位置に1をすることで 2 ^ 3 + 2 ^ 0 = 9 になる
    // したがって、[0, 3]　が出力される
    print("i番目: \(i) \(indices)")
}

let prac_Array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
let prac_filter = prac_Array.filter { $0 % 2 == 0 } // filterの中のClosureの式に当てはまる要素だけ取り出して配列にする
print(prac_filter)






