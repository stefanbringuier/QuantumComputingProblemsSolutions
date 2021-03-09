@def hascode = true
@def title = "Chapter 4"
@def tags = ["density operators", "chapter 4"]

# Chapter 4
The problems in this chapter are focused on density operators.  
\toc
## Background material
The most frequent use of density operators/matrices is describing the statistical state of a quantum systems. In other words given all possible *pure* states whats the probability of any given state.

The expectation of a hermitian matrix corresponding to an observable corresponds to the average given by:

$$ \langle \hat{O} \rangle \coloneqq \text{tr}(\hat{O} \rho) $$

where $\rho$ is the density matrix that can describe a *pure* or *mixed state*. In the case of a *pure* state its simply given by $\rho=\ket{\psi}\bra{\psi}$ and has the property that $\rho^2 = \rho $, i.e., [idempotent](https://en.wikipedia.org/wiki/Idempotent).

## Problems

### Programing Problems
- [Problem 1](../ch4_problems/pp1)
- [Problem 2](../ch4_problems/pp2)
- [Problem 3](../ch4_problems/pp3)