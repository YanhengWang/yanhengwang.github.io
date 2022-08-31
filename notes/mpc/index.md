---
layout: linear
date: March–August 2022
title: Secure Multi-Party Computation
about: A mix of benevolent and malicious parties are engaged in a computational task, where each party provides an input. Is there a protocol that protects the input privacy of benevolent parties?
---

Consider the situation where multiple parties jointly compute a function of their private inputs, e.g. calculating their average age. Some parties might be malicious and try to infer others' inputs. They pool their information together ("passive attack") or even deviate from the protocol ("active attack"). Moreover, the delivery of messages might be postponed/reordered ("asynchrony").

How can the parties orchestrate the computation so that the inputs of benevolent parties are secure? We will start from scratch and build protocols against synchronous passive, synchronous active, and finally asynchronous active adversaries. Excitingly, all the protocols use only "elementary mathematics": Some counting arguments, discrete probability, and polynomials over finite fields. Most of them do not even need cryptographic assumption!

The notes are based on a [course](https://crypto.ethz.ch/teaching/CP22/) by Dr. Martin Hirt.

[➤ PDF notes download](./MPC.pdf)
