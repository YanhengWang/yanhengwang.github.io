---
layout: linear
date: 2 May 2025
title: Orthogonal Vector → Longest Common Subsequence
returnPage: ./
preamble: |-
    \newcommand{\lcs}{\text{LCS}}
    \newcommand{\tri}{\triangledown}
---

We are given two sets of vectors $$\{a_1, \dots, a_n\} \subseteq \{0,1\}^d$$ and $$\{b_1, \dots, b_n\} \subseteq \{0,1\}^d$$, based on which we construct two strings over the alphabet $$\{0,1,\square,\lozenge,\triangledown\}$$. The construction works in a bottom-up manner.

At the lowest level of granularity, we define two mappings $$f, g: \{0,1\} \to \{0,1\}^3$$ by

$$\begin{align*}
	f(0) &:= 001 & f(1) &:= 011 \\
	g(0) &:= 010 & g(1) &:= 100.
\end{align*}$$

So for all $$x,y \in \{0,1\}$$, we have

$$\lcs(f(x), g(y)) = \begin{cases}
	2 & x=0 \lor y=0, \\
	1 & x=y=1.
\end{cases}$$

At a higher level of granularity, we map each vector $$a_i = a_{i1} \dots a_{id}$$ to a string

$$ F_i := f(a_{i1}) \square^{3d} \cdots f(a_{id}) \square^{3d}. $$

Similarly, we map each $$b_j = b_{j1} \dots b_{jd}$$ to

$$ G_j := g(b_{i1}) \square^{3d} \cdots g(b_{jd}) \square^{3d}. $$

What does a LCS of $$F_i, G_j$$ look like? As we have padded sufficiently many squares, any LCS must match $$F_i, G_j$$ block by block. That is, for every $$k$$, a symbol in $$f(a_{ik})$$ can only be matched to a symbol in $$g(b_{jk})$$, and vice versa. (Otherwise it would miss at least $$3d$$ squares, which cannot be compensated by other means.) Therefore, $$\lcs(F_i, G_j) = 3d^2 + 2d =: \ell$$ if $$a_i \perp b_j$$; in other cases $$\lcs(F_i, G_j) \leq \ell-1$$.

It is useful to "homogenise" the strings. Let $$F_i' := \lozenge^{\ell-1} F_i$$ and $$G_i' := G_i \lozenge^{\ell-1}$$. Note that $$\card{F_i'} = \card{G_i'} = \ell - 1 + d(3d+3) =: m$$, and that

$$\lcs(F_i', G_j') = \begin{cases}
	\ell & a_i \perp b_j,\\
	\ell-1 & \text{otherwise}.
\end{cases}$$

At the top level, we define two strings

$$\begin{align*}
	F &:= F_1' \tri^m \cdots F_n' \tri^m F_1' \tri^m \cdots F_n' \tri^m, \\
	G &:= \tri^{nm} G_1' \tri^m \cdots \tri^m G_n' \tri^{nm}.
\end{align*}$$

We distinguish three cases:

- If there exist $$i \geq j$$ such that $$a_i \perp b_j$$, then we can match block $$G_j'$$ with the first occurrence of block $$F_i'$$, and then match the other blocks accordingly. That is, $$G_{j+s}'$$ matches to $$F_{i+s}'$$ for all $$s \in \{-j+1, \dots, n-j\}$$. Some blocks in $$F'$$ has to remain unmatched, but all the ▽ symbols in $$F'$$ are fully matched to $$G'$$. In particular, it shows that
$$\lcs(F,G) \geq n(\ell-1) + 1 + 2nm$$.

- If there exist $$i < j$$ such that $$a_i \perp b_j$$, then we can match $$G_j'$$ with the second occurrence of $$F_i'$$. A symmetric argument shows that $$\lcs(F,G) \geq n(\ell-1) + 1 + 2nm$$.

- Otherwise, there is no orthogonal vector. We claim that $$\lcs(F,G) \leq n(\ell-1) + 2nm$$. To this end, let us analyse the LCS of $$F, G$$.
	1. The total number of ▽ symbols in $$F$$ is $$2nm$$. So in the best case, the ▽ symbols can contribute $$2nm$$.
	2. Each block $$G_j'$$ can contribute at most $$\ell-1$$ to the LCS. Indeed, if $$G_j'$$ is matched to only one block $$F_i'$$, then by the lack of orthogonality we have $$\lcs(F_i', G_j') = \ell-1$$. On the other hand, if $$G_j'$$ ventures to match two (or more) blocks $$F_{i_1}', F_{i_2}'$$ in the hope to forge more contribution, then no ▽ symbol between $$F_{i_1}', F_{i_2}'$$ can be matched, so we lose at least $$m$$ in count 1. This is not profitable at all, as $$\card{G_j'} = m$$.
	3. To summarise, $$\lcs(F,G) \leq n(\ell-1) + 2nm$$.

Therefore, $$\lcs(F,G)$$ tells us whether there exists a pair of orthogonal vectors $$a_i, b_j$$. Note that $$\card{F}, \card{G} = O(nm) = O(nd^2)$$. If one can solve Longest Common Subsequence in time $$O((\card{F}+\card{G})^{2-\epsilon})$$, then we can solve Orthogonal Vector in time $$O(n^{2-\epsilon} d^4)$$.
