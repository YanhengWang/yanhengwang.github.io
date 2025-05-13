---
layout: linear
date: 6 May 2025
title: k-SAT → Sparse k-SAT
returnPage: ./
---

Let $$k \in \Nat$$ and $$\delta > 0$$ be arbitrary parameters. Given a k-SAT formula over $$n$$ variables, we apply the [sparsification lemma](https://people.csail.mit.edu/virgi/6.s078/lect2.pdf) to generate $$2^{\delta n}$$ many $$\beta$$-sparse k-SAT formulae over the same variables, for some constant $$\beta = \beta(k,\delta)$$. The lemma guarantees that the original formula is satisfiable if and only if all the smaller formulae are satisfiable.

The reduction immediately implies:

**Proposition.**
If k-SAT is not in time $$T(n)$$, then $$\beta(k,\delta)$$-sparse k-SAT is not in time $$T(n) / 2^{\delta n}$$, for any $$\delta > 0$$.

We will use it to show two further consequences.

**ETH ⇒ sparse ETH.**
Fix any $$k \in \Nat$$. By ETH, there exists a constant $$d > 0$$ such that k-SAT is not in time $$O(2^{dn})$$. Taking $$\delta := d/2 > 0$$ in the proposition, we deduce that $$\beta(k,\delta)$$-sparse k-SAT is not in time $$O(2^{dn} / 2^{\delta n}) = O(2^{dn/2})$$. In other words, the constants $$s := \beta(k,\delta)$$ and $$c := d/2$$ support sparse ETH.

**SETH ⇒ sparse SETH.**
Fix any $$\epsilon > 0$$. By SETH, there exists a constant $$k \in \Nat$$ such that k-SAT is not in time $$O(2^{(1-\epsilon/2)n})$$. Taking $$\delta := \epsilon/2$$ in the proposition, we deduce that $$\beta(k,\delta)$$-sparse k-SAT is not in time $$O(2^{(1-\epsilon/2)n} / 2^{\delta n}) = O(2^{(1-\epsilon)n})$$. In other words, the constants $$k$$ and $$s := \beta(k,\delta)$$ support sparse SETH.
