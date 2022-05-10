---
title: P7_Graph_91ca49c8ada84a90aacb943ed64d97f6
---

# P7: Graph

- DAG的判断
- 如何将DAG线性化？
    - 根据DFS的post顺序，
- connectivity
    
    [Untitled](assets/Untitled)
    
    圈内的节点是互相连通的，比如AB。然后将连通体作为一个整体，视为一个新的节点，形成新的图就是DAG。
    
    Every graph is a DAG of its SCCs (strongly connected components).
    
- 3SAT还有点迷糊