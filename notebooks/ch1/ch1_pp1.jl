### A Pluto.jl notebook ###
# v0.12.21

using Markdown
using InteractiveUtils

# ╔═╡ 0fd56720-730b-11eb-3ec4-531a7d66207b
using SymPy

# ╔═╡ 37f2abdc-730b-11eb-1072-99952754ba94
md"""
**Problem 1.** Consider the *unary gates* (2 x 2 unitary matrices)

$N=\begin{pmatrix} 0 & 1 \\ 1 & 0 \end{pmatrix} \hskip{10mm} H = \frac{1}{\sqrt{2}} \begin{pmatrix} 1 & 1 \\ 1 & -1 \end{pmatrix}$

$V=\begin{pmatrix} 1 & 0 \\ 0 & e^{\frac{i\pi}{2}} \end{pmatrix} \hskip{10mm} W = \begin{pmatrix} 1 & 0 \\ 0 & e^{\frac{i\pi}{4}} \end{pmatrix}$

and the normalized state

$\ket{\psi} = \frac{1}{\sqrt{2}} \begin{pmatrix} 1 \\ 1 \end{pmatrix}$

calculate $U\ket{\psi}$ where $U = N\cdot H\cdot V \cdot W$ and also calculate the epectation value $\bra{\psi} U \ket{\psi}$.

Note that $U$ is the Pauli-X gate, $H$ the Hadamard gate, $V$ phase gate, and $W$ $\pi /8$ gate.

"""

# ╔═╡ 867ab1e8-7499-11eb-3464-755d09223c49
md"**Solution 1**"

# ╔═╡ fdd7e022-7312-11eb-1a44-63473aa24a1d
begin
	𝑖,π = sympy.symbols("𝑖 π")
	sqrthalf = 1/sympy.sqrt(2)
	e = sympy.exp
	⋅ = *
end;

# ╔═╡ 7c2bfa80-7313-11eb-0816-61d684a3c060
begin
	N = sympy.Matrix([0 1;
		 1 0])
	
	H = sqrthalf * sympy.Matrix([1 1;
				1 -1])
	
	V = sympy.Matrix([1 0;
	     0 e(𝑖⋅π / 2)])
	
	W = sympy.Matrix([1 0;
		 0 e(𝑖⋅π / 4)])
end;

# ╔═╡ 38600920-7315-11eb-0ef2-9fa20c309701
begin
	ψ = sqrthalf * sympy.Matrix([1;1])
	ψᵀ = ψ'
end;

# ╔═╡ e6c30106-73d4-11eb-0a0d-af21ddaff6f8
U = N ⋅ H ⋅ V ⋅ W;

# ╔═╡ 5909483e-7316-11eb-02b6-233bcb32cf9d
md"""
$ U = $(sympy.latex(U)) $
"""

# ╔═╡ b27b9544-7318-11eb-299c-55aa2d675aaf
ψₜ = U⋅ψ;

# ╔═╡ a007e39a-731c-11eb-1185-910c04060ed2
md"""
$ U \ket{\psi} =  $(sympy.latex(sympy.nsimplify(ψₜ))) $
"""

# ╔═╡ 31628a06-73d5-11eb-18da-2f9e1368c5db
md"""
The expectation $\bra{\psi} U \ket{\psi}$ is then:
"""

# ╔═╡ 4d61510a-731d-11eb-0245-6f2c35c42fca
𝙴 = ψᵀ ⋅ U ⋅ ψ;

# ╔═╡ 1f1d39e0-73d5-11eb-157a-a5fa6943ee18
md"
$ 𝙴 = $(sympy.latex(sympy.simplify((𝙴[1])))) $
"

# ╔═╡ Cell order:
# ╟─37f2abdc-730b-11eb-1072-99952754ba94
# ╟─867ab1e8-7499-11eb-3464-755d09223c49
# ╠═0fd56720-730b-11eb-3ec4-531a7d66207b
# ╠═fdd7e022-7312-11eb-1a44-63473aa24a1d
# ╠═7c2bfa80-7313-11eb-0816-61d684a3c060
# ╠═38600920-7315-11eb-0ef2-9fa20c309701
# ╠═e6c30106-73d4-11eb-0a0d-af21ddaff6f8
# ╟─5909483e-7316-11eb-02b6-233bcb32cf9d
# ╠═b27b9544-7318-11eb-299c-55aa2d675aaf
# ╟─a007e39a-731c-11eb-1185-910c04060ed2
# ╟─31628a06-73d5-11eb-18da-2f9e1368c5db
# ╠═4d61510a-731d-11eb-0245-6f2c35c42fca
# ╟─1f1d39e0-73d5-11eb-157a-a5fa6943ee18
