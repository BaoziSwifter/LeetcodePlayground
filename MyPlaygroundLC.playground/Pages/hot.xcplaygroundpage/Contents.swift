//: [Previous](@previous)

// 链表
public class ListNode:Equatable {
    public var val = 0
    public var next: ListNode?
    public init(_ v: Int) {
        self.val = v
        self.next = nil
    }
    public init(_ val: Int,_ next: ListNode?) {
        self.val = val
        self.next = next
    }

    public static func ==(lhs: ListNode, rhs: ListNode) -> Bool {
        return lhs.val == rhs.val
    }
}

// 翻转链表
// 翻转整个链表
// 递归方式
func recursion_reverseList(_ head: ListNode?) -> ListNode? {
    if head?.next == nil {
        return head
    }
    let lastNode = recursion_reverseList(head?.next)
    head?.next?.next = head
    head?.next = nil
    return lastNode
}

// 翻转整个链表 非递归
func norecursion_reverseList(_ head: ListNode?) -> ListNode? {
    var pre: ListNode?, h:ListNode?
    h = head
    while h != nil {
        let t = h?.next
        h?.next = pre
        pre = h
        h = t
    }
    return pre
}
// 翻转前n个节点 递归
func recursion_reverseN(_ head: ListNode?, n: Int) -> ListNode? {
    // base case 变为 n == 1，反转一个元素，就是它本身，同时要记录后驱节点。
    if n == 1 {
        return head
    }
    let lastNode = recursion_reverseN(head?.next, n: n-1)
    head?.next?.next = head
    head?.next = nil
    return lastNode
}

// 翻转前n个链表 非递归
func norecursion_reverseN(_ head: ListNode?, n: Int) -> ListNode? {
    if n < 2 {
        return head
    }
    var i = 0
    var head = head, pre: ListNode? = nil
    let first = head
    while i < n {
        let t = head?.next
        head?.next = pre
        pre = head
        head = t
        i += 1
    }
    first?.next = head
    return pre

}

// 反转链表的一部分 递归
func reverseBetween(_ head: ListNode?, begin: Int, end: Int) -> ListNode? {
    if begin == 1 {
        return recursion_reverseN(head, n: end)
    }
    let head = head
    head?.next = reverseBetween(head?.next, begin: begin-1, end: end-1)
    return head
}

// 反转链表的一部分 非递归
func no_reverseBetween(_ head: ListNode?, m: Int, n: Int) -> ListNode? {
    guard m <= n || head != nil else {
        return nil
    }

    let dumy:ListNode? = ListNode(0)
    dumy?.next = head

    var pre = dumy
    for _ in 0..<m-1 {
        pre = pre?.next
    }
    let cur = pre?.next
    for _ in m..<n {
        let next = cur?.next
        cur?.next = next?.next
        next?.next = pre?.next
        pre?.next = next
    }
    return dumy?.next


}

// k个一组翻转 递归
func reverseKGroup(_ head: ListNode?, k: Int) -> ListNode? {

    if head == nil {
        return nil
    }
    var a = head, b = head
    for _ in 0..<k {
        if b == nil {
            return head
        }
        b = b?.next
    }
    let newHead = reverseForGroup(a,b: b)
    a?.next = reverseKGroup(b, k: k)
    return newHead
}

func reverseForGroup(_ a:ListNode?,b:ListNode?) -> ListNode? {

    var pre:ListNode?, cur:ListNode?, nxt:ListNode?

    pre = nil
    cur = a
    nxt = a
    while cur != b {
        nxt = cur?.next
        cur?.next = pre
        pre = cur
        cur = nxt
    }
    return pre

}

// k个一组翻转 非递归
func norecursion_reverseKGroup(_ head: ListNode?, _ k: Int) -> ListNode? {
    let dummy = ListNode(-1)
    dummy.next = head
    var pre: ListNode? = dummy
    var end: ListNode? = dummy

    while end?.next != nil {
        for _ in 1...k {
            end = end?.next
        }

        if end == nil {
            break
        }

        let start = pre?.next
        let next = end?.next
        end?.next = nil
        pre?.next = reverse(start)
        start?.next = next
        pre = start
        end = pre
    }

    return dummy.next
}

func reverse(_ head: ListNode?) -> ListNode? {
    var pre: ListNode? = nil
    var curr = head
    while curr != nil {
        let next = curr?.next
        curr?.next = pre
        pre = curr
        curr = next
    }
    return pre
}


// 向右移动k位
func rotateRight(_ head: ListNode?, _ k: Int) -> ListNode? {
    var end = head
    var began = reverse(head)
    for _ in 0..<k {
        let tmp = began
        began = began?.next
        end?.next = tmp
        tmp?.next = nil
        end = tmp
    }


    return reverse(began)

}

