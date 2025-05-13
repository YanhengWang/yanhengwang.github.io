---
layout: linear
date: 4 May 2025
title: q-Clique → Triangle
returnPage: ./
---

Let $$G = (V_1 \cup \cdots \cup V_q, E)$$ be the input to q-Clique.  We define a tripartite graph $$G' = (A \cup B \cup C, E')$$ as follows. Each vertex $$a \in A$$ corresponds to a clique in $$G[V_1, \dots, V_{q/3}]$$, each vertex $$b \in B$$ corresponds to a clique in $$G[V_{q/3+1}, \dots, V_{2q/3}]$$, and each vertex $$c \in C$$ corresponds to a clique in $$G[V_{2q/3+1}, \dots, V_q]$$. We connect an edge in $$E'$$ between two vertices if their corresponding cliques have full connections in $$E$$.

Clearly $$G'$$ contains a triangle if and only if $$G$$ contains a $$q$$-clique. Hence the problem reduces to solving Triangle on $$G'$$. Note that $$\card{A}, \card{B}, \card{C} \leq n^{q/3}$$ and the edge set $$E'$$ can thus be constructed in time $$O(n^{2q/3})$$. If Triangle on a graph with $$N$$ vertices can be solved in time $$O(N^\beta)$$ for some $$2 \leq \beta < 3$$, then q-Clique can be solved in time $$O(n^{2q/3} + (n^{q/3})^\beta) = O(n^{\beta q / 3})$$.
