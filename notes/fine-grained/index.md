---
layout: linear
title: "Fine-Grained Reductions"
about: "A collection of fine-grained reductions from central problems: satisfiability, orthogonal vectors, 3-sum, and all-pair shortest paths."
---

In fine-grained complexity theory, we relate problems within **P** via reductions. But to achieve this, we must restrict ourselves to *really fast* reductions whose running time is strictly dominated by the best-known algorithm of the target problem. That is, when we reduce a problem A to another problem B, the time we spend on the actual reduction should be less than the time of solving B (by the currently best algorithm). This way, any speedup in B transfers to a speedup in A.

There is another interpretation for this approach. Several central problems (e.g. all-pair shortest path) are believed to be hard, in the sense that they cannot be solved in certain time regime (e.g. in $$O(n^{2.99})$$ time). If we use them as the starting points of reductions, then we get *conditional lower bounds* for other problems.

The diagram below summarises some well-known reductions. Click on an edge to see the details.

<div style="overflow:scroll">
	<object type="image/svg+xml" data="navigation.svg"></object>
</div>
