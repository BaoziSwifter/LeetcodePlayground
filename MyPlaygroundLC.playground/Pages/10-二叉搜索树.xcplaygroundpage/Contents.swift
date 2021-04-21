//: [Previous](@previous)
// 二叉搜索树（Binary Search Tree，后文简写 BST）
// 特性
/**
 1、对于 BST 的每一个节点 node，左子树节点的值都比 node 的值要小，右子树节点的值都比 node 的值大。

 2、对于 BST 的每一个节点 node，它的左侧子树和右侧子树都是 BST。
 3、 BST 的中序遍历结果是有序的（升序）
 */

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

class BSTSolution {
    var i = 0
    var finalVal:Int?
    func kthSmallest(_ r: TreeNode?, _ k: Int) -> Int {
        func kth(_ root: TreeNode?) {
            if root == nil {
                return
            }

            kth(root?.left)
            i += 1
            if k == i {
                finalVal = root?.val
                return
            }
            kth(root?.right)

        }
        kth(r)
        return finalVal ?? 0
    }

    // leetcode 538 二叉搜索树转换成累加树
    var sumV = 0
    func convertBST(_ root: TreeNode?) -> TreeNode? {

        guard let r = root else {
            return nil
        }

        convertBST(r.right)
        sumV += r.val
        r.val = sumV
        convertBST(r.left)
        return r
    }

}

//: [Next](@next)
