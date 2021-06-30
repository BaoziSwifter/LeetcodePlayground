//: [Previous](@previous)

class Fib {
    func fib(n: Int) -> Int {
        if n < 1 {
            return 0
        }
        if n == 1 || n == 2 {
            return 1
        }
        var dp = Array(repeating: 0, count: n+1)
        dp[1] = 1
        dp[2] = 1
        for i in 3..<n+1 {
            dp[i] = dp[i-1] + dp[i-2]
        }
        return dp[n]
    }
    func fib_s(n: Int) -> Int {
        if n < 1 {
            return 0
        }
        var last = 0
        var cur = 1
        for _ in 0..<n-1 {
            (last, cur) = (cur, cur+last)
        }
        return cur

    }
}

// 查找两个有序数组的中位数
func FindMedianSortedArrays(_ nums1: [Int]?,_ nums2: [Int]?) -> Double{
    if nums1 == nil || nums1?.count == 0 {
        return FindMedianSortedInOneArray(nums2)
    }
    if nums2 == nil || nums2?.count == 0 {
        return FindMedianSortedInOneArray(nums1)
    }
    var nums1 = nums1, nums2 = nums2
    if let n1 = nums1, let n2 = nums2 {
        if n1.count > n2.count {
            (nums1, nums2) = (nums2, nums1)
        }
        let len1 = nums1!.count, len2 = nums2!.count
        let low = 0, high = len1
        let halfLen = (len1 + len2 + 1) / 2
        while low <= high {
            let i = (low + high) / 2
            let j = halfLen - i
            let num1LeftMax = i == 0 ? Int.min : nums1![i-1]
            let num1RightMin = i == len1 ? Int.max: nums1![i+1]
            let num2LeftMax = j == 0 ? Int.min : nums2![j-1]
            let num2RightMin = j == len2 ? Int.max : nums2![j+1]
            if num1LeftMax <= num2RightMin && num2LeftMax <= num1RightMin {
                var res = 0.0
                if (n1.count + n2.count ) % 2 == 1 {
                    return Double(num1LeftMax > num2LeftMax ? num1LeftMax : num2LeftMax)
                } else {
                    
                }
                
            }
            
        }
    }
    
    return 0
}

func FindMedianSortedInOneArray(_ nums: [Int]?) -> Double {
    
    return 0
}

//: [Next](@next)
