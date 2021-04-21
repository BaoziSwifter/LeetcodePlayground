//: [Previous](@previous)

// ----- 滑动窗口
// TODO leetcode 76 最小子串
class MixLengthContainSunString {
    func findMixLengthSubString(s :String, t:String) -> String {
        // 1. 在字符串s中使用双指针中的左右指针技巧 初始化left = right = 0，把索引左闭右开[left,right)称之为一个窗口

        // 【可行解】2.先不断地增加right 指针扩大窗口[left,right) 直到窗口中的字符串复合要求
        // 【优化可行解】3. 我们停止增加right 转而不断增加left指针缩小窗口[left,right) 直到窗口中的字符串不再复合要求。同时，每次增加left，都要根新一轮结果
        // 4. 重复第2和3步 直到right 达到字符串s的尽头
        var need = [Character: Int]()
        var window = [Character: Int]()
        var left = 0, right = 0
        var valid = 0
        let s = Array(s)
        let t = Array(t)
        for c in t {
            need[c] = (need[c] != nil ) ? need[c]! + 1: 1
        }

        // 记录最小覆盖子串的起始索引以及长度
        var start = 0, len = Int.max

        while right < s.count {
            let c = s[right]
            right += 1
            if need.keys.contains(c) {
                window[c] = (window[c] != nil) ? window[c]!+1 : 1
                if window[c] == need[c]{
                    valid += 1
                }
            }

            // 判断左侧窗口是否要收缩
            while valid == need.count {
                // 更新最小覆盖子串
                if right - left < len {
                    start = left
                    len = right - left
                }
                // 将d移除窗口的字符
                let d = s[left]
                // 左侧窗口移动
                left += 1
                if need.keys.contains(d) {
                    if window[d] == need[d] {
                        valid -= 1
                    }
                    window[d]! -= 1
                }
            }
        }

        return len == Int.max ? "" : String(s[start..<start+len])
    }
}

// TODO leetcode 438 找到所有异位词
class FindAllSubStringInS {
    func findAnagrams(s: String, t:String) -> [Int] {
        var need = [Character:Int](), window = [Character:Int]()
        for c in t {
            need[c] = need[c] != nil ? need[c]!+1: 1
        }
        let s = Array(s), t = Array(t)
        var left = 0, right = 0, valid = 0
        var res = [Int]()
        while right < s.count {
            let c = s[right]
            right += 1
            // 进行窗口内数据的一系列更新
            if need.keys.contains(c) {
                window[c] = window[c] != nil ? window[c]!+1:1
                if window[c] == need[c] {
                    valid += 1
                }
            }
            // 判断 左侧窗口是否要收缩
            while right - left >= t.count {
                // 当窗口符合条件时， 把其实索引加入res
                if valid == need.count {
                    res.append(left)
                }
                let d = s[left]
                left += 1
                if need.keys.contains(d) {
                    if window[d] == need[d] {
                        valid -= 1
                    }
                    window[d] = window[d]!-1
                }
            }
        }

        return res
    }
}

// TODO leetcode 567 包含排列
class ContainSubstringSort {
    func checkInclusion(s : String, t: String) -> Bool {
        var need = [Character: Int](),window = [Character: Int]()
        for c in t {
            need[c] = need[c] != nil ? need[c]! + 1 : 1
        }
        let s = Array(s)
        let t = Array(t)

        var left = 0,right = 0,valid = 0
        while right < s.count {
            let c = s[right]
            right += 1
            if need.keys.contains(c) {
                window[c] = window[c] != nil ? window[c]! + 1 : 1
                if window[c] == need[c] {
                    valid += 1
                }
            }

            // 判断左侧窗口是否要收缩
            while right - left >= t.count {
                // 判断是否找到合法的子串
                if valid == need.count {
                    return true
                }
                let d = s[left]
                left += 1
                // 进行窗口内数据的更新
                if need.keys.contains(d) {
                    if window[d] == need[d] {
                        valid -= 1
                    }
                    window[d]! -= 1
                }
            }
        }
        return false
    }
}

// TODO leetcode 3 不重复的最长子串
class NoRepeatMaxLengthSubString1 {
    func lengthOfLongestSubstring(_ s: String) -> Int {
        var window = [Character: Int]()
        let s = Array(s)

        var left = 0, right = 0, res = 0
        while right < s.count {
            let c = s[right]
            right += 1
            // 更新window
            window[c] = window[c] != nil ? window[c]!+1:1
            // 判断左侧窗口是否需要收缩
            while window[c]! > 1 {
                let d = s[left]
                left += 1
                // 更新窗口数据
                window[d]! -= 1
            }
            res = max(res, right-left)
        }
        return res
    }
}

// 滑动窗口 -----

//: [Next](@next)
