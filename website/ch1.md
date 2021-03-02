@def hascode = true
@def title = "Chapter 1"
@def tags = ["qubits", "chapter 1"]

# Chapter 1
The problems in this chapter are focused on qubit states and simple untiary operators.

\toc

## Background Material 
Any two-state quantum system can be used as a quantum bit (*qubit*); the corresponding quantum computing version of a bit but with the addition that it can be in a superposition state. 

The vector space with defined inner product (i.e. *Hilbert* space) that describes that state of a *qubit* is $\mathbb{C}^2$. 

The Dirac notation to denote an orthonormal qubit basis set is given as $ \{\ket{0},\ket{1}\} $ with the inner product defined as $ \braket{0|0}= \braket{1|1} = 1 $ and $ \braket{0|1} = \braket{1|0} = 0 $.

A *superposition* state can be written as:

$$ \ket{\psi} = \alpha \ket{0} + \beta \ket{1} $$ 

with the conditions that the inner product $ \braket{\psi|\psi} = \alpha^{*} \alpha \braket{0|0} + \beta^{*} \beta \braket{1|1} = 1 $

Examples of basis sets are:

\begin{equation} \ket{0} = \begin{pmatrix} 1 \\ 0 \end{pmatrix}, \hskip{5mm} \ket{0} = \begin{pmatrix} 0  \\ 1 \end{pmatrix} \end{equation}

\begin{equation} \ket{0} = \ket{+} = \frac{1}{\sqrt{2}} \begin{pmatrix} 1 \\ 1 \end{pmatrix}, \hskip{5mm} \ket{0} = \ket{-} = \frac{1}{\sqrt{2}} \begin{pmatrix} 1 \\ -1 \end{pmatrix} \end{equation}
## Problems

### Programming Problems
- [Problem 1](../ch1_problems/pp1)
- [Problem 2](../ch1_problems/pp2)
- [Problem 3](../ch1_problems/pp3)