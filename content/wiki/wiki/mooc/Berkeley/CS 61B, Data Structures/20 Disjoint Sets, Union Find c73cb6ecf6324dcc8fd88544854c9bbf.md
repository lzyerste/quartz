---
title: 20_Disjoint_Sets,_Union_Find_c73cb6ecf6324dcc8fd88544854c9bbf
---

# 20. Disjoint Sets, Union Find

[cs61b 2018 lec20 ds1 disjoint sets](https://docs.google.com/presentation/d/1J7q2RImSbg26vrWMaYQwYo6_zPDrrdGRmwm_U2oY20s/edit)

PPT

[](https://www.bilibili.com/watchlater/#/av40629353/p151)

B站视频

- `接口`
    
    ```java
    public interface DisjointSets {
    	/** Connects two items P and Q. */
    	void connect(int p, int q);
     
    	/** Checks to see if two items are connected. */
    	boolean isConnected(int p, int q);
    }
    ```
    

`Quick Find`

QuickFindDS

`Quick Union`

QuickUnionDS

`WeightedQuickUnion`

WeightedQuickUnion

`Path Compression`

PathCompressionUF