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
//            let a = last + cur
//            last = cur
//            cur = a
//            print("-----\(cur)")
            (last, cur) = (cur, cur+last)
        }
        return cur

    }
}

class CollectionMoney {
    func badCollectionMoney(coins: [Int], target: Int) -> Int {
        if target <= 0 {
            return 0
        }
        if target == 1 {
            return 1
        }

        var res = Int.max
        for coin in coins {
            let sub = badCollectionMoney(coins: coins, target: target-coin)
            if sub == -1 {
                continue
            }
            res = min(res, 1+sub)
        }
        return res == Int.max ? -1 : res
    }

    func goodCollectionMoey(coins: [Int], target: Int) -> Int {
        if target < 0 {
            return -1
        }
        if target == 0 {
            return 0
        }
        var dp = [Int](repeating: 0, count: target+1)
        dp[1] = 1

        for i in 1...target {
            for c in coins {
                guard i - c >= 0 else{
                    continue
                }
                dp[i] = min(dp[i], 1+dp[i-c])
            }
        }
        return dp[target]
    }
}

class SolutionThreeSum {
    func threeSum(_ nums: [Int]) -> [[Int]] {
        if nums.count < 3 {
            return []
        }
        var sortNum = nums
        sortNum.sort()
        var res = [[Int]]()
        for i in 0..<sortNum.count-2 {
            if sortNum[i] > 0 {
                break
            }
            if i > 0 && sortNum[i] == sortNum[i-1] {
                continue
            }
            var l = i + 1
            var r  = nums.count - 1
            while l < r {
                let result = sortNum[i]+sortNum[l]+sortNum[r]
                if result == 0 {
                    res.append([sortNum[i],sortNum[l],sortNum[r]])
                    repeat {
                        l += 1
                    } while l < r && sortNum[l] == sortNum[r]
                    repeat {
                        r -= 1
                    } while l < r && sortNum[r] == sortNum[r+1]

                } else if result < 0 {
                    repeat {
                        l += 1
                    } while l < r && sortNum[l] == sortNum[l-1]
                } else {
                    repeat {
                        r -= 1
                    } while l < r && sortNum[r] == nums[r+1]
                }
            }
        }
        return res
    }
}

// leetcode 1 两数之和
class TwoSum{
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        var map = [Int:Int]()
        for (index, val) in nums.enumerated() {
            let t = target - val
            guard let r = map[t] else {
                map[val] = index
                continue
            }
            return [r,index]
        }
        return []
    }
}
// leetcode 2 两数相加
class TwoNumAdd {
    public class ListNode {
        public var val: Int
        public var next: ListNode?
        public init() { self.val = 0; self.next = nil; }
        public init(_ val: Int) { self.val = val; self.next = nil; }
        public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
    }
    func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        var l1 = l1
        var l2 = l2
        var needAddOne = 0

        let fakeHead = ListNode(-1)
        var cur = fakeHead
        while l1 != nil || l2 != nil {
            let new = (l1?.val ?? 0) + (l2?.val ?? 0) + needAddOne
            cur.next = ListNode(new%10)
            needAddOne = new / 10
            cur = cur.next!
            l1 = l1?.next
            l2 = l2?.next
        }
        if needAddOne == 1 {
            cur.next = ListNode(1)
        }
        return fakeHead.next

    }
}

// leetcode 3 无重复的最长子串
class NoRepeatMaxLengthSubString {
    func lengthOfLongestSubstring_1(_ s: String) -> Int{
    if s.isEmpty {return 0}
    let charArr = Array(s.utf8)
    var start = 0, end = 0, i = 0, maxLength = 0
    while end < charArr.count {
        i = start
        while i < end { //遍历start 到end 是否有重复 三指针滑动窗口
            if charArr[i] == charArr[end] {
                start = i + 1
                break
            }
            i += 1
        }
            maxLength = max(maxLength, end - start + 1)
            end += 1
        }
        return maxLength
    }
    func lengthOfLongestSubstring(_ s: String) -> Int {
        var window = [Character: Int]()
        var res = 0
        var left = 0
        var right = 0
        let strArr = Array(s)

        while left < strArr.count, right < strArr.count {
            let c = strArr[right]
            if !window.keys.contains(c) {
                window[c] = 0
            }
            window[c]! += 1
            right += 1
            while window[c]! > 1 {
                let c2 = strArr[left]
                if !window.keys.contains(c2) {
                    window[c2] = 0
                }
                window[c2]! -= 1
                left += 1
            }
            res = max(res, right-left)
        }
        return res
    }
}

// leetcode 4 寻找正序数组的中位数
class FinMidNumInTwoArray {
    func findMedianSortedArrays(_ nums1: [Int], _ nums2: [Int]) -> Double {
        let cnt = nums2.count + nums1.count
        var n1 = 0
        var n2 = 0
        var lastVal = 0
        var curVal = 0

        while n1 + n2 <= cnt / 2 {
            lastVal = curVal
            if n2 >= nums2.count || (n1 < nums1.count && nums1[n1] <= nums2[n2]) {
                curVal = nums1[n1]
                n1 += 1
            } else {
                curVal = nums2[n2]
                n2 += 1
            }
        }
        if cnt % 2 == 0 {
            return Double(lastVal + curVal) / 2
        }
        return Double(curVal)
    }
}

