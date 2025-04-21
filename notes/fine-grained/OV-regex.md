---
layout: linear
date: 30 March 2025
title: Orthogonal Vector → Regex Matching
returnPage: ./
---

We are given two sets of vectors $$\{a_1, \dots, a_n\} \subseteq \{0,1\}^d$$ and $$\{b_1, \dots, b_n\} \subseteq \{0,1\}^d$$. We construct a text string $$t := a_1 \$ \cdots \$ a_n$$ where \$ is a special symbol that delimits the vectors. Then for each $$j \in [n]$$, we build a regex $$p_j = p_{j1} \circ \cdots \circ p_{jd}$$ that encodes the orthogonality constraint to $$b_j =: (b_{j1}, \dots, b_{jd})$$, where

$$ p_{jk} := \begin{cases}
	(0 \vert 1) & b_{jk} = 0, \\
	0 & b_{jk} = 1.
\end{cases} $$

Finally, we join the pieces to form a pattern string $$p = p_1 \vert \cdots \vert p_n$$.

Observe that if $$p$$ finds a match in $$t$$, then the match must happen between some $$p_j$$ and some $$a_i$$. This is because the delimiter \$ does not appear in the pattern string. Next, note that $$p_j$$ matches $$a_i$$ iff $$a_i \perp b_j$$. Therefore, we conclude that $$p$$ finds a match in $$t$$ iff there exists a pair of orthogonal vectors.

The lengths of $$t,p$$ are $$m = O(nd)$$ and can be constructed in the same time. So if Regex Matching is in time $$O(m^{2-\epsilon})$$, then Orthogonal Vector is in time $$O((nd)^{2-\epsilon})$$.

**Exercise.**
Modify the reduction so that the text string uses symbols 0 and 1 only.
