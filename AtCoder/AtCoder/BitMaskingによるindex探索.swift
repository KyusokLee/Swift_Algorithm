//
//  BitMaskingによるindex探索.swift
//  AtCoder
//
//  Created by Kyus'lee on 2022/05/09.
//

import Foundation
// 🔥このBit Maskingを用いたindexの探索は非常に活用性が高い
let m = 8
for i in 1..<10 {
    let indices = (0..<m).filter { i & (1 << $0) != 0 } // 10進数 i を2進数の表現と、1を $0　ほど左シフトした２進数の表現で共通してるところがあればfilterする
    // この i & (1 << $0) != 0 の右辺を、 == 4 にすると、 ２進数のindexの桁が4である (2 ^ 2)ため、0100の位置が被るindexだけ出力
    // 例えば、　7 は　2進数で 0111なので、 0111と 0100が共通であるところは、　2 ^ 2 になり、 2がfiltering　されるのである
    //　ex) i = 9  -> 1001(2進数) --> つまり、3の位置と0の位置に1をすることで 2 ^ 3 + 2 ^ 0 = 9 になる
    // したがって、[0, 3]　が出力される
    print("i番目: \(i) \(indices)")
}
