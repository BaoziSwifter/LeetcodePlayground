//: [Previous](@previous)


class SortArray {
    func bubbleSort(arr: [Int]) -> [Int] {
        var arr = arr
        for i in 0..<arr.count-1 {
            for j in i+1..<arr.count {
                if arr[i] > arr[j] {
                    (arr[j], arr[j+1]) = (arr[j+1], arr[j])
                }
            }
        }
        return arr
    }

    func slectSort(arr: [Int]) -> [Int] {
        var arr = arr
        let l = arr.count
        for i in 0..<l-1 {
            var minIndex = i
            for j in i+1..<l {
                if arr[j] < arr[minIndex] {
                    minIndex = j
                }
            }
            if i != minIndex {
                (arr[i], arr[minIndex]) = (arr[minIndex], arr[i])
            }
        }
        return arr
    }
}

//: [Next](@next)
