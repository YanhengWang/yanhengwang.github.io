---
layout: linear
date: 9 March 2025
title: APSP → (Min,+) Matrix Product
returnPage: ./
---

Note that the (min,+) product as a binary operation is associative, so the exponentiation $$A^t$$ is well-defined.

We are given a weighted graph represented by an adjancency matrix $$A$$. That is, $$A_{uv}$$ is the weight of edge $$uv$$ if it exists, or $$\infty$$ otherwise. Consider the matrix $$B := \min(A, A^2)$$ where the minimum is taken entry-wise. Note that $$A^2_{uv}$$ is the length of the shortest two-path from $$u$$ to $$v$$. So $$B_{uv}$$ is the length of the shortest path from $$u$$ to $$v$$ that uses *at most* two hops. We repeat this argument and compute $$C := \min(B, B^2)$$ and so on. After $$\log n$$ repetitions, we obtain a matrix that encodes the length of the shortest path between any pair of vertices which uses at most $$n$$ hops. But the last restriction is not really a restriction, as a shortest path may have up to $$n$$ hops. So the final matrix is exactly what APSP asks for.

Regarding running time, we need to solve $$\log n$$ (min,+) matrix products, each of size $$n \times n$$. If the latter admits a truly subcubic time algorithm, then APSP can be solved in truly subcubic time, too.

*Remark.* The reduction does essentially the same thing as the Floyd-Warshall algorithm.
