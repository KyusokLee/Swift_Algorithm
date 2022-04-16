//
//  SegmentTreeアルゴリズム.swift
//  BaekJoon
//
//  Created by Kyus'lee on 2022/04/16.
//

import Foundation

//Day 56 Segment Treeアルゴリズム
class SegmentTree<T> {
    var value: T
    var function: (T, T) -> T
    var leftBounds: Int //左の方の境界
    var rightBounds: Int //右の方の境界
    var leftChild: SegmentTree<T>?
    var rightChild: SegmentTree<T>?
    
    init(array: [T], leftBounds: Int, rightBounds: Int, function: @escaping (T, T) -> T) {
        self.leftBounds = leftBounds
        self.rightBounds = rightBounds
        self.function = function
        
        if leftBounds == rightBounds {
            self.value = array[leftBounds]
        } else {
            let middle = (leftBounds + rightBounds) / 2
            self.leftChild = SegmentTree<T>(array: array, leftBounds: leftBounds, rightBounds: middle, function: function)
            self.rightChild = SegmentTree<T>(array: array, leftBounds: middle + 1, rightBounds: rightBounds, function: function)
            self.value = function(leftChild!.value, rightChild!.value)
        }
    }
    
    //ただ、配列で構成するんだったらいちいち境界を入れる必要がない >> そのため、convenience initを設ける
    convenience init(array: [T], function: @escaping (T, T) -> T) {
        self.init(array: array, leftBounds: 0, rightBounds: array.count - 1, function: function)
    }
    
    func Query(withL leftBounds: Int, rightBounds: Int) -> T {
        // left, right が全部一致する場合、 -> 自分のvalueをreturn
        if self.leftBounds == leftBounds, self.rightBounds == rightBounds {
            return value
        }
        
        guard let leftChild = leftChild, let rightChild = rightChild else {
            fatalError("Find Error!")
        }
        
        //左の子供の右が leftより小さい？ -> 右の子供に全部含まれるから右から再び探索を繰り返す
        if leftChild.rightBounds < leftBounds {
            return rightChild.Query(withL: leftBounds, rightBounds: rightBounds)
        } else if rightChild.leftBounds > rightBounds {
            //右の子供の左が rightより大きい？ -> 左の子供に全部含まれるから左から再び探索を繰り返す
            return leftChild.Query(withL: leftBounds, rightBounds: rightBounds)
        } else {
            //両方の子供にまたがっている ？ -> (leftBounds - leftChild.right) + (rightChild.left - rightBounds)
            let leftValue = leftChild.Query(withL: leftBounds, rightBounds: leftChild.rightBounds)
            let rightValue = rightChild.Query(withL: rightChild.leftBounds, rightBounds: rightBounds)
            
            return function(leftValue, rightValue)
        }
    }
    
    //オーダー記法 O(logN)
    func replaceItem(at index: Int, withItem item: T) {
        if leftBounds == rightBounds {
            value = item
        } else if let hasLeftChild = leftChild, let hasRightChild = rightChild {
            if hasLeftChild.rightBounds >= index {
                hasLeftChild.replaceItem(at: index, withItem: item)
            } else {
                hasRightChild.replaceItem(at: index, withItem: item)
            }
            value = function(hasLeftChild.value, hasRightChild.value)
        }
    }
}

let array1 = Array(1...10)
let segmentTree = SegmentTree<Int>(array: array1, function: +)
print(segmentTree)
print(segmentTree.Query(withL: 0, rightBounds: 3)) // 10
print(segmentTree.Query(withL: 0, rightBounds: 9)) // 55
print(segmentTree.Query(withL: 1, rightBounds: 5)) // 20
segmentTree.replaceItem(at: 3, withItem: 10) // [1, 2, 3, 10, 5, 6, 7, 8, 9, 10] array[3]にある4を10にchange
print(segmentTree.Query(withL: 0, rightBounds: 3)) // 16
print(segmentTree.Query(withL: 0, rightBounds: 4)) // 21
print(segmentTree.Query(withL: 0, rightBounds: 5)) // 27
print(segmentTree.Query(withL: 0, rightBounds: 6)) // 34
print(segmentTree.Query(withL: 0, rightBounds: 7)) // 42
print(segmentTree.Query(withL: 0, rightBounds: 8)) // 51
print(segmentTree.Query(withL: 0, rightBounds: 9)) // 61
