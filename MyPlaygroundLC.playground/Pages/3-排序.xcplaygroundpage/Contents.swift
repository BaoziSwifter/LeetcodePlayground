//: [Previous](@previous)

// 1.冒泡排序
class BubbleSort {
    func bubbleSort(arr: [Int]) -> [Int] {
        var arr = arr
        for i in 0..<arr.count-1 {
            for j in i+1..<arr.count-i {
                if arr[i] > arr[j] {
                    (arr[j], arr[j+1]) = (arr[j+1], arr[j])
                }
            }
        }
        return arr
    }


}

// 2.选择排序
class SelectSort {

    // 第一种  选择后边小的跟前边的交换
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

    // 第二种
    func selectionSort(items: inout [Int]) {
      for i in 0...items.count-2 {
        let rem = Array(items[i...items.count-1])
        let indexOfMinimum = indexOfMin(items: rem) + i
        if indexOfMinimum != i {
          let tmp = items[indexOfMinimum]
          items[indexOfMinimum] = items[i]
          items[i] = tmp
        }
      }
    }

    func indexOfMin(items: [Int]) -> Int {
      var ret = 0
      for i in 1..<items.count {
        if items[ret] > items[i] {
          ret = i
        }
      }
      return ret
    }
}

// 3. 快排
class RecursionQuick{
    func recursion_quickSort(arr: inout [Int], start: Int, end:Int) -> Void {
        guard !arr.isEmpty && start < end else {
            return
        }
        let i = recursion_partition(&arr, start: start, end: end)
        recursion_quickSort(arr: &arr, start: start, end: i-1)
        recursion_quickSort(arr: &arr, start: i+1, end: end)

    }
    func recursion_partition(_ arr: inout [Int], start: Int, end: Int) -> Int {
        let flagVal = arr[end]
        var i = start
        for j in start...end {
            if arr[j] < flagVal {
                if j != i {
                    arr.swapAt(i, j)
                    i += 1
                }
            }
        }
        if end != i {
            arr.swapAt(end, i)
        }

        return i
    }
    private func partition(list: inout Array<Int>, low: Int, high: Int) -> Int {
        var low = low
        var high = high
        let temp = list[low]
        while low < high{
            //继续添加一个循环语句，从数组的尾部向头部进行遍历，
            //用来获得比临时值小的元素所在的位置
            while low < high && list[high] >= temp{
                high -= 1
            }
            //然后将该元素的值，替代原来的最小值
            list[low] = list[high]
            //继续添加一个循环语句，从数组的头部，
            //向上一个循环语句找到的，
            //比临时值小的元素所在的索引位置
            //用来获得比临时值小的元素所在的位置
            while low < high && list[low] <= temp
            {
                low += 1
            }
            //然后将该元素的值，替代原来的最大值
            list[high] = list[low]
        }
        //这样就完成了对数组分成两部分的任务，
        //然后将用来分割值的索引，
        //替换low(此时low和high是相等的)索引所在的位置的元素即可。
        list[low] = temp
        //最后返回low作为分割值的索引
        return low
    }
}

// 4.归并排序
class MerageSort{
    func mergeSort(_ array: [Int]) -> [Int] {
      guard array.count > 1 else { return array }

      let middleIndex = array.count / 2

      let leftArray = mergeSort(Array(array[0..<middleIndex]))             // 3

      let rightArray = mergeSort(Array(array[middleIndex..<array.count]))  // 4

      return merge(leftPile: leftArray, rightPile: rightArray)             // 5
    }

    func merge(leftPile: [Int], rightPile: [Int]) -> [Int] {

      var leftIndex = 0
      var rightIndex = 0

      var orderedPile = [Int]()

      while leftIndex < leftPile.count && rightIndex < rightPile.count {
        if leftPile[leftIndex] < rightPile[rightIndex] {
          orderedPile.append(leftPile[leftIndex])
          leftIndex += 1
        } else if leftPile[leftIndex] > rightPile[rightIndex] {
          orderedPile.append(rightPile[rightIndex])
          rightIndex += 1
        } else {
          orderedPile.append(leftPile[leftIndex])
          leftIndex += 1
          orderedPile.append(rightPile[rightIndex])
          rightIndex += 1
        }
      }

      while leftIndex < leftPile.count {
        orderedPile.append(leftPile[leftIndex])
        leftIndex += 1
      }

      while rightIndex < rightPile.count {
        orderedPile.append(rightPile[rightIndex])
        rightIndex += 1
      }

      return orderedPile
    }
}

// 5.桶排序or基数排序
class BucketSort {
    func bucketSort(items: inout [Int]) {
      var buckets = Dictionary<Int, Int>()
      for item in items {
        if let curVal = buckets[item] {
          buckets[item] = curVal + 1
        } else {
          buckets[item] = 1
        }
      }
      let sortedKeys = buckets.keys.sorted()
      var curIndex = 0
      for key in sortedKeys {
        if let count = buckets[key] {
          for _ in 1...count {
            items[curIndex] = key
            curIndex += 1
          }
        }
      }
    }
}

// 6. 插入排序
class InsertSort {
    //MARK: 直接插入排序
    func directInsertSort(_ arr:inout [Int])
    {
        for i in 1..<arr.count
        {
            //为a[i]在前面的a[0...i-1]有序区间中找一个合适的位置
            for j in stride(from:i - 1,through: 0,by:-1)
            {
                if arr[j] < arr[i] {break}
                 //如找到了一个合适的位置
                if j != i - 1
                {
                    let temp:Int = arr[i]
                    //将比a[i]大的数据向后移
                    for k in stride(from: i - 1, to: j, by: -1)
                    {
                        arr[k + 1] = arr[k]
                        //将a[i]放到正确位置上
                        arr[k + 1] = temp
                    }
                }
            }
        }
    }

    //MARK: 二分插入排序
    func binarySearchInsertSort(_ arr:inout [Int]) {
        for i in 1..<arr.count {
            let temp:Int = arr[i]
            var low:Int = 0
            var high:Int = i - 1
            var mid:Int = -1
            while(low <= high){
                 mid = low + (high - low) / 2
                if arr[mid] > temp{
                    high = mid - 1
                }else{
                    //元素相同时，也插入在后面的位置
                    low = mid + 1
                }
            }
            for j in stride(from: i - 1, through: low, by: -1){
                arr[j + 1] = arr[j]
            }
            arr[low] = temp
        }
    }
}

// 7. 希尔排序
class ShellSort {
    //MARK: 希尔排序
    func shellSort(_ arr:inout [Int])
    {
        var number:Int = arr.count / 2
        var j:Int = 0
        var temp:Int = 0
        while (number >= 1)
        {
            for i in number..<arr.count
            {
                temp = arr[i]
                j = i - number
                //需要注意的是，这里array[j] < temp将会使数组从大到小排列
                while (j >= 0 && arr[j] > temp)
                {
                    arr[j + number] = arr[j]
                    j = j - number
                }
                arr[j + number] = temp
            }
            number = number / 2
        }
    }
}

//: [Next](@next)
