---
layout: linear
date: 22 March 2025
title: Orthogonal Vector → Diameter
returnPage: ./
---

Given two sets $$A, B \subseteq \{0,1\}^d$$, each of cardinality $$n$$, we construct a three-layer graph $$G = (A \cup [d] \cup B, E)$$ as follows. The left layer is simply $$A$$; that is, each vertex is a vector from $$A$$. Similarly, the right layer is $$B$$. The middle layer is $$[d] = \{1, \dots, d\}$$.

For each $$a = (a_1, \dots, a_d) \in A$$ and $$i \in [d]$$, we connect an edge $$ai$$ iff $$a_i = 1$$. Symmetrically, for each vertex $$b = (b_1, \dots, b_d) \in B$$ and $$i \in [d]$$, we connect an edge $$ib$$ iff $$b_i = 1$$. Finally, we connect every pair of vertices in the middle layer.

Apparently every vertex in the middle layer is within distance 2 of any vertex in $$G$$. Next, consider vertices $$a \in A$$ and $$b \in B$$. Their distance is 2 if they share a common neighbour, or 3 otherwise. Note that they share a common neighbour iff $$\inner{a}{b} = 0$$. Therefore, there exists a pair of orthogonal vectors iff $$G$$ has diameter 3.

The graph $$G$$ contains $$m = nd + \binom{d}{2}$$ edges and can be constructed in $$O(m)$$ time. If there is an $$O(m^{2-\epsilon})$$-time algorithm for Diameter, then we can solve Orthogonal Vector in $$O((nd + d^2)^{2-\epsilon}) = O(n^{2-\epsilon'})$$ time.
