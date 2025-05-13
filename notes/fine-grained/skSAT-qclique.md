---
layout: linear
date: 4 May 2025
title: Sparse k-SAT → q-Clique
returnPage: ./
---

Let $$k,q \in \Nat$$. Assuming sparse ETH, there exist constants $$s, c > 0$$ such that s-sparse k-SAT is not in time $$O(2^{cn})$$. From now on we fix these constants. Given an s-sparse k-SAT formula $$\phi = C_1 \land \cdots \land C_m$$ on variables $$x_1, \dots, x_n$$, we construct a graph $$G$$ as follows.

First, we evenly partition $$\{C_1, \dots, C_m\} =: \class{C}_1 \cup \cdots \cup \class{C}_{q/2}$$, where each group $$\class{C}_i$$ contains $$2m/q$$ clauses. Likewise, we evenly partition $$\{x_1, \dots, x_n\} =: X_1 \cup \cdots \cup X_{q/2}$$, where each group $$X_j$$ contains $$2n/q$$ variables.

Next we consider a clause group $$\class{C}_i$$. We introduce a new vertex for each tuple $$(l_1, \dots, l_{2m/q}) \in \prod_{C \in \class{C}_i} C$$. (Here, we identify a clause with the set of literals contained in the clause; for example, $$x_1 \lor \overline{x_4} \lor x_6$$ is treated as $$\set{x_1, \overline{x_4}, x_6}$$.) It represents the "responsible" literals for satisfying the clauses in this group. There are $$k^{2m/q}$$ vertices, and we do *not* connect any edge in between. We construct vertices in a similar way for every clause group, so altogether we get $$\frac{q}{2} k^{2m/q}$$ vertices. We make full connections between vertices of different clause groups.

Then we consider a variable group $$X_j$$. We introduce a new vertex for each assignment $$f: X_j \to \{0,1\}$$. This amounts to $$2^{2n/q}$$ vertices, and we do *not* connect any edge in between. We repeat the construction for every variable group, so altogether we get $$\frac{q}{2} 2^{2n/q}$$ vertices. We make full connections between vertices of different variable groups.

Now that we have constructed two collections of vertices, we connect edges between them. A tuple $$(l_1, \dots, l_{2m/q})$$ is adjacent to a partial assignment $$f$$ iff none of $$l_1, \dots, l_{2m/q}$$ evaluate to 0 under $$f$$. (We do allow literals evaluating to "unspecified".) This finishes the description of graph $$G$$.

We claim that $$\phi$$ is satisfiable iff there exists a q-clique in $$G$$.

- Suppose that some assignment $$g: \{x_1, \dots, x_n\} \to \{0,1\}$$ satisfies $$\phi$$. Then each clause $$C$$ has at least one literal $$l(C)$$ that evaluates to 1 under $$g$$. In particular, $$l(C)$$ does not evaluate to 0 under any restriction of $$g$$. Thus the following vertices form a q-clique in $$G$$:
	- for each clause group $$\class{C}_i =: \{C_i^1, \dots, C_i^{2m/q}\}$$, select the tuple $$(l(C_i^1), \dots, l(C_i^{2m/q}))$$;
	- for each variable group $$X_j$$, select the assignment $$g \vert_{X_j}$$.
- Conversely, suppose that there exists a q-clique in $$G$$. Since there are only $$q$$ (clause + variable) groups and there is no edge inside each group, the clique has to select exactly one tuple from each clause group and exactly one partial assignment from each variable group. Let $$f_1, \dots, f_{q/2}$$ be the selected partial assignments, which together defines a total assignment $$g := f_1 \cup \cdots f_{q/2}$$. By definition of a clique, all partial assignments are adjacent to all tuples. Therefore, every clause contains a literal (as described in the tuples) not evaluating to 0 under $$g$$; then the literal must evaluate to 1 and the clause is satisfied.

Finally, we analyse the time complexity. The graph has $$N := \frac{q}{2} \cdot (2^{2n/q} + k^{2m/q}) = O(2^{2s \log(k) n / q})$$ vertices, where we used the fact that $$m \leq sn$$. Define a constant $$\epsilon := \frac{c}{2 s\log(k)}$$. If q-Clique on $$N$$-vertex graphs is in time $$O(N^{\epsilon q})$$, then we can apply the reduction above and solve s-sparse k-SAT in time $$O(2^{cn})$$, which contradicts with the choice of $$s,c$$. It is worth noting that the constant $$\epsilon$$ does not depend on $$q$$.
