---
layout: linear
date: 12 March 2025
title: Triangle → Boolean Matrix Product
returnPage: ./
---

Given a tripartite graph on $$I,J,K$$, we let $$A, B$$ be the bi-adjacency matrix between $$I,J$$ and between $$J,K$$. Then we compute their Boolean product $$C := AB$$. That is, $$C_{ik} = \bigvee_k (A_{ik} \land B_{kj})$$. In other words, $$C_{ik} = 1$$ iff there exists a two-path $$i \to j \to k$$. Hence, there exists a triangle iff there exists an edge $$ik \in I \times K$$ such that $$C_{ik} = 1$$.

One can also mimic part of the reduction [(Min,+) Matrix Product → Negative Triangle](minplus-negtriangle.html) to show that Boolean Matrix Product → All-Pair Triangle (in subquadratic time). We leave it as an exercise. However, when we try to use the "grouping" idea to reduce All-Pair Triangle → Triangle, we encounter an efficiency bottleneck. The reason is as follows. The currently best known algorithms for Triangle and Boolean Matrix Product use fast matrix multiplication, which runs in $$T(n) = O(n^\omega)$$ time with $$2 \leq \omega < 2.38$$. On the other hand, the reduction requires $$O(n^2) T(n^{1/3}) = O(n^{2 + \omega/3})$$ time, which actually dominates $$T(n)$$ and hence does not qualify as a *fine-grained* reduction. To phrase it differently, this reduction cannot transfer algorithmic progress on Triangle towards progress on Boolean Matrix Product.
