//
//  Day12.swift
//  BaekJoon
//
//  Created by Kyus'lee on 2022/02/18.
//

import Foundation

//BaekJoon Algorithm Study n.1920 (数字探し) 重要度：🎖🎖🎖
// 🔥二分探索　BinarySearch アルゴリズム
// ‼️どの状況の二分探索問題も二分探索アルゴリズムを改良してコードで実現する能力が必要である

let read_N = Int(readLine()!)!
var firstArray = readLine()!.split(separator: " ").map { Int($0)! }
let read_M = Int(readLine()!)!
var secondArray = readLine()!.split(separator: " ").map { Int($0)! }
var result = ""
firstArray.sort()

func binarySearch(_ array1: [Int], _ targetNum: Int ) -> Bool {
    var startIdx = 0
    var endIdx = array1.count - 1

    while startIdx <= endIdx {
        let middle = (startIdx + endIdx) / 2
        if targetNum > array1[middle] {
            startIdx = middle + 1
        } else if targetNum < array1[middle] {
            endIdx = middle - 1
        } else if targetNum == array1[middle] {
            return true
        }
    }

    return false
}

for i in 0..<secondArray.count {
    result += binarySearch(firstArray, secondArray[i]) ? "1\n" : "0\n"
}
print(result)

let a = readLine()!.split(separator: " ")
print(type(of:a)) //Array<Substring>

//BaekJoon Algorithm Study n.1966 (プリンターQueue)　重要度：🎖🎖🎖🎖
//⚠️問題の分析を徹底的にすること！
//方法１. enumerated　使用 ❌  Tuple 使用：❌
let testCase = Int(readLine()!)!

func printerQueue() -> Int {
    var count = 0
    let documents_data = readLine()!.split(separator: " ").map { Int($0)! }
    let docu_num = documents_data.last!
    var data_Queue = readLine()!.split(separator: " ").map { Int($0)! }
    var currentIdx = docu_num

    while !data_Queue.isEmpty {
        if data_Queue.first! == data_Queue.max()! {
            if currentIdx == 0 {
                data_Queue.removeFirst()
                count += 1
                break
            }
            data_Queue.removeFirst()
            count += 1
            currentIdx -= 1
        } else {
            let select_idx = data_Queue.removeFirst()
            data_Queue.append(select_idx)

            if currentIdx > 0 {
                currentIdx -= 1
            } else if currentIdx == 0 {
                currentIdx = data_Queue.count - 1
            }
        }
    }

    return count
}

for _ in 0..<testCase {
    print(printerQueue())
}

//方法２. enumerated　使用 ⭕️  Tuple 使用：⭕️
// この方法がよりメモリを少なくできる！
// 🌈enumerated : (index, value) の形で返してくれる -> indexを知りたい時、効果的である
let testCase1 = Int(readLine()!)!

func printerQueue_1() -> Int {
    var count1 = 0
    let data_Print = readLine()!.split(separator: " ").map { Int($0)! }
    let target_num = data_Print.last!
    var documentsQueue = readLine()!.split(separator: " ").map { Int($0)! }
    var waitingQueue = [(Index: Int, Priority: Int)]()

    //🔥‼️重要文法
    documentsQueue.enumerated().forEach { (index, priority) in
        waitingQueue.append((index, priority))
    }

    while !documentsQueue.isEmpty {
        if documentsQueue.first! == documentsQueue.max()! {
            documentsQueue.removeFirst()
            let compare = waitingQueue.removeFirst() //ここで最初の要素を除去
            count1 += 1
            if compare.Index == target_num {  //ここのcompare.Indexでは、removeFirst()が行われない　（参照じゃない）
                break
            }
        } else {
            documentsQueue.append(documentsQueue.removeFirst())
            waitingQueue.append(waitingQueue.removeFirst())
        }
    }

    return count1
}

for _ in 0..<testCase1 {
    print(printerQueue_1())
}

//BaekJoon Algorithm Study n.2606 (パソコンウイルス) 重要度：🎖🎖🎖🎖🎖
// 🔥----🎖DFS(深さ優先探索の定番の問題)------
// ⚠️必ず、使いこなせるようになって、自分のスキルとして実現してみること！
// ❗️Now Doing 途中段階

let computers = Int(readLine()!)!
let linked_com = Int(readLine()!)!
var dict_com = [Int: [Int]]()
var Virus_count = 0

for i in 1...computers {
    dict_com[i] = []
}

for _ in 0..<linked_com {
    let link = readLine()!.split(separator: " ").map { Int($0)! }
    dict_com[link[0]]!.append(link[1])
    if dict_com[link[0]]!.contains(link[1]) {
        dict_com[link[1]]!.append(link[0])
    }
}

print(dict_com)

func DFS_FindVirus(_ select: Int) -> Int {
    var visited = Array<Bool>(repeating: false, count: computers - 1)
    var start = select
    
    for i in dict_com.keys {
        if !visited[i - 1] {
            visited[i - 1] = true
        }
    }
    
    return Virus_count
}
