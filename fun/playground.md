---
layout: page
date: 7 January 2021
title:  Playground
---

# Header 1

## Header 1.1

- item
- item

1. item
1. item

| header | header |
| ------ | ------ |
| entry  | entry  |


Let $f: \Real \to \Real$ be a convex function and $X$ be a random variable, then

$$ \Exp_D(f(X)) \geq f(\Exp_D(X)). $$

Testing other macros: $\Pr_D(X = 1)$, $\rank(A+B) \leq \rank(A) + \rank(B)$, $\norm{a+b}^2 \leq \norm{a}^2 + \norm{b}^2$, $\class{A}$,

$$ \inner{\lambda x}{y+z} = \lambda \inner{x}{y} + \lambda \inner{x}{z}. $$

A more complicated formula:

$$ \begin{align}
    e_k &= \sum_{i=0}^{n-3} \binom{i}{k} h_i \\
    h_i &= h_{n-1-i}
\end{align} $$

*italic*, **bold**, ***bold italic***

Code snippets:

```c++
#include <iostream>
#include <unordered_map>
#include <vector>
#include <string>

using namespace std;
void testcase(void);

int main() {
    int t;
    ios_base::sync_with_stdio(false);
    cin >> t;
    while(t--)
        testcase();
    return 0;
}

void testcase(){
    int ancestor[50005][17];    // ancestor[v,i] := the (2^i)-th ancestor of v
    int nSpecies, nQueries, root;
    cin >> nSpecies >> nQueries;

    vector<int> age(nSpecies);
    vector<string> name(nSpecies);
    vector<bool> isRoot(nSpecies, true);
    unordered_map<string,int> indexMap;    // maps from name to index
    for(int i=0; i<nSpecies; i++){
        cin >> name[i] >> age[i];
        indexMap[name[i]] = i;
    }
    for(int i=0; i<nSpecies-1; i++){
        string child, parent;
        cin >> child >> parent;
        isRoot[indexMap[child]] = false;
        ancestor[indexMap[child]][0] = indexMap[parent];
    }
}
```