func rotateRight_circle(_ head: ListNode?, _ k: Int) -> ListNode? {
    var last: ListNode? = head
    var length = 1
    while last?.next != nil {
        last = last?.next
        length += 1
    }
    last?.next = head

    //2.找到新的头结点
    var step = length - k % length
    var newHead = head
    var newTail = last
    while step != 0 {
        step -= 1
        newHead = newHead?.next
        newTail = newTail?.next
    }

    //3.从新的头节点前节点处断开环
    newTail?.next = nil

    return newHead

}

// 环形链表
func hasCycle(_ head: ListNode?) -> Bool {

    var slow: ListNode? = head
    var fast: ListNode? = head

    while slow != nil && fast != nil   {
        if slow === fast {
            return true
        }
        slow = slow?.next
        fast = fast?.next?.next
    }
    return false

}


// 返回环形链表的第一个节点
func detectCycle(_ head: ListNode?) -> ListNode? {
    var slow: ListNode? = head
    var fast: ListNode? = head
    while slow !== fast {
        slow = slow?.next
        fast = fast?.next?.next
    }
    if slow == nil {
        return nil
    }
    var g = head
    while g !== slow {
        g = g?.next
        slow = slow?.next
    }
    return g
}

// 链表相交的第一个节点
func getIntersectionNode(_ headA: ListNode?, _ headB: ListNode?) -> ListNode? {
    if headA == nil || headB == nil {
        return nil
    }
    var pA :ListNode? = headA
    var pB :ListNode? = headB

    while pA !== pB {
        pA = (pA == nil) ? headB : pA?.next
        pB = (pB == nil) ? headA : pB?.next
    }
    return pA
}

// 并轨排序链表 leetcode 148
func sortList(_ head: ListNode?) -> ListNode? {
    if head == nil || head?.next == nil {
        return head
    }
    var slow: ListNode? = head
    var fast: ListNode? = head?.next
    while fast != nil && fast?.next != nil {
        fast = fast?.next?.next
        slow = slow?.next
    }
    let mid = slow?.next
    slow?.next = nil

    var left = sortList(head)
    var right = sortList(mid)
    var dumy = ListNode(0)
    let res = dumy
    while left != nil && right != nil {
        if left!.val < right!.val {
            dumy.next = left
            left = left?.next
        } else {
            dumy.next = right
            right = right?.next
        }
        dumy = dumy.next!
    }
    dumy.next = (left != nil) ? left : right
    return res.next
}

func middleNode(_ head: ListNode?) -> ListNode? {
    if head == nil || head?.next == nil {
        return head
    }
    var slow = head
    var fast = head?.next
    while fast != nil {
        slow = slow?.next
        fast = fast?.next?.next
    }
    return slow
}

// 移除倒数第N个
func removeNthFromEnd(_ head: ListNode?, n :Int) -> ListNode? {
    let dumy = ListNode(1)
    dumy.next = head
    var fast = head, slow:ListNode? = dumy

    for _ in 0..<n {
        fast = fast?.next
    }
    while fast != nil {
        fast = fast?.next
        slow = slow?.next
    }
    slow?.next = slow?.next?.next

    return dumy.next
}




// leetcode 232 用栈实现队列
class Soulution_232 {
    class MyQueue {
        var inStack:[Int]
        var outStack:[Int]
        /** Initialize your data structure here. */
        init() {
            inStack = [Int]()
            outStack = [Int]()
        }
        
        func move(_ toOut:Bool = true) {
            if toOut ==  true {
                while !inStack.isEmpty {
                    outStack.append(inStack.popLast()!)
                }
            } else {
                while !outStack.isEmpty {
                    inStack.append(outStack.popLast()!)
                }
            }
        }
        
        /** Push element x to the back of queue. */
        func push(_ x: Int) {
            if !outStack.isEmpty {
                move(false)
            }
            inStack.append(x)
        }
        
        /** Removes the element from in front of queue and returns that element. */
        func pop() -> Int {
            if !inStack.isEmpty {
                move()
            }
            return outStack.popLast() ?? -1
        }
        
        /** Get the front element. */
        func peek() -> Int {
            if !inStack.isEmpty {
                move()
            }
            return outStack.last ?? -1
        }
        
        /** Returns whether the queue is empty. */
        func empty() -> Bool {
            return inStack.isEmpty && outStack.isEmpty
        }
    }

    /**
     * Your MyQueue object will be instantiated and called as such:
     * let obj = MyQueue()
     * obj.push(x)
     * let ret_2: Int = obj.pop()
     * let ret_3: Int = obj.peek()
     * let ret_4: Bool = obj.empty()
     */
}

// leetcode offer 09 两个栈实现队列
extension Soulution_232.MyQueue {
    func appendTail(_ value: Int) {
        self.push(value)
       }
       
       func deleteHead() -> Int {
        self.move()
        return self.outStack.popLast() ?? -1
       }
}





//: [Next](@next)
