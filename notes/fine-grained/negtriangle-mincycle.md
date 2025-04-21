---
layout: linear
date: 21 Ipril 2025
title: Negative Triangle → Min k-Cycle
returnPage: ./
---

We are given a tripartite graph $$G$$ on $$I \cup J \cup K$$, each of $$n$$ vertices. We modify it to another graph $$G'$$ as follows. First, we introduce another $$k-3$$ parts $$I_1, \dots, I_{k-3}$$, each an isomorphic copy of $$I$$. We move all edges between $$I,K$$ to between $$I_{k-3},K$$; so there is no edge between $$I,K$$ any more. Next, for each $$t = 1, \dots, k-4$$, we connect the matching pairs between $$I_t$$ and $$I_{t+1}$$ and given them zero weight.

Clearly we obtain a $$k$$-partite graph $$G'$$ whose cycles one-one correspond to triangles in $$G$$. Moreover, the weights of cycles are preserved. Therefore, solving Min k-Cycle on $$G'$$ is equivalent to solving Min Triangle on $$G$$, from which we can answer Negative Triangle.

The additional time we spend is just $$k \cdot O(n^2) = O(n^2)$$. So any subcubic-time algorithm for Negative Triangle leads to a subcubic-time algorithm for Min k-Cycle.
