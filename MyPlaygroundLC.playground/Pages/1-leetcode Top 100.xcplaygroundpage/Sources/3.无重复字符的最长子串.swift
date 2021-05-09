/*
 * @lc app=leetcode.cn id=3 lang=swift
 *
 * [3] 无重复字符的最长子串
 */

// @lc code=start
class LengthOfLongestSubstringSolution {
    func lengthOfLongestSubstring(_ s: String) -> Int {
        // var window = [Character: Int]()
        // var res = 0
        // var left = 0
        // var right = 0
        // let strArr = Array(s)

        // while left < strArr.count, right < strArr.count {
        //     let c = strArr[right]
        //     if !window.keys.contains(c) {
        //         window[c] = 0
        //     }
        //     window[c]! += 1
        //     right += 1
        //     while window[c]! > 1 {
        //         let c2 = strArr[left]
        //         if !window.keys.contains(c2) {
        //             window[c2] = 0
        //         }
        //         window[c2]! -= 1
        //         left += 1
        //     }
        //     res = max(res, right-left)
        // }
        // return res
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
}
// @lc code=end

