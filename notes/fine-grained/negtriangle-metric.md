---
layout: linear
date: 11 March 2025
title: Negative Triangle ↔ Metricity
returnPage: ./
---
# Negative Triangle → Metricity

We are given a weighted complete tripartite graph on $$I \cup J \cup K$$. We build a $$3n \times 3n$$ matrix $$A$$ with the following layout. The first $$n$$ rows are indexed by $$I$$, the next $$n$$ rows are indexed by $$J$$, and the last $$n$$ rows are indexed by $$K$$. Index the columns likewise. Let $$N := \norm{w}_\infty$$ be largest absolute weight. We assign
$$A_{ij} := N + w(i,j),\, A_{jk} := N + w(j,k),\, A_{ik} := 2N - w(i,k)$$ for all $$ijk \in I \times J \times K$$. All other entries are $$\infty$$ (or just some large enough number). Note that the matrix $$A$$ is non-negative.

If there exists a negative triangle $$ijk$$ in the original graph, then

$$A_{ij} + A_{jk} = 2N + w(i,j) + w(j,k) < 2N - w(i,k) = A_{ik}.$$

So $$A$$ is not a metric.

Conversely, if $$A$$ is not a metric, then there exist $$i,j,k \in [3n]$$ such that $$A_{ij} + A_{jk} < A_{ik}$$. Hence none of the left summands can be $$\infty$$. This implies $$ijk \in I \times J \times K$$. Therefore $$ijk$$ forms a negative triangle.

# Metricity → Negative Triangle

Given a matrix $$A \in \Nat^{n \times n}$$, we build a complete tripartite graph on $$I, J, K$$, each part of size $$n$$. We define weights

$$\begin{align*}
	w(i,j) &:= A_{ij} & ij \in I \times J, \\
	w(j,k) &:= A_{jk} & jk \in J \times K, \\
	w(i,k) &:= -A_{ik} & ik \in I \times K.
\end{align*}$$

There exists a negative triangle iff $$A$$ does not satisfy triangle inequality.