// leetcode 5 最长回文子串
class FindLongestPalindrome {
    func longestPalindrome(_ s: String) -> String {
        let strArr = Array(s)
        let n = strArr.count
        let arr = [Bool](repeating: false, count:n)
        var dp = [[Bool]](repeating: arr, count:n)
        var maxLenth = 0
        var start = 0
        var end = 0
        for j in 0..<n {
            for i in 0...j {
                if i == j {
                    dp[i][j] = true
                    continue
                }
                if strArr[i] != strArr[j] {
                    dp[i][j] = false
                    continue
                }
                if  strArr[i] == strArr[j], (j - i < 2) || dp[i+1][j-1]  {
                    dp[i][j] = true
                    if j - i >= maxLenth {
                        start = i
                        end = j
                    }
                    maxLenth = dp[i][j] ? max(maxLenth,j - i + 1) : maxLenth
                }
            }
        }
        return String(strArr[start...end])
    }
}

// leetcode 7 翻转数字
class ReverseAnIntNum {
    func reverse(_ x: Int) -> Int {
        var l = 0;
        var sum = 0
        var x = x
        while x != 0 {
            l = x%10
            sum=sum*10+l
            x = x / 10
        }
        if sum > 2147483647 || sum < -2147483647 {
            sum = 0
        }
        return sum
    }
}

// leetcode 8 字符串转数字
class StringAtoi {
    func myAtoi(_ s: String) -> Int {
        var start = false
        var returnStr = ""
        for ch in s {
            if !start {
                if (ch.isNumber || ch == "-" || ch == "+"){
                    start = true
                    returnStr.append(ch)
                } else if ch == " "{
                    continue
                } else {
                    return 0
                }
            }else {
                if ch.isNumber {
                    returnStr.append(ch)
                } else {
                    break
                }
            }
        }
        if start == false || returnStr == "+" || returnStr == "-" {
            return 0
        }
        guard let finalInt = Int32(returnStr) else {
            return returnStr.first == "-" ? Int(Int32.min): Int(Int32.max)
        }
        return Int(finalInt)

    }
}

// leetcode 9 判断数字是否回文
class NumIsPalindrome {
    func isPalindrome(_ x: Int) -> Bool {
        if x < 0 {
            return false
        }else {
            var l = 0;
            var sum = 0
            let o = x
            var x = x
            while x != 0 {
                l = x%10
                sum=sum*10+l
                x = x / 10
            }
            return sum == o
        }

    }
}

// TODO leetcode 10 正则表达式
class StringIsMatch {
    func isMatch(_ s: String, _ p: String) -> Bool {
        let sArr = Array(s)
        let pArr = Array(p)
        var dp = Array(repeating: Array(repeating: false, count: pArr.count), count: sArr.count)

        dp[0][0] = true
        for j in 1..<dp[0].count {
            if pArr[j-1] == "*" {
                dp[0][j] = dp[0][j-1]
            }

        }
        for i in 1..<pArr.count {
            for j in 1..<sArr.count {
                if sArr[i-1] == pArr[j-1] || pArr[j-1] == "." {
                    dp[i][j] = dp[i-1][j-1]
                } else if pArr[j-1] == "*" {
                    dp[i][j] = dp[i][j-2]
                    if sArr[i-1] == pArr[j-2] || pArr[j-2] == "."{
                        dp[i][j] = dp[i][j] || dp[i-1][j]
                    }
                }
            }
        }
        return dp[sArr.count][pArr.count]
    }
}

// coin change
// Leetcode 322
class ChangeCoinSolution {
    func coinChange(coins :[Int], target :Int) -> Int {
        var dp = Array(repeating: target+1, count: target+1)
        dp[0] = 0
        for i in 1...target {
            for coin in coins {
                if i - coin >= 0 {
                    dp[i] = min(dp[i], 1+dp[i-coin])
                }
            }
        }
        return dp[target] > target ? -1 : dp[target]
    }
    func coinChangeC(_ coins: [Int], _ amount: Int) -> Int {
        if amount < 0 { return -1 }
        if amount == 0 { return 0 }

        var dp: [Int] = [Int](repeating: 0, count: amount+1)
        dp[0] = 0

        for i in 1...amount {
            var min = Int.max
            for (_, coin) in coins.enumerated() {
                if i - coin >= 0 && dp[i-coin] < min {
                    min = dp[i-coin] + 1
                }
            }
            dp[i] = min
        }

        return dp[amount] == Int.max ? -1 : dp[amount]
    }
}

// leetcode 1288 删除覆盖区间
class MergeSections {
    func removeCoverdIntervals(intvs :[[Int]]) -> Int {
        let intVS = intvs.sorted{ (a, b) -> Bool in
            if a[0] == b[0] {
                return b[1] - a[1] > 0
            }
            return a[0] - b[0] > 0
        }
        var res = 0
        var left = intVS[0][0], right = intVS[0][1]
        for i in 1..<intvs.count {
            let intv = intVS[i]
            if left <= intv[0] && right >= intv[1] {
                res += 1
            }

            if right >= intv[0] && right <= intv[1] {
                right = intv[1]
            }

            if right < intv[0] {
                left = intv[0]
                right = intv[1]
            }
        }
        return intvs.count - res

    }
}

//: [Next](@next)
