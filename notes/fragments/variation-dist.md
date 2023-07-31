---
layout: linear
date: 17 October 2022
title: Total Variation Distance
preamble: |-
    \newcommand{\abs}[1]{\left\lvert #1 \right\rvert}
    \newcommand{\tv}[2]{\norm{#1 - #2}_\mathrm{tv}}
returnPage: ./
---

How do we quantify the "closeness" of two probability distributions $$\mu, \nu: \Omega \to [0,1]$$? As they are just functions, we can adopt the $$\class{L}_p$$ norm of their difference as a metric. It turns out that the case $$p := 1$$ admits many interesting interpretations and will be the subject of our study. We focus on discrete space $$\Omega$$, but what are said here could obviously be generalised by replacing summation with integration.

**Definition.**
The *total variation distance* of distributions $$\mu,\nu: \Omega \to [0,1]$$ is defined as

$$ \tv{\mu}{\nu} := \frac{1}{2} \sum_{\omega \in \Omega} \abs{\mu(\omega) - \nu(\omega)}, $$

where we put an artificial $$1/2$$ for later convenience.


# A graphical perspective

![](./variation-dist.svg){:.centering}

Graphically, $$2 \tv{\mu}{\nu}$$ is just the area where $$\mu$$ is above $$\nu$$ (the yellow region), plus the area where $$\nu$$ is above $$\mu$$ (the blue region). But since "yellow+brown = 1 = blue+brown", the yellow and the blue areas must be both equal to $$\tv{\mu}{\nu}$$.

# A distinguisher's perspective

Consider a game between a judge and a distinguisher. The judge secretly flips a fair coin $$b \in \set{0,1}$$. If $$b = 1$$ then he presents the distinguisher a sample $$x \sim \mu$$; otherwise he presents a sample $$x \sim \nu$$. Based on what he sees, the distinguisher tries to deduce the value $$b$$, i.e. which distribution the $$x$$ was sampled from.

Let's first assume that the distinguisher is deterministic, so we may identify him with a partition of the whole space: $$\Omega = A \uplus \bar{A}$$. When he sees $$x \in A$$ he answers 1, otherwise he answers 0. Clearly he is correct with probability

$$\begin{align*}
	\Pr(\text{correct})
	&= \Pr(x \in A \mid b = 1) \Pr(b = 1) + \Pr(x \in \bar{A} \mid b = 0) \Pr(b = 0) \\
	&= \frac{1}{2} (\mu(A) + \nu(\bar{A})) \\
	&= \frac{1}{2} (1 + \mu(A) - \nu(A))
	= \frac{1}{2} (1 + \nu(\bar{A}) - \mu(\bar{A}))
\end{align*}$$

The quantity $$\mu(A) - \nu(A) = \nu(\bar{A}) - \mu(\bar{A})$$ characterises his "advantage" than a blind guess. But we notice

$$\begin{align*}
	(\mu(A) - \nu(A)) + (\nu(\bar{A}) - \mu(\bar{A}))
	&= \sum_{\omega \in A} \mu(\omega) - \nu(\omega) + \sum_{\omega \in \bar{A}} \nu(\omega) - \mu(\omega) \\
	&\leq \sum_{\omega \in \Omega} \abs{\mu(\omega) - \nu(\omega)} \\
	&= 2 \tv{\mu}{\nu}.
\end{align*}$$

So the advantage of any deterministic distinguisher, however smart he is, cannot beat the total variation distance. The statement readily generalises to randomised distinguishers by the total probability formula, since any randomised strategy is merely a probabilistic mixture of deterministic strategies.

Our derivation above also demonstrates an *optimal strategy* that achieves the bound, by taking $$A := \set{\omega \in \Omega: \mu(\omega) \geq \nu(\omega)}$$. Essentially, the distinguisher opts for the maximum likelihood.

All these results fit very well with our intuition: The closer two distributions are, the harder we may distinguish their samples. Total variation distance *is* the maximum advantage of a distinguisher. It is somewhat a pity that many books state the fact as a dry formula without the story:

$$ \tv{\mu}{\nu} = \sup_{A \subseteq \Omega} (\mu(A) - \nu(A)). $$


# A coupling perspective

Now we turn the game upside down. Your job is to design a probability space of two random variables $$x$$ and $$y$$, not necessarily independent, whose marginal distributions are $$\mu$$ and $$\nu$$ respectively. The goal is to minimise $$\Pr(x \neq y)$$.

For instance, if $$\mu = \nu$$ then we may design the following probability space: Sample $$x \sim \mu$$ and let $$y := x$$. Both variables have the correct marginal, and the probability $$\Pr(x \neq y) = 0$$ is the best we could hope for.

In general $$\mu$$ and $$\nu$$ may differ, and we aim at "coupling" them as much as we can, by carefully reusing randomness. The total variation distance is again an absolute barrier:

$$ \tv{\mu}{\nu} = \inf_{\text{coupling }x,y} \Pr(x \neq y). $$

The proof is quite easy with what we had developed so far. For any coupling $$(x,y)$$ and any $$A \subseteq \Omega$$, we have

$$ \mu(A) - \nu(A)
= \Pr(x \in A) - \Pr(y \in A)
\leq \Pr(x \in A, y \not\in A)
\leq \Pr(x \neq y). $$

So the supremum of the left hand side is at most the infimum of the right hand side, namely $$\tv{\mu}{\nu} \leq \inf_{\text{coupling }x,y} \Pr(x \neq y)$$. It remains to construct an *optimal coupling* that achieves this bound. We can describe it pictorially:

- set up an area-preserving bijection $$\phi$$ between the blue and the yellow regions;
- sample a uniform point $$(c,d) \in \Real^2$$ from the blue+brown regions;
- if it lands in the brown region then let $$x := y := c$$;
- if it lands in the blue region then let $$x := c$$ and $$y := c'$$ for $$(c',d') := \phi(c,d)$$.

It is easy to check that both marginals are correct, and that $$\Pr(x \neq y)$$ equals the blue area which is just $$\tv{\mu}{\nu}$$. Of course, for nitpickers our wording "area-preserving bijection" is not rigorous. Below we provide a formalization:

- denote $$A := \set{\omega \in \Omega: \mu(\omega) \geq \nu(\omega)}$$, function $$\gamma := \min(\mu, \nu)$$ and let $$p := \sum_{\omega \in \Omega} \gamma(\omega) = 1 - \tv{\mu}{\nu}$$;
- with probability $$p$$, sample $$c$$ from distribution $$\propto \gamma$$ and let $$x := y := c$$;
- with probability $$1-p$$, sample $$x$$ from distribution $$\propto \mathbb{1}_A \cdot (\mu - \nu)$$, and $$y$$ from distribution $$\propto \mathbb{1}_{\bar{A}} \cdot (\nu - \mu)$$, independent of each other.

We may calculate the marginal of $$x$$ as

$$
	p \frac{\gamma}{p} + (1-p) \frac{\mathbb{1}_A \cdot (\mu - \nu)}{\tv{\mu}{\nu}}
	= \gamma + \mathbb{1}_A \cdot (\mu - \nu)
	= \mu.
$$

The calculation for $$y$$ is symmetric. Finally, the two variables differ with probability $$1-p = \tv{\mu}{\nu}$$.

# Useful properties

We collect some useful properties of total variation distance and sketch their proofs.

**Triangle inequality.**
$$\tv{\mu}{\nu} \leq \tv{\mu}{\xi} + \tv{\xi}{\nu}$$ (by inspecting definition).

**Deterministic operation reduces distance.**
Assume $$x \sim \mu$$ and $$y \sim \nu$$, and $$f$$ is a function. Denoting by $$\mu',\nu'$$ the distributions of $$f(x),f(y)$$ respectively, we have $$\tv{\mu'}{\nu'} \leq \tv{\mu}{\nu}$$. (Any distinguisher for $$\mu',\nu'$$ can be used as a subroutine to distinguish $$\mu,\nu$$. Or if you prefer a forward argument, $$\mu'(A)-\nu'(A) = \mu(f^{-1}(A)) - \nu(f^{-1}(A)) \leq \tv{\mu}{\nu}$$.)

**Distance between products.**
$$\tv{\mu_1 \times \mu_2}{\nu_1 \times \nu_2} \leq \tv{\mu_1}{\nu_1} + \tv{\mu_2}{\nu_2}$$. (Consider say the product of the optimal couplings for the two coordinates. Then by union bound $$\Pr((x_1,y_1) \neq (x_2,y_2)) \leq \Pr(x_1 \neq x_2) + \Pr(y_1 \neq y_2)$$.)
