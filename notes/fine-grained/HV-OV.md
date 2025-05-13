---
layout: linear
date: 3 May 2025
title: Hitting Vector → Orthogonal Vector
returnPage: ./
---

The reduction uses the idea from [(Min,+) Matrix Product → Negative Triangle](./minplus-negtriangle.html). First, one can lift Orthogonal Vector to a search version:

> **Orthogonal Vector Search**
>
> Given two sets of $$n$$ vectors $$A, B \subseteq \{0,1\}^d$$, find a pair $$a \in A, b \in B$$ such that $$a^{\mathrm{T}} b = 0$$, or report that no such pair exists.

**Exercise.**
Show that Orthogonal Vector Search → Orthogonal Vector, without affecting the asymptotic time complexity.

In what follows, we focus on reducing Hitting Vector to Orthogonal Vector Search. Let us partition $$A = A_1 \cup \cdots \cup A_g$$ into $$g := \sqrt{n}$$ groups, with each group containing $$n/g$$ vectors. Likewise, we partition $$B = B_1 \cup \cdots \cup B_g$$. Then we do the following:

- for $$x = 1, \dots, g$$:
	- for $$y = 1, \dots, g$$:
		- while there exists a pair of orthogonal vectors $$a \in A_x, b \in B_y$$, remove $$a$$ from $$A_x$$
	- return true if $$A_x \neq \emptyset$$
- return false

Suppose that there is a hitting vector $$a \in A$$; that is, $$a$$ is *not* orthogonal to any vector in $$B$$. If $$a \in A_x$$, then it survives till the end of iteration $$x$$ because we only remove vectors that could form an orthogonal pair. Hence at the end of the iteration, $$A_x \neq \emptyset$$ and we correctly return true.

Conversely, suppose that we return true in some iteration $$x$$. Thus $$A_x \neq \emptyset$$, and we claim that every vector in $$A_x$$ is a hitting vector. Indeed, if $$a \in A_x$$ is not a hitting vector, then it is orthogonal to some $$b \in B_y$$ for some $$b \in [g]$$. So in round $$y$$ of the inner for-loop, the pair $$a,b$$ shall be discovered by the while-loop, and as a result $$a$$ is removed from $$A_x$$, a contradiction.

Now that we have established correctness, let us analyse the runtime. Denote by $$T(m)$$ the time complexity of Orthogonal Vector Search on an instance of size $$m$$. Consider a fixed iteration $$x \in [g]$$. The condition in the while-loop is satisfied at most $$n/g$$ times because $$A_x$$ becomes empty after that many removals. Apart from that, the condition is tested $$g$$ times, one for each $$y$$. So we spend $$O((n/g + g) \cdot T(n/g)) = O(\sqrt{n} T(\sqrt{n}))$$ time on the iteration. Summing over all iterations, the total time is $$O(n T(\sqrt{n}))$$. If $$T(m) = O(m^{2 - \epsilon})$$, then the time amounts to $$O(n^{2-\epsilon/2})$$.
