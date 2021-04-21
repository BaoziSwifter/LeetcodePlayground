//: [Previous](@previous)

class NSum{
    // 双指针法
    func twoSum(nums: [Int], target: Int) -> [Int] {
        let anNums = nums.sorted { (a, b) -> Bool in
            return a > b
        }
        var left = 0, right = nums.count - 1
        while left < right {
            let a = anNums[left], b = anNums[right]
            let sum = a + b
            if sum < target {
                left += 1
            } else if sum > target {
                right -= 1
            } else {
                return [left, right]
            }
        }
        return [Int]()
    }

    // 双指针法  返回所有满足两数之和的下标  不能重复
    func twoSum(nums: [Int], target: Int) -> [[Int]] {
        let anNums = nums.sorted()
        var res = [[Int]]()
        var left = 0 , right = nums.count - 1
        while left < right {
            let a = anNums[left], b = anNums[right]
            let sum = a + b
            if sum < target {
                left += 1
                while left < right && anNums[left] == a {
                    left += 1
                }
            } else if sum > target {
                right -= 1
                while left < right && anNums[right] == b {
                    right -= 1
                }
            } else {
                res.append([a, b])
                left += 1
                while left < right && nums[left] == a {
                    left += 1
                }
                right -= 1
                while left < right && nums[right] == b {
                    right -= 1
                }
            }
        }

        return res
    }
}

//: [Next](@next)
