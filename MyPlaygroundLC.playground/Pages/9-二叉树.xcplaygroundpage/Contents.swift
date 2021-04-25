//: [Previous](@previous)

// 快速排序就是二叉树的前序遍历 并归排序就是二叉树的后续遍历
public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public var next: TreeNode?
    public init() { self.val = 0; self.left = nil; self.right = nil; }
    public init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
    public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
        self.val = val
        self.left = left
        self.right = right
    }
}

class TreeNodeSolution {
    func countOfTreeNode(_ root: TreeNode?) -> Int {
        if root == nil {
            return 0
        }
        return 1 +
            countOfTreeNode(root?.left) +
            countOfTreeNode(root?.right)
    }

    func invertTree(_ root: TreeNode?) -> TreeNode? {
        if root == nil {
            return nil
        }

        let tmp = root?.left
        root?.left = root?.right
        root?.right = tmp

        invertTree(root?.left)
        invertTree(root?.right)
        return root
    }

    // leetcode 116 填充 完美二叉树的下一个右侧节点
    func connect(_ root: TreeNode?) -> TreeNode? {
        if root == nil {
            return nil
        }
        connectTwo(root?.left, root?.right)
        return root
    }
    func connectTwo(_ left: TreeNode?, _ right: TreeNode?) {
        if left == nil || right == nil {
            return
        }
        // 前序遍历
        left?.next = right

        connectTwo(left?.left, left?.right)
        connectTwo(right?.left, right?.right)
        // 跨父节点链接
        connectTwo(left?.right, right?.left)
    }

    // leetcode 114 二叉树展开为链表
    func flatten(_ root: TreeNode?) {
        if root == nil {
            return
        }

        // 后序遍历的思想
        flatten(root?.left)
        flatten(root?.right)

        let left = root?.left
        let right = root?.right

        // 将左子树作为右子树
        root?.left = nil
        root?.right = left

        // 将原来的右子树接到当前右子树的末端
        var p = root
        while p?.right != nil {
            p = p?.right
        }
        p?.right = right

    }

    // leetcode 654 构造最大二叉树
    // 入口函数
    func constructMaxmumBinaryTree(_ nums: [Int]) -> TreeNode? {
        return build(nums, low: 0, hig: nums.count-1)
    }

    func build(_ nums: [Int],low: Int, hig: Int) -> TreeNode? {
        if low > hig {
            return nil
        }
        // 找到数组中的最大值
        var maxVal = Int.min
        var index = -1
        for i in low...hig {
            if maxVal < nums[i] {
                index = i
                maxVal = nums[i]
            }
        }
        let root = TreeNode(maxVal)
        root.left = build(nums, low: low, hig: index-1)
        root.right = build(nums, low: index+1, hig: hig)
        return root
    }


    // TODO 利用前序和中序构造出树  or 利用中序和后序构造出树
}

// 遍历
class TraveralTree {
    // 前序
    func preOrderTraveral(_ root: TreeNode?) -> [TreeNode]? {
        if root == nil {
            return nil
        }
        var arr = [TreeNode]()
        var res = [TreeNode]()
        arr.append(root!)
        while arr.isEmpty == false {
            let item = arr.removeLast()
            res.append(item)
            if let r = item.right {
                arr.append(r)
            }
            if let l = item.left {
                arr.append(l)
            }
        }
        return res
    }

    // 后续
    func postOrderTraveral(_ root: TreeNode?) -> [TreeNode]? {
        if root == nil {
            return nil
        }
        var arr = [TreeNode]()
        var res = [TreeNode]()
        arr.append(root!)
        while arr.isEmpty == false {
            let item = arr.removeLast()
            res.append(item)

            if let l = item.left {
                arr.append(l)
            }
            if let r = item.right {
                arr.append(r)
            }

        }
        return res.reversed()
    }

    // 中序
    func midOrderTraveral(_ root: TreeNode?) -> [TreeNode]? {
        if root == nil {
            return nil
        }
        var arr = [TreeNode]()
        var res = [TreeNode]()
        var node = root
        while !arr.isEmpty || node != nil {
            if node != nil {
                while node != nil {
                    arr.append(node!)
                    node = node?.left
                }
            } else {
                node = arr.removeLast()
                res.append(node!)
                node = node?.right
            }

        }
        return res

    }

    // 层序
    func levelTraveral(_ root: TreeNode?) -> [TreeNode]? {
        if root == nil {
            return nil
        }
        var levelArray = [TreeNode]()
        var res = [TreeNode]()
        levelArray.append(root!)

        while !levelArray.isEmpty {
            var l = [TreeNode]()
            for n in levelArray {
                res.append(n)
                if let left = n.left {
                    l.append(left)
                }
                if let right = n.right {
                    l.append(right)
                }
            }
            levelArray = l

        }
        return res
    }
}
//: [Next](@next)
