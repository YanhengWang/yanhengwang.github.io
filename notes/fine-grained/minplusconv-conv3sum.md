---
layout: linear
date: 27 April 2025
title: (Min,+) Convolution → Convolution 3-Sum
returnPage: ./
preamble: |-
    \newcommand{\floor}[1]{\left\lfloor #1 \right\rfloor}
---

We are given input arrays $$A, B, C$$ to (Min,+) Convolution, and the goal is to decide whether there exist indices $$i,j$$ such that $$A[i] + B[j] < C[i+j]$$. Recall that Convolution 3-Sum is the same problem with "<" replaced by "=". To make this conversion, we use a general lemma seen in the reduction [Negative Triangle → Zero Triangle](./negtriangle-zerotriangle.html):

**Lemma.**
Let $$a, b, c \in [-N, N]$$ be integers. We have $$a + b + c > 0$$ iff there exists an integer $$t \in [0, \log N]$$ such that

$$ 1 \leq \floor{\frac{a}{2^t}} + \floor{\frac{b}{2^t}} + \floor{\frac{c}{2^t}} \leq 6. $$

So it suffices to construct one Convolution 3-Sum instance for each rounding parameter $$t$$ and error $$\Delta$$. Formally:

- Compute $$N$$, the maximum amplitude in the input arrays.
- For $$t = 0, \dots, \log N$$ and $$\Delta = 1, \dots, 6$$:
	- Construct array $$A'[i] := \floor{-A[i]/2^t}$$
	- Construct array $$B'[j] := \floor{-B[j]/2^t}$$
	- Construct array $$C'[k] := \floor{C[k]/2^t} - \Delta$$
	- Solve Convolution 3-Sum on $$A',B',C'$$. If the answer is true then return true; otherwise continue.
- Return false.

**Exercise.**
Finish the argument.
