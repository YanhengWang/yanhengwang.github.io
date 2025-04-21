---
layout: linear
date: 10 March 2025
title: (Min,+) Matrix Product → Negative Triangle
returnPage: ./
---

Negative Triangle is a decision problem, whereas (Min,+) Product outputs $$n^2$$ integers. We need several intermediate problems to bridge this gap. The first step is to turn Negative Triangle into a search problem:

> **Negative Triangle Search**
>
> Given a weighted complete tripartite graph, return a negative triangle if one exists, or report "no" otherwise.

The second step is to move to an enumeration variant:

> **All-Edge Negative Triangle**
>
> Given a weighted complete tripartite graph $$(I \cup J \cup K, w)$$, decide for each $$ij \in I \times J$$ whether there exists $$k \in K$$ such that $$w(i,j) + w(j,k) + w(k,i) < 0$$; if yes then further output a witness $$k$$.

And in the last step we will pass to (Min,+) Matrix Product.

# Negative Triangle Search → Negative Triangle

Let $$I,J,K$$ be the three parts in the input graph $$G$$. We evenly partition $$I = I_1 \cup I_2$$, $$J = J_1 \cup J_2$$ and $$K = K_1 \cup K_2$$. For each $$a,b,c \in \{1,2\}$$ we solve Negative Triangle on $$G[I_a, J_b, K_c]$$. If none returns true, then we report "no". Otherwise, we select any one of the true instance(s) and recurse into it.

Let $$t(n) = n^{\alpha}$$ be the time complexity of solving Negative Triangle, and $$s(n)$$ be the running time of the above algorithm. Then we have the recursion $$s(n) \leq 8 t(n) + s(n/2)$$. Hence

$$ s(n) \leq 8 (t(n) + t(n/2) + t(n/4) + \cdots + t(1)). $$

Recall that $$\alpha \geq 1$$, so $$t(n/2^i) \leq t(n)/2^i$$, and thus

$$ s(n) \leq 8 t(n) \cdot \left(1 + \frac{1}{2} + \frac{1}{4} + \cdots \right) \leq 16 t(n).$$

Therefore, any subcubic algorithm for Negative Triangle implies subcubic algorithm for Negative Triangle Search.

# All-Edge Negative Triangle → Negative Triangle Search

This reduction is somewhat surprising and contains an elegant idea. We partition $$I =: I_1 \cup \cdots \cup I_g$$ into $$g$$ groups, each containing $$n/g$$ vertices. Partition $$J$$ and $$K$$ likewise. Then we do the following.

- for each $$1 \leq a, b \leq g$$:
	- for $$1 \leq c \leq g$$:
		- while $$G[I_a, J_b, K_c]$$ contains a negative triangle $$ijk$$:
			- print "yes" as the answer to edge $$ij$$
			- remove edge $$ij$$ from the graph (or effectively, set $$w(i,j) = \infty$$)

It is clear that the algorithm solves All-Edge Negative Triangle correctly. What about its running time? Consider any fixed $$a,b$$. Let $$T(m)$$ be the time of solving Negative Triangle Search on $$m$$ vertices, so each test of the while-loop condition costs $$O(T(n/g))$$ time. Observe that (for fixed $$a,b$$) the condition is true for at most $$(n/g)^2$$ times, since all edges between $$I_a, J_b$$ would have been removed by then. On the other hand, the condition is false for at most $$g$$ times, since $$c$$ would increase in such situation. Hence the total cost of the inner for-loop is bounded by $$O(((n/g)^2 + g) T(n/g))$$. There are $$g^2$$ outer iterations, so the overall cost is $$O((n^2 + g^3) T(n/g))$$.

Now we choose $$g := n^{2/3}$$ to balance the two terms. The cost then simplifies to $$O(n^2 T(n^{1/3}))$$. If $$T(m) = m^{3-\epsilon}$$ for some $$\epsilon > 0$$, then we can solve All-Edge Negative Triangle in time $$O(T(n^{3 - \epsilon/3}))$$.

We mention that the idea is generally applicable in other contexts where we want to efficiently reduce an enumeration problem to a decision counterpart.

# (Min,+) Matrix Product → All-Edge Negative Triangle

Let $$A,B$$ be the input matrices. Fix some integer $$N$$ greater than the largest absolute entry in $$A,B$$. We will employ a (parallel) binary search strategy to compute the product $$AB$$. Initialize a lower bound matrix $$L$$ with all entries being $$-N$$, and an upper bound matrix $$U$$ with all entries being $$N$$. In each step of the binary search, we compute the entry-wise mean $$C := (L+R)/2$$ as our current guess. To determine the direction of move, we build a complete tripartite graph on $$I \cup J \cup K$$. Assign $$w(i,k) := A_{ik}$$ for each $$ik \in I \times K$$ and similarly $$w(k,j) := B_{kj}$$ for each $$kj \in K \times J$$. We use our guessed matrix to define the remaining weights: $$w(i,j) := -C_{ij}$$ for each $$ij \in I \times J$$. Then we run All-Edge Negative Triangle on this graph.

Note that $$w(i,j) + w(i,k) + w(k,j) < 0$$ simply says $$C_{ij} > A_{ik} + B_{kj}$$. Hence, a fixed edge $$ij$$ is contained in some negative triangle iff the guessed entry $$C_{ij}$$ is larger than it should be. Using the output of All-Edge Negative Triangle, we can decide whether to increase the lower bound or to decrease the upper bound at entry $$ij$$.

The binary search should terminate within $$\log n$$ steps. In each step, constructing the guess matrix and the graph costs quadratic time only; so is the adjustment on lower/upper bounds. The time is thus dominated by All-Edge Negative Triangle. If it takes truly subcubic time, then the overall algorithm is truly subcubic as well.
