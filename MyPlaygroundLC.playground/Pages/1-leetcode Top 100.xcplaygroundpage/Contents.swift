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

//: [Next](@next)
