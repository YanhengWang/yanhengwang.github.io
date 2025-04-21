---
layout: linear
date: 15 March 2025
title: 3-Sum ↔ Convolution 3-Sum
returnPage: ./
---

# Initial Simplifications

In the following, we study variants of (Convolution) 3-Sum that asks for "$$a + b = c$$" instead of "$$a + b + c = 0$$". The two are equivalent by negating every number in the array $$C$$. Additionally, we assume that all numbers are positive, since we can add a sufficiently large $$N$$ to every number in $$A,B$$ and $$2N$$ to every number in $$C$$. Finally, it does not matter whether we wrap indices around in Convolution 3-Sum, since we can append a copy of $$C$$ to its end to simulate wrap-around; or pad $$A,B$$ with sufficient $$\infty$$'s and $$C$$ with sufficient zeros to forbid wrap-around.

We still call the variants *(Convolution) 3-Sum* for the sake of simplicity.

# 3-Sum → Convolution 3-Sum

We are given a 3-Sum instance $$A, B, C$$. Assume that all numbers are from the universe $$[U] := \{0, 1, \dots, U-1\}$$. We sample a hash function $$h: [U] \to [n]$$ from some universal and linear hash family. That means $$\Pr_{h}[h(x) = h(y)] \leq 2/n$$ for all distinct $$x, y \in [U]$$, and $$h(x) + h(y) = h(x+y)$$ for all $$x,y$$. (A candidate hash family that satisfies the constraints is $$h(x) := (\lambda x \bmod p) \bmod n$$, where $$p > U$$ is a prime and $$\lambda \in [p]$$ is sampled at random.)

Let us first assume that $$h$$ restricted on $$A$$ (resp. $$B$$, $$C$$) is injective. The idea then is to define a new instance by

$$\begin{align*}
	A'[h(a)] &:= a & \forall a \in A, \\
	B'[h(b)] &:= b & \forall b \in B, \\
	C'[h(c)] &:= c & \forall c \in C.
\end{align*}$$

Clearly, if $$a + b = c$$ then $$A'[h(a)] + B'[h(b)] = C'[h(c)]$$. But we know more due to linearity of the hash function: $$h(a) + h(b) = h(a+b) = h(c)$$. That is, the indices check the condition of Convolution 3-Sum (with wrap-around). So $$A,B,C$$ admits a 3-Sum solution iff $$A',B',C'$$ admits a Convolution 3-Sum solution.

In reality, however, it is highly probable that two (or more) $$a_1, a_2 \in A$$ have the same hash value $$r = h(a_1) = h(a_2)$$ and thus contend for the same bin $$A'[r]$$. Similar stories happen for $$B', C'$$. To resolve collision, we iterate over multiple rounds; in each round we pick only one element for each bin and call Convolution 3-Sum. The efficiency of this approach depends on the number of collisions, and that is why $$h$$ needs to be universal.

The reduction is summarised as follows.

- Sample $$h: [U] \to [n]$$ from some universal and linear hash family.
- For $$r \in [n]$$:
	- compute $$A_r := \{ a \in A: h(a) = r \}$$, $$B_r := \{ b \in B: h(b) = r \}$$ and $$C_r := \{ c \in C: h(c) = r \}$$.
- For each $$1 \leq u, v, w \leq 20$$:
	- For $$r \in [n]$$:
		- let $$A'[r]$$ be the $$u$$-th element in $$A_r$$;
		- let $$B'[r]$$ be the $$v$$-th element in $$B_r$$;
		- let $$C'[r]$$ be the $$w$$-th element in $$C_r$$.
	- If $$A', B', C'$$ admits a Convolution 3-Sum solution, then return true; otherwise continute.
- Return false.

The entire algorithm runs in asymptotically the same time as Convolution 3-Sum. It remains to see why the algorithm is correct.

If the algorithm returns true, then necessarily we have discovered a Convolution 3-Sum solution in some iteration. That in particular is a 3-Sum solution.

Conversely, suppose that the 3-Sum instance admits a solution $$a^* + b^* = c^*$$. By universality of $$h$$, for every fixed element $$a \in A \setminus \{a^*\}$$ we have $$\Pr[h(a) = h(a^*)] \leq 2/n$$. So the expected number of hash collisions with $$a^*$$ is at most two. By Markov's inequality, with probability at most 0.1 is this number more than 20. The same argument works for $$b^*, c^*$$, too. So with probability at least 0.7, none of the three has collision number greater than 20. In that case, $$a^*, b^*, c^*$$ will simultaneously enter $$A', B', C'$$ in one of the iterations, making a valid solution to the Convolution 3-Sum instance. So the algorithm returns true.

# Convolution 3-Sum → 3-Sum

We are given a Convolution 3-Sum instance $$A, B, C$$ (without wrap-around). Assume without loss of generality that $$n = 2^t$$ is a power of two. Define $$A'[i] := i + 2^{t+2} A[i]$$. Essentially, we shift the number $$A[i]$$ by $$t+2$$ bits to the left, so as to make room for storing the index $$i$$ (and allowing some cushion). In a similar fashion, define $$B'[j] := j + 2^{t+2} B[j]$$ and $$C'[k] := k + 2^{t+2} C[k]$$.

Note that $$A'[i] + B'[j] = C'[k]$$ iff $$A[i] + B[j] = C[k]$$ and $$i + j = k$$. Hence solutions to the 3-Sum instance $$A', B', C'$$ one-one correspond to solutions to the Convolution 3-Sum instance $$A, B, C$$.
