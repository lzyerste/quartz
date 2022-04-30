---
title: 331_Verify_Preorder_Serialization_of_a_Binary_Tree_63fce98d9fad4c6da64b78240cc4988e
---

# 331. Verify Preorder Serialization of a Binary Tree

Difficulty: Medium
ID: 331
Solved?: Yes
Tags: Stack
击败: 91.35
推荐指数: ⭐⭐⭐⭐

[Verify Preorder Serialization of a Binary Tree - LeetCode](https://leetcode.com/problems/verify-preorder-serialization-of-a-binary-tree/)

## 题意

One way to serialize a binary tree is to use pre-order traversal. When we encounter a non-null node, we record the node's value. If it is a null node, we record using a sentinel value such as `#`.

```
     _9_
    /   \
   3     2
  / \   / \
 4   1  #  6
/ \ / \   / \
# # # #   # #

```

For example, the above binary tree can be serialized to the string `"9,3,4,#,#,1,#,#,2,#,6,#,#"`, where `#` represents a null node.

Given a string of comma separated values, verify whether it is a correct preorder traversal serialization of a binary tree. Find an algorithm without reconstructing the tree.

Each comma separated value in the string must be either an integer or a character `'#'` representing `null` pointer.

You may assume that the input format is always valid, for example it could never contain two consecutive commas such as `"1,,3"`.

**Example 1:**

```
Input: "9,3,4,#,#,1,#,#,2,#,6,#,#"
Output: true
```

**Example 2:**

```
Input: "1,#"Output: false
```

**Example 3:**

```
Input: "9,#,#,1"Output: false
```

## 思路

1. 观察，叶子节点的左右节点都是空，也就是#，那么这个叶子节点可以退化为#，也就是空节点，看其原来的父节点是否成为了叶子节点。如此，按照逐层自底向上的方式慢慢消灭叶子节点，最后根节点也退化为叶子节点，之后再退化为一个空节点（#）。
    
    所以，利用stack，看到连续两个#，及它们之前是数字（表示叶子节点），就消除一个叶子节点，同时观察是否可以继续消除。如果是连续三个#，那么就出错了。
    
2. LeetCode上看到的另一种解法，观察空位的生成情况：具体数字占用一个位置，但新生成2个空位置，最终结果是增加了一个位置；#占用一个位置，最终结果是减少了一个位置。所以查看最后的结果是不是刚好占满，即0个位置。如果中间过程出现0个位置，那么就是出错了。初始位置有1个，即用来放root。
    
    比如"9,3,4,#,#,1,#,#,2,#,6,#,#"，刚开始时一个空位，[ _ ]，接下来进来一个9，它占据一个位置，但生成两个空位，[ 9, _ , _ ]；接下来是3，结果为[ 9 3 _ _ _ ]；接下来是4，结果为[ 9 3 4 _ _ _ _ ]；接下来是#，只占据一个位置，不产生空位，结果为[ 9 3 4 # _ _ _ ]。以此类推。 
    
    这个只对preorder有效？inorder呢？preorder是因为首先处理了root，然后是左右子树。
    

## 题解

```python
class Solution:
    def isValidSerialization(self, preorder: str) -> bool:
        stack = []
        for t in preorder.split(","):
            # <x, #> + # ==> <#>
            while t == "#" and (stack and stack[-1] == "#"):
                stack.pop()
                if stack and stack[-1] != "#":
                    stack.pop()
                else:
                    return False
            stack.append(t)  # 子树也被视为空节点#
        return stack == ["#"]
```

击败91.35%