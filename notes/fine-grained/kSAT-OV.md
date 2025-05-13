---
layout: linear
date: 3 May 2025
title: k-SAT → Orthogonal Vector
returnPage: ./
---

Let $$k \in \Nat$$ be a constant to be fixed later. Given a k-SAT formula $$\phi = C_1 \land \cdots \land C_m$$ on variables $$x_1, \dots, x_n$$, we construct an Orthogonal Vector instance.

For every truth assignment $$f : \{x_1, \dots, x_{n/2}\} \to \{0,1\}$$, we define a vector $$a_f[1 \dots m]$$ where $$a_f[i] = 0$$ iff $$f$$ satisfies some literal in $$C_i$$. Collect all vectors $$a_f$$ into a set $$A$$. Similarly, for every truth assignment $$g : \{x_{n/2+1}, \dots, x_n\} \to \{0,1\}$$, we define $$b_g[1 \dots m]$$ by $$b_g[i] = 0$$ iff $$g$$ satisfies some literal in $$C_i$$. Collect all vectors $$b_g$$ into a set $$B$$. Apparently $$A,B \subseteq \{0,1\}^m$$, $$\card{A} = \card{B} = 2^{n/2}$$ and $$m \leq 2^k \binom{n}{k}$$.

Note that $$a_f \perp b_g$$ iff the full assignment $$f \cup g$$ satisfies every single clause. Hence, there exists a pair of orthogonal vectors iff $$\phi$$ is satisfiable. Our arguments so far works for any fixed $$k$$.

Now, suppose that Orthogonal Vector on instances of size $$N$$ and dimension $$d$$ can be solved in time $$N^{2-\epsilon} \mathrm{poly}(d)$$ for some $$\epsilon > 0$$. Under SETH, we can take a large *constant* $$k$$ such that k-SAT is not in time $$O(2^{(1-\epsilon/3)n})$$. On the other hand, the reduction above implies a k-SAT algorithm in time $$(2^{n/2})^{2-\epsilon} \mathrm{poly}(m) = 2^{(1-\epsilon/2)n} \mathrm{poly}(n) = o(2^{(1-\epsilon/3)n})$$. This is a contradiction.

*Remark.* We can also reduce from Sparse k-SAT, which gives lower bounds for Orthogonal Vector in the low-dimension regime.
