---
layout: linear
date: 21 April 2025
title: Min k-Cycle → APSP
returnPage: ./
---

Assume that the input graph $$G$$ has parts $$V_0, \dots, V_{k-1}$$ with edges between every $$V_t$$ and $$V_{(t+1) \bmod n}$$. We define a subgraph $$H \subset G$$ by removing the edges between $$V_0$$ and $$V_k$$. We run the APSP algorithm on $$H$$ to compute the distance $$d_H(u,v)$$ between every $$u \in V_0$$ and $$v \in V_k$$. Then we output

$$ \min_{uv \in V_0 \times V_k} d_H(u,v) + w(u,v). $$

The runtime analysis is straightforward. We spend only $$O(n^2)$$ time additional to the APSP call. If the latter can be solved in subcubic time, then we would solve Min k-Cycle in subcubic time.

The correctness argument is easy too. If a minimum k-cycle $$C$$ in $$G$$ uses edge $$uv \in V_0 \times V_k$$, then $$C-uv$$ must be a shortest $$uv$$-path in $$H$$, and thus $$w(C) = w(u,v) + d_H(u,v)$$. Conversely, for every edge $$uv \in V_0 \times V_k$$, the sum $$w(u,v) + d_H(u,v)$$ corresponds to the weight of some actual cycle.
