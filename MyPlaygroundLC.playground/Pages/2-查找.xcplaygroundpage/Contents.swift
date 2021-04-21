//: [Previous](@previous)

// 二分查找
class BinarySearch{
    func binarySearch(nums: [Int], target :Int) -> Int {
        var left = 0, right = nums.count-1
        while left <= right {
            let mid = left + (right - left) / 2
            if nums[mid] == target {
                return mid
            } else if nums[mid] < target {
                left = mid + 1
            } else if nums[mid] > target {
                right = mid - 1
            }
        }
        return -1
    }

    // 查找左侧边界的target
    func leftBoundBinarySearch(nums: [Int], target :Int) -> Int {
        var left = 0, right = nums.count - 1
        while left <= right {
            let mid = left + (right - left) / 2
            if nums[mid] < target {
                left = mid + 1
            } else if nums[mid] > target {
                right = mid - 1
            } else if nums[mid] == target {
                // 不返回 锁定左侧边界
                right = mid - 1
            }
        }
        // 检查left 越界的情况
        if left >= nums.count || nums[left] != target {
            return -1
        }
        return left
    }

    // 查找右侧边界的target
    func rightBoundBinarySearch(nums: [Int], target : Int) -> Int {
        var left = 0, right = nums.count - 1
        while left <= right {
            let mid = left + (right - left)/2
            if nums[mid] < target {
                left = mid + 1
            } else if nums[mid] > target {
                right = mid - 1
            } else if nums[mid] == target {
                // 不返回 锁定右侧边界
                left = mid + 1
            }
        }
        if right < 0 || nums[right] != target {
            return -1
        }
        return right
    }
}


//: [Next](@next)
