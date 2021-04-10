@def hascode = true
@def title = "Chapter 9"
@def tags = ["measurement", "chapter 9"]
# Chapter 8
The problems of this chapter are focused on measurement probability.
\toc

## Background material
In quantum theory the mathematics that describes the observation of a physical occuring event (process) is only provided probabilistically. This means that the physical system in the quantum state $|\Phi\rangle$ can actually be discussed as having a probability of being in a quantum state $|\Psi\rangle$, this is given as:

$$ \left| \langle \Phi | \Psi \rangle \right|^2 .$$

If $|\Phi\rangle = |\Psi\rangle$, then its the probability of being is a specific quantum state $|\Psi\rangle$. The outcome for a measurement, more specifically a measurement operator corresponding to an observable in some state $\psi$, has a probability:

$$ p_i = \langle \psi | \mathcal{O}^{\dagger}_i \mathcal{O}_i | \psi \rangle $$

where $i$ corresponds to a specific measurment outcome, for example, spin-up or spin-down of an electron. Because something had to happen during the outcome of applying a measurment operator or equally saying "observing a measurement", the set of outcomes -- our spin-up and spin-down for example -- requires that they form a complete set. This is represented by the completeness equation:

$$ \sum_i \mathcal{O}^{\dagger}_i \mathcal{O}_i = \mathbf{I}, $$

where $\mathbf{I}$ is the identity. In the example of spin-up and spin-down particles the two operators in matrix form are:

$$
P_{\uparrow}  = \begin{pmatrix} 1 & 0 \\ 0 & 0 \end{pmatrix} \hskip{3mm}
P_{\downarrow}  = \begin{pmatrix} 0 & 0 \\ 0 & 1 \end{pmatrix}
$$
## Problems

### Programing Problems
- [Problem 1](../ch9_problems/pp1)
- [Problem 2](../ch9_problems/pp2)

