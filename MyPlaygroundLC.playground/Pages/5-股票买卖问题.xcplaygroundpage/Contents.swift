//: [Previous](@previous)

/*
 ### 相关算法
 - [字符串乘法计算](https://labuladong.gitee.io/algo/%E7%AE%97%E6%B3%95%E6%80%9D%E7%BB%B4%E7%B3%BB%E5%88%97/%E5%AD%97%E7%AC%A6%E4%B8%B2%E4%B9%98%E6%B3%95.html)
 - [如何去除有序数组的重复元素](https://labuladong.gitee.io/algo/%E9%AB%98%E9%A2%91%E9%9D%A2%E8%AF%95%E7%B3%BB%E5%88%97/%E5%8E%9F%E5%9C%B0%E4%BF%AE%E6%94%B9%E6%95%B0%E7%BB%84.html)
 - [买卖股票的最佳时机（简单）](https://leetcode-cn.com/problems/best-time-to-buy-and-sell-stock/solution/)
 - [买卖股票的最佳时机 II（简单）](https://leetcode-cn.com/problems/best-time-to-buy-and-sell-stock-ii/)
 - [买卖股票的最佳时机 III（困难）](https://leetcode-cn.com/problems/best-time-to-buy-and-sell-stock-iii/)
 - [买卖股票的最佳时机 IV（困难）](https://leetcode-cn.com/problems/best-time-to-buy-and-sell-stock-iv/)
 - [最佳买卖股票时机含冷冻期（中等）](https://leetcode-cn.com/problems/best-time-to-buy-and-sell-stock-with-cooldown/)
 - [买卖股票的最佳时机含手续费（中等）](https://leetcode-cn.com/problems/best-time-to-buy-and-sell-stock-with-transaction-fee/)


 > dp[i][k][0] = max(dp[i-1][k][0], dp[i-1][k][1]+prices[i])
 ---
 > dp[i][k][0] = max(  第i-1天选择 不交易， 选择卖出)

 > dp[i][k][1] = max(dp[i-1][k][1],dp[i-1][k-1][0]-prices[i])
 ---
 > dp[i][k][1] = max(  第i-1天持有选择不交易，第i-1不持有不交易 当天买入)
 > 基础case
 > dp[-1][k][0] = 0 因为 i是从0开始的 所以 i = -1 意味着还没开始，这时候的利润为0
 > dp[-1][k][1] = -infinity 因为还没开始的时候，不可能持有股票，用负无穷表示这种不可能
 > dp[i][0][0] = 0 因为k 是从1开始的 所以 k= 0 意味着根本不允许交易， 利润为0
 > dp[i][0][1] = -infinity 不允许交易的情况下， 不可能持有股票，用负无穷表示
 ```
 base case
 dp[-1][k][0] = dp[i][0][0] = 0
 dp[-1][k][1] = dp[i][0][1] = -infinity
 ```


*/


/**
 k = 1
 dp[i][1][0] = max(dp[i-1][1][0], dp[i-1][1][1]+prices[i])
 dp[i][1][1] = max(dp[i-1][1][1],dp[i-1][0][0]-prices[i]) = max(dp[i-1][1][1],-prices[i])  // k = 0 的base case 所以 dp[i-1][0][0] = 0


 由于k都是1 不变  去掉k
 dp[i][0] = max(dp[i-1][0], dp[i-1][1]+prices[i])
 dp[i][1] = max(dp[i-1][1], -prices[i])

 */




//: [Next](@next)


class SellBuySock {
    // k = 1
    func maxProfit_k_1(prices: [Int]) -> Int {
        let n = prices.count
        var dp = [[Int]](repeating: [Int](repeating: 0, count: 2), count: n)
        for i in 0..<n {
            if i == 0 {
                dp[0][0] = 0
                dp[0][1] = -prices[0]
                continue
            }
            dp[i][0] = max(dp[i-1][0], dp[i-1][1]+prices[i])
            dp[i][1] = max(dp[i-1][1], -prices[i])

        }
        return dp[n-1][0]
    }

    // k = 1
    func maxProfit_k_1_0(prices :[Int]) -> Int {
        let n = prices.count
        var last = 0, cur = Int.min
        for i in 0..<n {
            last = max(last, cur + prices[i])
            cur = max(cur, -prices[i])
        }
        return last
    }

    // k = 无穷大  无限制的时候
    func maxProfit_k_inf(prices :[Int]) -> Int {
        /**
         状态转移方程
         dp[i][k][0] = max(dp[i-1][k][0], dp[i-1][k][1]+prices[i])
         dp[i][k][1] = max(dp[i-1][k][1], dp[i-1][k-1][0]-prices[i])

         因为k已经没有限制 所以上边的状态转移方程可转变成
         dp[i][0] = max(dp[i-1][0], dp[i-1][1]+prices[i])
         dp[i][1] = max(dp[i-1][1], dp[i-1][0] - prices[i])
         */
        let n = prices.count
        var last = 0, cur = 0
        for i in 0..<n {
            let temp = last
            last = max(last, cur + prices[i])
            cur = max(cur, temp - prices[i])
        }
        return last
    }

    // k = 无穷大 有冷冻期
    func maxProfit_with_cool(prices :[Int]) -> Int {
        /**
         dp[i][0] = max(dp[i-1][0],dp[i-1][1]+prices[i])
         dp[i][1] = max(dp[i-1][1], dp[i-2][0]-prices[i])
         第i天选择buy的时候， 要从i-2的状态转移， 而不是 i-1
         */
        let n = prices.count
        var last = 0, cur = Int.max, pre = 0
        for i in 0..<n {
            let temp = last
            last = max(last, cur + prices[i])
            last = max(cur, pre - prices[i])
            pre = temp
        }
        return last
    }

    // 有手续费
    func maxProfit_with_fee(prices: [Int], fee: Int) -> Int {
        let n = prices.count
        var last = 0, cur = Int.max
        for i in 0..<n {
            let temp = last
            last = max(last, cur+prices[i])
            cur = max(cur, temp - prices[i] - fee) // 买入时交手续费
        }
        return last
    }

    func maxProfit_k_2(prices: [Int]) ->Int {
        let max_k = 2
        let n = prices.count
        var dp = [[[Int]]](repeating: [[Int]](repeating: [Int](repeating: 0, count: 2), count: max_k), count: n)
        for i in 0..<n {
            for k in max_k...1 {
                if i == 0 {
                    dp[i][0][0] = 0
                    dp[i][0][1] = Int.min
                    continue
                }
                dp[i][k][0] = max(dp[i-1][k][0], dp[i-1][k][1]+prices[i])
                dp[i][k][1] = max(dp[i-1][k][1],dp[i-1][k-1][0]-prices[i])
            }
        }
        return dp[n-1][max_k][0]
    }
    func maxProfit_k_any(prices: [Int], max_k: Int) -> Int {
        let n = prices.count
        if max_k > n/2 {
            return maxProfit_k_inf(prices: prices)
        }
        var dp = [[[Int]]](repeating: [[Int]](repeating: [Int](repeating: 0, count: 2), count: max_k+1), count: n)
        for i in 0..<n {
            for k in max_k...1 {
                if i == 0 {
                    dp[i][k][0] = 0
                    dp[i][k][1] = Int.min
                }
                dp[i][k][0] = max(dp[i-1][k][0], dp[i-1][k-1][1]+prices[i])
                dp[i][k][1] = max(dp[i-1][k][1], dp[i-1][k-1][0] - prices[i])
            }
        }
        return dp[n-1][max_k][0]
    }

}
