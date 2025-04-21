---
layout: linear
date: 16 March 2025
title: Negative Triangle → Zero Triangle
returnPage: ./
preamble: |-
    \newcommand{\floor}[1]{\left\lfloor #1 \right\rfloor}
---

The reduction is based on a general lemma:

**Lemma.**
Let $$a, b, c \in [-N, N]$$ be integers. We have $$a + b + c > 0$$ iff there exists an integer $$t \in [0, \log N]$$ such that

$$ 1 \leq \floor{\frac{a}{2^t}} + \floor{\frac{b}{2^t}} + \floor{\frac{c}{2^t}} \leq 6. $$

*Proof.*
Without loss of generality, we assume that $$N = 2^k$$ is a power of two.

(⇒) Suppose that $$a + b + c = d > 0$$. If $$d \leq 6$$ then we may take $$t := 0$$. Otherwise $$d \geq 7$$ and we define $$a' := \floor{a/2}, b' := \floor{b/2}, c' := \floor{c/2}$$; these are integers in $$[-2^{k-1}, 2^{k-1}]$$. Note that

$$ a' + b' + c' \leq 3 + \frac{a + b + c}{2} = 3 - \frac{D}{2} < 0. $$

So by induction on $$k$$, there exists $$s \in [0, k-1]$$ such that

$$ 1 \leq \floor{\frac{a'}{2^s}} + \floor{\frac{b'}{2^s}} + \floor{\frac{c'}{2^s}} \leq 6. $$

Next we plug the definitions of $$a',b',c'$$ into the inequality. Simplify it using the identity $$\floor{\frac{\floor{x/2}}{2^s}} = \floor{\frac{x}{2^{s+1}}}$$, which simply says "shifting $$s$$ bits and then one bit to the right is the same as shifting $$s+1$$ bits to the right". Then we obtain the lemma statement with $$t := s+1 \in [0, k]$$.

(⇐) For any $$t$$ that satisfies the condition, we have

$$a + b + c \geq 2^t \left( \floor{\frac{a}{2^t}} + \floor{\frac{b}{2^t}} + \floor{\frac{c}{2^t}} \right) \geq 2^t > 0. $$

This finishes the proof. ∎

Now we can proceed to the reduction. Given a weighted complete tripartite graph, we negate the weights so that Negative Triangle becomes Positive Triangle. Let $$w$$ be the (negated) weight function and assume that $$\norm{w}_\infty \leq N$$.

- For $$t = 0, \dots, \log N$$:
	- Define $$w' := \floor{w/2^t}$$ where the division and rounding are edge-wise.
	- For $$d = 1, \dots, 6$$:
		- Add $$d$$ to weight $$w'$$ on all edges between the first and second parts in the graph. Call the resulting weight funtion $$w''$$.
		- If there exists a zero triangle with respect to $$w''$$, then return true; otherwise continue.
- Return false.

The correctness of this reduction is guaranteed by the lemma. Hence, if Zero Triangle is in time $$T(n)$$ then we can solve Negative Triangle in time $$O((\log N) \cdot (T(n) + n^2))$$.
