---
layout: linear
date: 27 April 2025
title: (Min,+) Convolution ↔ Knapsack
returnPage: ./
---

# (Min,+) Convolution → Knapsack

Let us massage the formulation of (Min,+) Convolution. Let $$a,b,c$$ be the input arrays. Choose a sufficiently large integer $$M \geq 2\max\{\norm{a}_\infty, \norm{b}_\infty, \norm{c}_\infty\}$$. We define

$$\begin{align*}
	a'[i] &= a[i] + iM \\
	b'[j] &= b[j] + jM \\
	c'[k] &= -c[n+1-k] + kM.
\end{align*}$$

Observe that each of $$a',b',c'$$ is a monotonically increasing array of integers in $$[nM]$$. On the other hand, we have

$$ a'[i] + b'[j] + c'[n+1-(i+j)] = a[i] + b[j] - c[i+j] + (n+1)M. $$

Hence the following conditions are equivalent:

1. There exist indices $$i,j$$ such that $$a[i] + b[j] < c[i+j]$$.
2. There exist indices $$i,j$$ such that $$i+j \leq n$$ and $$a'[i] + b'[j] + c'[n+1-(i+j)] < (n+1)M$$.
3. There exist indices $$i,j,k$$ such that $$i+j+k \geq n+1$$ and $$a'[i] + b'[j] + c'[k] < (n+1)M$$.

(The implication from 3 to 2 is due to monotonicity.)

Now we model condition 3 by a Knapsack instance. To this end, we take a large integer $$L > (n+1)M$$ and create items $$A_1, \dots, A_n, B_1, \dots, B_n, C_1, \dots, C_n$$. Their weights and values are defined below:

|         | weight         | value       |
|---------|----------------|-------------|
| $$A_i$$ | $$4L + a'[i]$$ | $$19n + i$$ |
| $$B_j$$ | $$2L + b'[j]$$ | $$3n + j$$  |
| $$C_k$$ | $$L + c'[k]$$  | $$k$$       |

We run a Knapsack algorithm to decide whether a knapsack of capacity $$W := 7L + (n+1)M - 1$$ can fit items of total value more than $$V := 23n$$.

Observe that every optimal solution must pick some item $$A_i$$. Indeed, the capacity contraint implies that we can pick at most $$\lfloor \frac{W}{2L} \rfloor \leq 3$$ items $$B_j$$, and at most $$\lfloor \frac{W}{L} \rfloor \leq 7$$ items $$C_k$$. The total value of these items is at most $$3 \cdot (4n) + 7 \cdot n = 19n$$, so it is more profitable to just pick some $$A_i$$ instead.

Again by the capacity constraint, we can't fit two items $$A_{i_1}, A_{i_2}$$ simultaneously in the knapsack. So the optimal solution has to pick *exactly one* item $$A_i$$. Repeating the above arguments, it has to pick exactly one $$B_j$$ and exactly one $$C_k$$. The total weight is thus $$7L + a'[i] + b'[j] + c'[k]$$. Since this is bounded by the capacity, we deduce that $$a'[i] + b'[j] + c'[k] < (n+1)M$$. On the other hand, the total value is $$22n + i+j+k$$, which exceeds $$V$$ if and only if $$i+j+k \geq n+1$$.

In summary, the answer to the Knapsack instance directly tells us whether condition 3 is satisfiable. So if Knapsack can be solved in truly subquadratic time (in terms of the target value $$V$$), then we can solve (Min,+) Convolution in truly subquadratic time (in terms of $$n$$).

# Knapsack → (Min,+) Convolution

We are given items $$(w_1, v_1), \dots, (w_n, v_n)$$ as weight-value pairs. The goal is to decide whether we can pick a multiset of items whose total weight is at most $$W$$ and whose total value is at least $$V$$. We can assume that $$w_i \leq W$$ and $$v_i \leq V$$ for all $$i$$. Let us denote $$\hat{V} := V + \max_i v_i \leq 2V$$.

For $$t, v \geq 0$$, define $$f_t[v]$$ as the minimum weight of $$2^t$$ (possibly repeating) items whose total value is $$v$$. To solve the Knapsack problem, it suffices to compute $$f_t[v]$$ for $$0 \leq t \leq \log V$$ and $$0 \leq v \leq \hat{V}$$. Indeed, if the Knapsack instance admits a "yes" solution, then we can remove excessive items from the solution so that the total value is in $$[V, \hat{V}]$$; and in particular, there can be at most $$\hat{V}$$ items.

Clearly $$f_0[v]$$ can be computed in $$O(n)$$ time by scanning the inputs. To compute $$f_{t+1}[v]$$, we can use the recursion

$$ f_{t+1}[v] = \min_{x+y = v} (f_t[x] + f_t[y]). $$

This is true because any multiset of $$2^{t+1}$$ items can be split into two multisets of $$2^t$$ items, and vice versa. The weight (resp. value) of the big multiset is the sum of weights (resp. values) of the two smaller multisets.

Hence, $$f_{t+1}$$ is exactly the (min,+) convolution of $$f_t$$ with $$f_t$$. If (Min,+) Convolution can be solved in truly subquadratic time $$O(\hat{V}^{2-\epsilon})$$ in terms of the sequence length, then we can solve Knapsack in truly subquadratic time $$O(n + \hat{V}^{2-\epsilon} \log \hat{V}) = O(n + V^{2-\epsilon} \log V)$$ as well.
