### A Pluto.jl notebook ###
# v0.12.21

using Markdown
using InteractiveUtils

# ╔═╡ bceeebe8-9507-11eb-34a5-f3c55972cf5e
begin
	using SymPy
end

# ╔═╡ ea815c04-9506-11eb-3564-498bb82fc565
md"""**Problem 2.** Consider the standard basis $\ket{0}$, $\ket{1}$, and the state:

$\ket{\psi} = \frac{1}{\sqrt{2}}\left(\ket{0}\otimes\ket{0} + \ket{1}\otimes\ket{1}\right)$.

Given the projection matrices:

$P_1 = \frac{1}{2}\left(I_2 - \sigma_x\right) \hskip{5mm} P_2 = \frac{1}{2}\left(I_2 + \sigma_z\right)$

Find the expectation value for the projection matrices on the state vector in the $\mathbb{C}^2$ Hilbert space

"""

# ╔═╡ b19a4288-9507-11eb-1e5b-b3aed82036f7
md"""**Solution.**
"""

# ╔═╡ c34645ae-9507-11eb-1ea8-ff0da31d567f
begin
	𝑖 = sympy.I
	sqrthalf = 1/sympy.sqrt(2)
	⋅ = *
	⊗(X,Y) = kron(X,Y)
end;

# ╔═╡ 17c17716-9508-11eb-3189-116a83e5e993
begin
	b₀ = [1;
		  0]
	b₁ = [0;
		  1]
	ψ = sqrthalf ⋅ (b₀ ⊗ b₀ + b₁ ⊗ b₁)
	ψᵃ = ψ.adjoint()
end;

# ╔═╡ 65d8a0e6-9508-11eb-3ac4-d1e06c7c9faf
begin
	I₂ = sympy.eye(2,2)
	σx = sympy.Matrix([0 1;
			           1 0])
	σz = sympy.Matrix([1 0;
			           0 -1])
end;

# ╔═╡ a671989c-9508-11eb-13e9-0908fded6259
begin
	P₁ = 1/2 ⋅ (I₂ - σx)
	P₂ = 1/2 ⋅ (I₂ + σz)
	P₁₂ = P₁ ⊗ P₂
end;

# ╔═╡ 5391332a-9509-11eb-280e-0b1231eb4799
md"""The projection matrix over the $\mathbb{C}^2$ space is then:

$P_{12} = P_1 \otimes P_2 =$

$ $(sympy.latex(P₁₂)) $

"""

# ╔═╡ cabfe212-9508-11eb-304e-19e96f09e961
expectation = ψᵃ⋅P₁₂⋅ψ;

# ╔═╡ 35d92cb2-950a-11eb-25a0-492b4ab714cb
md"""
The expectation, $\langle \psi | P_1 \otimes P_2 | \psi \rangle$, is: 

 $ $(expectation[1]) $

"""

# ╔═╡ Cell order:
# ╟─ea815c04-9506-11eb-3564-498bb82fc565
# ╟─b19a4288-9507-11eb-1e5b-b3aed82036f7
# ╠═bceeebe8-9507-11eb-34a5-f3c55972cf5e
# ╠═c34645ae-9507-11eb-1ea8-ff0da31d567f
# ╠═17c17716-9508-11eb-3189-116a83e5e993
# ╠═65d8a0e6-9508-11eb-3ac4-d1e06c7c9faf
# ╠═a671989c-9508-11eb-13e9-0908fded6259
# ╟─5391332a-9509-11eb-280e-0b1231eb4799
# ╠═cabfe212-9508-11eb-304e-19e96f09e961
# ╟─35d92cb2-950a-11eb-25a0-492b4ab714cb
