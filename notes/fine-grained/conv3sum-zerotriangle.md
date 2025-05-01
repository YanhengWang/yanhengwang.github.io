---
layout: linear
date: 28 April 2025
title: Convolution 3-Sum → Zero Triangle
returnPage: ./
---

On this page, we write $$[n] := \set{0, 1, \dots, n-1}$$ and all arrays are indexed from 0. Given a Convolution 3-Sum instance $$A, B, C$$, we want to decide whether there exist $$i,j \in [n]$$ such that $$C[i+j] = A[i] + B[j]$$. Here is a naive reduction: create a complete tripartite graph with parts $$I = J = K = [n]$$, and set the edge weights by

$$\begin{align*}
	w(i,j) &:= n A[i] + i \\
	w(j,k) &:= n B[j] + j \\
	w(k,i) &:= -n C[k] - k
\end{align*}$$

for all $$(i,j,k) \in I \times J \times K$$. Clearly, there exists a zero triangle iff the Convolution 3-Sum instance has answer "yes". Albeit correct, the reduction is not fine-grained enough, as it can't transfer a subcubic time algorithm for Zero Triangle to a subquadratic algorithm for Convolution 3-Sum.

So far, we have embedded array entries into edge weights somewhat wastefully: all outgoing edges from the same vertex have the same weight. Can we squeeze in more information by making these edge weights distinct?

To this end, let us instead construct a smaller graph with parts $$X = Y = Z = [g]$$ for $$g = \sqrt{n}$$, and fully exploit the $$g^2 = n$$ available edge between parts. Let $$s$$ be a parameter whose purpose is explained later. We set the edge weights by

$$\begin{align*}
	w(x,y) &:= A[gx+y] \\
	w(y,z) &:= B[gz-y+s] \\
	w(z,x) &:= -C[g(x+z)+s]
\end{align*}$$

for all $$(x,y,z) \in X \times Y \times Z$$. The resulting graph is denoted by $$G_s$$. For each $$s = 0, 1, \dots, 2g-2$$, we run a Zero Triangle algorithm on $$G_s$$. If any of them reports "true", then we output true. Otherwise output false.

Suppose there exist $$i,j : C[i+j] = A[i] + B[j]$$. Let us express $$i = gx+y$$, where $$0 \leq (x = i \text{ div } g) < g$$ and $$0 \leq (y = i \bmod g) < g$$. Hence $$w(x,y) = A[i]$$. We express $$j = gz+t$$ all the same, and notice that $$w(y,z) = B[j]$$ for the parameter choice $$s := y+u$$. Finally, we observe that $$w(z,x) = -C[i+j]$$ regardless of the choice of $$s$$. Putting all these together, $$w(x,y) + w(y,z) + w(z,x) = A[i] + B[j] - C[i+j]$$, which is zero by assumption. So the Zero Triangle instance on $$G_s$$ reports "true", and we correctly outputs true.

**Exercise.**
Argue about the converse. Namely, if we output true, then the Convolution 3-Sum instance has a solution.

Regarding runtime, we call Zero Triangle on $$2g-1$$ instances of size $$g$$ each. If Zero Triangle can be solved in $$O(g^{3-\epsilon})$$ time (for graphs of size $$g$$), then we have an algorithm for Convolution 3-Sum in $$O(g \cdot g^{3-\epsilon}) = O(n^{2-\epsilon/2})$$ time.
