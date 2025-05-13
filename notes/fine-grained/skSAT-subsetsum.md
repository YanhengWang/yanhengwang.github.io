---
layout: linear
date: 14 May 2025
title: Sparse k-SAT → Subset Sum
preamble: |-
    \newcommand{\var}{\operatorname{var}}
    \newcommand{\metavar}{\operatorname{mvar}}
returnPage: ./
---

For background, the currently fastest [algorithm](https://doi.org/10.1007%2F978-3-030-64834-3_22) for Subset Sum on $$N$$ integers runs in time $$O(2^{0.283N})$$. When parameterized by the target value $$t$$, a [randomised algorithm](https://arxiv.org/abs/1610.04712) runs in time $$\widetilde{O}(N+t)$$. Our ultimate goal is to show (under SETH) that Subset Sum is not in time $$O(N + t^{1-\delta})$$ for any $$\delta > 0$$. Towards this goal we will present two reductions from Sparse k-SAT to Subset Sum.

# A Crude Reduction

Let $$k \in \Nat$$. Assuming sparse ETH, there exist constants $$c, s > 0$$ such that s-sparse k-SAT is not in time $$O(2^{cn})$$. From now on we fix these constants.

Given an s-sparse k-SAT formula $$\phi = C_1 \land \cdots \land C_m$$ on variables $$x_1, \dots, x_n$$, we construct a Subset Sum instance of $$O(n)$$ integers. We think of an integer in its binary representation, and partition the bits into three sections (separated by dummy bits). We call them *variable*, *clause* and *consistency* sections, respectively. The variable section is $$n$$ bits wide, and the clause section is $$m$$ bits wide. The consistency section is more complicated: we further partition it into $$n$$ slots indexed by variables, and each slot is $$\log(s+1)$$ bits wide (so it can store a number in $$\set{0, 1, \dots, s}$$).

We begin by defining the target integer $$t$$. Its variable and clause sections are filled with `1`s. For each slot $$x_i$$ in its consistency section, we place $$m_i := \#\set{j \in [m] : x_i \in \var(C_j)}$$. This number fits the slot since $$\phi$$ is s-sparse.

Next we define the source integers. For every $$i \in [n]$$ and $$b \in \set{0,1}$$, we introduce an integer $$s_i^b$$:

- Its variable section is all `0`, except that the $$i$$-th bit is `1`.
- Its clause section is all `0`.
- In its consistency section, slot $$x_i$$ receives $$b m_i$$, while all other slots receive zero.

For every $$j \in [m]$$ and *locally satisfying* assignment $$f : \var(C_j) \to \set{0,1}$$, we introduce an integer $$r_j^f$$:

- Its variable section is all `0`.
- Its clause section is all `0`, except that the $$j$$-th bit is `1`.
- For each slot $$x_i$$ in its consistency section, we place a one if $$x_i \in \var(C_j)$$ and $$f(x_i) = 0$$; otherwise we place a zero.

The instance is now complete. It contains $$N \leq 2n + 2^k m \leq (2 + s 2^k) n$$ integers, each of $$n + m + \log(s+1) n \leq 2sn$$ bits long.

Suppose that $$\phi$$ has a satisfying assignment $$\alpha$$. We construct a solution to the Subset Sum instance: pick $$s_i^{\alpha(x_i)}$$ for each $$i \in [n]$$, and $$r_j^{\alpha[\var(C_j)]}$$ for each $$j \in [m]$$. Let us verify that their sum is exactly $$t$$. This is clear in the variable and clause sections. For each slot $$x_i$$ in the consistency section, we consider two cases:

- If $$\alpha(x_i) = 0$$, then the picked integer $$s_i^0$$ contributes nothing to the slot. Each picked $$r_j^f$$ contributes 1 iff $$x_i \in \var(C_j)$$. So the sum in this slot is exactly the target $$m_i$$.
- If $$\alpha(x_i) = 1$$, then the picked integer $$s_i^1$$ contributes $$m_i$$ to the slot. Each picked $$r_j^f$$ contributes 0, regardless of $$x_i \in \var(C_j)$$ or not. So the sum in this slot is again the target $$m_i$$.

Conversely, suppose that the Subset Sum instance has a solution. As each bit in the variable section sums up to 1, the solution must pick exactly one $$s_i^b$$ for every $$i \in [n]$$; they induce the assignment $$\alpha : (x_1 \mapsto b_1), \dots, (x_n \mapsto b_n)$$. Similarly, as each bit in the clause section sums up to 1, the solution must pick exactly one $$r_j^f$$ for every $$j \in [m]$$; they induce a bunch of locally satisfying assignments $$f_1, \dots, f_m$$. It remains to show that $$\alpha$$ is consistent with all the local assignments; thus the former is a global satisfying assignment. To check consistency, we consider an arbitrary slot $$x_i$$ in the consistency section.

- If $$b_i = 0$$, then the picked integer $$s_i^0$$ contributes nothing to the slot. So contribution may only come from those $$r_j^{f_j}$$ with $$x_j \in \var(C_j)$$. There are only $$m_i$$ of them, so in order to reach the target $$m_i$$ everyone must contribute. Hence $$f_j(x_i) = 0$$ for each. This is consistent with $$(x_i \mapsto b_i)$$.
- If $$b_i = 1$$, then the picked integer $$s_i^1$$ contributes $$m_i$$ to the slot, which already clears the target. So none of $$r_j^{f_j}$$ should contribute. In other words, for each $$j \in [m]$$, either $$x_j \notin \var(C_j)$$ or $$f_j(x_i) = 1$$. This is again consistent with $$(x_i \mapsto b_i)$$.

To summarise, $$\phi$$ is satisfiable iff the Subset Sum instance has a solution. Next we analyse the complexity. Suppose for contradition that an algorithm solves Subset Sum in time $$O(2^{\epsilon N})$$ where $$\epsilon := \frac{c}{2 + s 2^k}$$. Then we can use it (and the above reduction) to solve s-sparse k-SAT in time $$O(2^{cn})$$. This contradicts with our choice of $$c,s$$.

**Exercise.**
Assume sparse ETH. Use the same reduction to show that Subset Sum is not in time $$O(N + t^{\frac{c}{2s}})$$.

# A Tight Reduction

In the crude reduction, every integer is $$2sn$$ bits long, which direct reflects in the lower bound exponent. Can we tweak the reduction to make every integer $$cn$$ bits long only?

A simple idea comes to aid. Fix some large constant $$B$$. We group the variables into *metavariables* $$X_1, \dots, X_{n/B}$$, each containing $$B$$ many. Similarly, we group the clauses into *metaclauses* $$\class{C}_1, \cdots, \class{C}_{m/B}$$, each containing $$B$$ many. Since we are considering an s-sparse k-SAT formula, every metaclause intersects at most $$kB$$ metavariables, and every metavariable intersects at most $$sB$$ metaclauses.

Next we construct a Subset Sum instance of $$O(n)$$ integers. As before, we interpret an integer in binary, whose bits are divided into a metavariable section of width $$n/B$$, a metaclause section of width $$m/B$$, and a consistency section with $$n/B$$ slots indexed by metavariables. (The width of each slot will be specified later.)

For every $$i \in [n/B]$$ and assignment $$b \in \set{0,1}^B$$, we introduce an integer $$s_i^b$$. For every $$j \in [m/B]$$ and locally satisfying assignment $$f: \metavar(\class{C}_j) \to \set{0,1}^B$$, we introduce an integer $$r_j^f$$. Here $$\metavar(\class{C})$$ denotes the set of *metavariables* which intersect with $$\class{C}$$. Note that the total number of integers is at most

$$ \frac{n}{B} \cdot 2^B + \frac{m}{B} \cdot (2^B)^{kB} = O(n). $$

In each of the introduced integers, we fill the metavariable and metaclause sections in analogue to the crude reduction. The consistency section has the same structure as before, but the content is more interesting. We will make use of a construction of average-free sets.

**Definition.**
$$A$$ is *q-average-free* if for all $$a_0, \dots, a_t \in A$$ such that $$t \leq q$$ and $$t \cdot a_0 = a_1 + \cdots + a_t$$, we have $$a_0 = \cdots = a_t$$.

**Behrend's Theorem.**
For every $$p,q \in \Nat$$ and $$0 < \epsilon < 1$$, we can construct in polynomial time a q-average-free set $$A$$ of $$p$$ positive integers, each bounded by $$M := q^{O(1/\epsilon)} p^{1+\epsilon}$$.

Let's see how it helps. We choose $$p := 2^B$$ and $$q := sB$$ in the theorem, and obtain a set $$A \subseteq [M]$$. We will index it by assignments $$b \in \set{0,1}^B$$.

- In the consistency section of each integer $$s_i^b$$, we place $$m_i \cdot (M-A_b)$$ in slot $$X_i$$, where $$m_i \leq q$$ counts the number of metaclauses intersecting with $$X_i$$. All unspecified slots receive zero.
- In the consistency section of each integer $$r_j^f$$, we place $$A_{f(X_i)}$$ in each slot $$X_i \in \metavar(\class{C}_j)$$. All unspecified slots receive zero.
- In the consistency section of target $$t$$, we place $$m_i M$$ in each slot $$X_i$$.

Apparently, if the input formula is satisfiable then the Subset Sum instance has a solution. The converse is less obvious. Suppose that the Subset Sum instance has a solution. In each slot $$X_i$$ of the consistency section, one of the $$s_i^b$$ contributes $$m_i \cdot (M-A_b)$$, and $$m_i$$ of those $$r_j^f : X_i \in \metavar(\class{C}_j)$$ contribute the remaining $$m_i A_b$$. Since $$m_i \leq q$$, average-freeness implies that all the individual contributions are equal. In other words, the partial assignments are consistent.

Finally, let us figure out the complexity of this reduction. We have already shown that the number of integers is $$N = O(n)$$. We now derive a bound on $$t$$. Each slot needs to be $$\log(qM) = O(\frac{1}{\epsilon}) \log(sB) + (1+\epsilon) B$$ bits wide. For large enough $$B$$, we can bound it by $$(1+2\epsilon) B$$. So the target has bit length

$$ \frac{n}{B} + \frac{m}{B} + \frac{n}{B} (1+2\epsilon) B
~\leq~ \left( 1 + 2\epsilon + \frac{1+s}{B} \right) n. $$

Again for sufficiently large $$B$$, this can be bounded by $$(1+3\epsilon) n$$. The rest of the proof is left to the reader as an exercise.

**Exercise.**
Assume sparse SETH. Show that Subset Sum is not in time $$O(N + t^{1-\delta})$$ for any $$\delta > 0$$.
