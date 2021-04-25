//: [Previous](@previous)
public class ListNode:Equatable {
    public var val = 0
    public var next: ListNode?
    public init(v: Int) {
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

class MyLinkNode {

    // 翻转整个链表 递归
    func recursion_reverseList(_ head: ListNode?) -> ListNode? {

        if head?.next == nil {
            return head
        }
        let last = recursion_reverseList(head?.next)
        head?.next?.next = head
        head?.next = nil
        return last
    }

    // 翻转整个链表 非递归
    func norecursion_reverseList(_ head: ListNode?) -> ListNode? {
        var h = head, pre:ListNode? = nil
        while h != nil {
            let t = h?.next
            h?.next = pre
            pre = h
            h = t
        }
        return pre
    }

    // 翻转前n个节点 递归
    var passNode: ListNode? = nil
    func recursion_reverseN(_ head: ListNode?, n: Int) -> ListNode? {
        // base case 变为 n == 1，反转一个元素，就是它本身，同时要记录后驱节点。
        if n == 1 {
            passNode = head?.next
            return head
        }
        let lastNode = recursion_reverseN(head?.next, n: n-1)
        head?.next?.next = head
        head?.next = passNode
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
    // 反转链表的一部分
    func reverseBetween(_ head: ListNode?, begin: Int, end: Int) -> ListNode? {
        if begin == 1 {
            return recursion_reverseN(head, n: end)
        }
        let head = head
        head?.next = reverseBetween(head?.next, begin: begin-1, end: end-1)
        return head
    }

    // k个一组翻转
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


    // 判断是否是回文链表 递归
    var flagLeft:ListNode?
    func isPalindrome(_ head: ListNode?) -> Bool {
        flagLeft = head
        return palindromTravese(head)
    }
    func palindromTravese(_ right: ListNode?) -> Bool {
        if right == nil {
            return true
        }
        var res = palindromTravese(right?.next)
        res = res && (right?.val == flagLeft?.val)
        flagLeft = flagLeft?.next
        return res
    }

    // 判断 是否回文链表 双指针
    // TODO 

}

//: [Next](@next)
