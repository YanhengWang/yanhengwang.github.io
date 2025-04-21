---
layout: linear
date: 13 March 2025
title: Triangle ↔ Vertex Negative Triangle
returnPage: ./
---

The → direction is trivial.

For the ← direction, we will actually reduce the more general optimisation problem of *Vertex Min-Weight Triangle* to Triangle. To this end, we describe a recursive algorithm $$A$$ that takes as input a vertex-weighted tripartite graph $$G = (I \cup J \cup K, E, w)$$ and returns a triangle in $$G$$ of minimum weight.

In the base case $$I, J, K$$ are singletons, and we solve the instance by brute-force. Otherwise we do the following. Sort $$I = (i_1, \dots, i_n)$$ by vertex weights so that $$w(i_1) \leq \cdots \leq w(i_n)$$. Then split the sequence evenly into groups $$I_1, \dots, I_g$$ where $$g$$ is some absolute constant to be defined later. So we have $$I_1 = (i_1, \dots, i_{n/g})$$, $$I_2 = (i_{n/g+1}, \dots, i_{2n/g})$$ and so on. Process $$J$$ and $$K$$ similarly. Next compute the set of triples

$$S := \{(a,b,c) \in [g]^3 : G[I_a, J_b, K_c] \text{ contains a triangle}\}.$$

The key insight is as follows. Consider any $$(a,b,c), (a',b',c') \in S$$ such that $$a'>a, b'>b, c'>c$$. Observe that all triangles in $$G[I_{a'}, J_{b'}, K_{c'}]$$ have larger weights than any triangle in $$G[I_{a'}, J_{b'}, K_{c'}]$$, so they do not qualify for the minimum-weight triangle. We thus say that $$(a,b,c)$$ *shadows* $$(a',b',c')$$.

Let us compute the subset of triples $$R \subseteq S$$ that are not shadowed by any other triple in $$S$$. By the discussion above, the minimum-weight triangle must come from the graph induced by one of these triples. So we recursively call $$A(G[I_a, J_b, K_c])$$ for all $$(a,b,c) \in R$$ and take the minimum-weight triangle among these.

It remains to analyse the running time. Let $$n^{\beta}$$ be the time of solving Triangle; currently $$2.37 < \beta < 2.38$$ (using fast matrix multiplication). Denote by $$t(n)$$ the running time of algorithm $$A$$. Sorting takes $$O(n \log n)$$ time; computing $$S$$ takes $$g^3 (n/g)^{\beta} = O(n^{\beta})$$ time as $$g$$ is a constant; computing $$R$$ takes constant time. So we have

$$ t(n) = O(n^{\beta}) + \card{R} \cdot t(n/g). $$

How large can $$\card{R}$$ be? Let us identify tuples with points in 3D space. Consider the collection of all lines in direction $$(1,1,1)$$ intersecting with the grid $$[g]^3$$. For any two points on the same line, one must shadow the other. So each line may contribute at most one point to $$R'$$. On the other hand, there are up to $$4g^2$$ lines: With varying $$p,q \in \{-g+1, \dots, g\}$$, the lines $$\ell_{p,q} := \{(\lambda, \lambda+p, \lambda+q) : \lambda \in \Real \}$$ cover every point in $$[g]^3$$. This shows that $$\card{R} \leq 4g^2$$.

Now we go back to the recursion. We choose $$g > 4^{\frac{1}{\beta-2}}$$ to ensure that $$\frac{\log(4g^2)}{\log g} < \beta$$. Then master theorem implies $$t(n) = O(n^{\beta})$$. In other words, any advances in Triangle (i.e., improving $$\beta$$) would also bring down the time for Vertex Min-Weight Triangle, and thus also Vertex Negative Triangle.

*Remark.* In light of the equivalence, Vertex Negative Triangle is much easier than Negative Triangle. This is not at surprise, since the vertex-weighted version is more "additive" and exhibits monotonicity which the edge-weighted version lacks.
