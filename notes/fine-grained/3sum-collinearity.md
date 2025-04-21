---
layout: linear
date: 14 March 2025
title: 3-Sum → Collinearity
returnPage: ./
---

Given a 3-Sum instance $$A[1 \dots n], B[1 \dots n], C[1 \dots n]$$, we map each $$x \in A \cup B \cup C$$ to a point $$(x, x^3) \in \Real^2$$. Three points $$(a,a^3), (b,b^3), (c,c^3)$$ are collinear iff the line through the first and second points has the same slope as the line through the second and third points. Formally, the condition writes

$$\begin{align*}
	& & \frac{b^3 - a^3}{b - a} &= \frac{c^3 - b^3}{c - b} \\
	&\iff & a^2 + ab + b^2 &= b^2 + bc + c^2 \\
	&\iff & a^2 + ab &= c^2 + bc \\
	&\iff & (a+c)(a-c) &= b(c-a) \\
	&\iff & a + b + c &= 0.
\end{align*}$$

So the 3-Sum instance has answer "yes" iff there exist three collinear points.
