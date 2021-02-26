### A Pluto.jl notebook ###
# v0.12.21

using Markdown
using InteractiveUtils

# ╔═╡ 58f5b716-77a2-11eb-03fe-a512c4450e42
using SymPy

# ╔═╡ 91b30e42-77a1-11eb-3120-abed92a7462c
md"""
**Problem 3.** Let M be a 2 x 2 matrix and $M^T$ the transpose. If $\ket{0}$ and $\ket{1}$ are standard basis in $\mathbb{C}^2$, then show that:

$\left(M\otimes I_2\right)\left(\ket{0} \otimes \ket{0} + \ket{1} \otimes \ket{1}\right) = \left(I_2 \otimes M^T\right)\left(\ket{0} \otimes \ket{0} + \ket{1} \otimes \ket{1}\right)$
"""

# ╔═╡ 292b4352-77a2-11eb-1508-77d1c07c9fa7
md"""
**Solution 3.** Let us first look at the tensor product $M \otimes I_2$ and $I_2 \otimes M$. Note that $I_2$ is a 2x2 identity matrix.
"""

# ╔═╡ c6abe9f6-77a2-11eb-10cf-8390b880b264
begin
	#⊗(x,y) = sympy.tensorproduct(x,y) # Doesn't seem to work properly.
	⊗(x::Array{Sym,2},y::Array{Sym,2}) = kron(x,y)
	𝐓(x::Array{Sym,2}) = sympy.Matrix(sympy.transpose(x))
	⋅ = *
end;

# ╔═╡ 5de2dbfa-77a2-11eb-3828-0557ce5097e1
begin
	M₁,M₂,M₃,M₄ = sympy.symbols("M₁₁ M₁₂ M₂₁ M₂₂")
	M= sympy.Matrix([M₁ M₂;
			         M₃ M₄])
	I₂ = sympy.eye(2,2)
end;

# ╔═╡ 8c951e38-77be-11eb-2bf4-0727e1a2b70b
𝓞₁ = M ⊗ I₂

# ╔═╡ b2e96134-77be-11eb-3d4a-d53ef9e56ac8
𝓞₂ = I₂ ⊗ M

# ╔═╡ efdb6438-77a3-11eb-1ea9-0fe118c77252
begin
	ψ₀ = sympy.Matrix([1;
		               0])
	ψ₁ = sympy.Matrix([0;
		               1])
end;

# ╔═╡ b989a380-77b9-11eb-3055-9d97556fb4b3
expr1 = 𝓞₁ ⋅ ((ψ₀⊗ψ₀) + (ψ₁⊗ψ₁));

# ╔═╡ 08d2705e-77ba-11eb-0c52-0b07a66f2be7
expr2 = 𝓞₂ ⋅ ((ψ₀⊗ψ₀) + (ψ₁⊗ψ₁));

# ╔═╡ 1e5dddc8-77ba-11eb-2db6-5d31beb63aa9
begin
	md"""
	Lets see if these two expressions are equivalent with $\ket{\psi_1^\prime} = M \otimes I_2 \ket{\psi_1}$ and $\ket{\psi_2^\prime} = I_2 \otimes M \ket{\psi_2}$:
	
	$ \ket{\psi_1^\prime}=$(sympy.latex(expr1)) $
	
	$ \ket{\psi_2^\prime}=$(sympy.latex(expr2)). $
	
	In fact they are not. Now lets see if $M^T$ makes a difference for $\ket{\psi_2^\prime} = I_2 \otimes M^T \ket{\psi_2}$.
	"""
end

# ╔═╡ a0dc99ec-77ba-11eb-1d38-7d7846d4d1a0
begin
	𝓞₃ = (I₂ ⊗ 𝐓(M))
	expr3 = 𝓞₃ ⋅ ((ψ₀⊗ψ₀) + (ψ₁⊗ψ₁));
end;

# ╔═╡ ec36ff8c-77bc-11eb-26af-c36a8f864879
expr1 == expr3

# ╔═╡ e0e76c78-77bb-11eb-3e98-394a0cdabbfc
md"""
Indeed the are equal:

$ \ket{\psi_1^\prime}=$(sympy.latex(expr1)) $

$ \ket{\psi_2^\prime}=$(sympy.latex(expr3)). $

What happens for the orthonormal basis:

$\ket{\psi_1} = \begin{pmatrix} \cos{\theta} \\ \sin{\theta} \end{pmatrix} \hskip{5mm} \ket{\psi_2} = \begin{pmatrix} \sin{\theta} \\ -\cos{\theta} \end{pmatrix}$


"""

# ╔═╡ d012f470-77c1-11eb-0a2f-6b76806ed916
begin
	θ = sympy.symbols("θ",real=true)
	ψₐ = sympy.Matrix([cos(θ);
			           sin(θ)])
	ψᵦ = sympy.Matrix([sin(θ);
			           -cos(θ)])
end;

# ╔═╡ 53514b48-77c2-11eb-1551-2b6ee6e88d95
expr4 = 𝓞₁ ⋅ (( ψₐ ⊗ ψₐ) + (ψᵦ ⊗ ψᵦ))

# ╔═╡ 8dce02ca-77c2-11eb-0c03-430705b026b7
expr5 = 𝓞₃ ⋅ (( ψₐ ⊗ ψₐ) + (ψᵦ ⊗ ψᵦ))

# ╔═╡ bf94412a-77c2-11eb-165a-d5432827727b
md"Indeed they are the same:"

# ╔═╡ c94a07e0-77c2-11eb-1bc1-79598b7a7752
sympy.trigsimp(expr4) == sympy.trigsimp(expr5)

# ╔═╡ Cell order:
# ╟─91b30e42-77a1-11eb-3120-abed92a7462c
# ╟─292b4352-77a2-11eb-1508-77d1c07c9fa7
# ╠═58f5b716-77a2-11eb-03fe-a512c4450e42
# ╠═c6abe9f6-77a2-11eb-10cf-8390b880b264
# ╠═5de2dbfa-77a2-11eb-3828-0557ce5097e1
# ╠═8c951e38-77be-11eb-2bf4-0727e1a2b70b
# ╠═b2e96134-77be-11eb-3d4a-d53ef9e56ac8
# ╠═efdb6438-77a3-11eb-1ea9-0fe118c77252
# ╠═b989a380-77b9-11eb-3055-9d97556fb4b3
# ╠═08d2705e-77ba-11eb-0c52-0b07a66f2be7
# ╟─1e5dddc8-77ba-11eb-2db6-5d31beb63aa9
# ╠═a0dc99ec-77ba-11eb-1d38-7d7846d4d1a0
# ╠═ec36ff8c-77bc-11eb-26af-c36a8f864879
# ╟─e0e76c78-77bb-11eb-3e98-394a0cdabbfc
# ╠═d012f470-77c1-11eb-0a2f-6b76806ed916
# ╠═53514b48-77c2-11eb-1551-2b6ee6e88d95
# ╠═8dce02ca-77c2-11eb-0c03-430705b026b7
# ╟─bf94412a-77c2-11eb-165a-d5432827727b
# ╠═c94a07e0-77c2-11eb-1bc1-79598b7a7752
