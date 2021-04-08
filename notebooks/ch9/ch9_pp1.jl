### A Pluto.jl notebook ###
# v0.12.21

using Markdown
using InteractiveUtils

# ╔═╡ e156ce76-9825-11eb-2ce6-51c9a61a04d6
begin
	using SymPy
end

# ╔═╡ 042d3b3a-9824-11eb-2238-73ee16385706
md"""**Problem 1.** Let $\ket{0}$ and $\ket{1}$ be the standard basis in $\mathbb{C}^2$, consider the Bell state corresponding to two qubits:

$\ket{\psi} = \frac{1}{\sqrt{2}}\left( \ket{0}_1 \otimes \ket{0}_2 + \ket{1}_1 \otimes \ket{1}_2 \right).$

If we now define two projection operators/matrices:

$\hat{P}_1 = \begin{pmatrix} 1 & 0 \\ 0 & 0 \end{pmatrix} \hskip{3mm} \hat{P}_2 = \begin{pmatrix} 0 & 0 \\ 0 & 1 \end{pmatrix}.$

Calculate the measurement probability of qubit 1 corresponding to $\hat{P}_1$. Furthermore show what the post-measurment state is and the probability for qubit 2 corresponding to $\hat{P}_1$ in the post-measured state. 

"""

# ╔═╡ c827b078-9825-11eb-2d0e-49003dc5e4d7
md"""**Solution.**"""

# ╔═╡ d2a52fbc-9825-11eb-0c8c-41086ac1a692
begin
	halfsqrt = 1/sympy.sqrt(2)
	⋅ = *
	⊗(X,Y) = kron(X,Y)
end;

# ╔═╡ f6939f8a-9825-11eb-2b97-bb15377c17ae
begin
	b₀ = [1;
		  0]
	b₁ = [0;
		  1]
	ψ = halfsqrt ⋅ (b₀ ⊗ b₀ + b₁ ⊗ b₁)
	ψ′= ψ.adjoint()
end;

# ╔═╡ cab3cd4a-982a-11eb-0588-1b7f6ed39850
md" 
  $ \ket{\psi} = $(sympy.latex(ψ)) $
"

# ╔═╡ 39be966e-9826-11eb-341d-9938733311b2
begin
	P̂₁ = sympy.Matrix([ 1 0;
		   	            0 0])
	P̂₂ = sympy.Matrix([ 0 0;
		                0 1])
	I₂ = sympy.eye(2,2)
end;

# ╔═╡ 6445e77c-9826-11eb-1381-2dca29e452f5
md"Notice that $\hat{P}_1 \cdot \hat{P}_2$ is:"

# ╔═╡ f519adc4-9826-11eb-331d-ad2f49b97052
P̂₁⋅P̂₂

# ╔═╡ 1705f9ba-9827-11eb-23cd-4d1d4b56ec71
md"""The measurment probability of qubit 1 having an outcome corresponding to $\hat{P}_1$ is given as:"""

# ╔═╡ c53d3196-9828-11eb-1754-1b58791d28ca
𝓞 = P̂₁ ⊗ I₂

# ╔═╡ 9f3ba3c4-982a-11eb-1cba-d1a89e9a945e
𝓞′ = 𝓞.adjoint();

# ╔═╡ 6ce335a0-9827-11eb-320c-bff6df9f1a98
p₁ = ψ′ ⋅ ( 𝓞′ ⋅ 𝓞 ) ⋅ ψ;

# ╔═╡ ae4a9d1c-9827-11eb-0926-0376f45930df
md"which is $ p_1(0) = $(p₁[1]) $ and noting that:"

# ╔═╡ 824b4436-9828-11eb-129c-29750110239f
md"$\left(\hat{P}_1 \otimes I_2\right)^2 = \hat{P}_1 \otimes I_2$."

# ╔═╡ b45153bc-9828-11eb-29f1-15a96c38e9c2
md"The resulting state from the projective measurement is then:"

# ╔═╡ 24076572-9829-11eb-27a6-61991178669c
ϕ = 1/√p₁[1] ⋅ 𝓞 ⋅ ψ |> sympy.Matrix

# ╔═╡ dd1dbc30-9829-11eb-276d-9961d84b0e84
md"This resulting state is no longer entangled (i.e. it collapsed in the parlance of measurment interpretation). The measurement probability on the projective measurment state for the outcome of qubit 2 corresponding to the operaor $\hat{P}_1$ is such:"

# ╔═╡ 183402de-982a-11eb-3c1f-5f98d38ee402
begin
	ϕ′ = ϕ.adjoint()
	p₂ = ϕ′ ⋅ ( 𝓞′ ⋅ 𝓞 ) ⋅ ϕ
end;

# ╔═╡ 39c629a8-982b-11eb-278c-cf872999d061
	md" $ p_2(0) = $(p₂[1]) $"


# ╔═╡ Cell order:
# ╟─042d3b3a-9824-11eb-2238-73ee16385706
# ╟─c827b078-9825-11eb-2d0e-49003dc5e4d7
# ╠═e156ce76-9825-11eb-2ce6-51c9a61a04d6
# ╠═d2a52fbc-9825-11eb-0c8c-41086ac1a692
# ╠═f6939f8a-9825-11eb-2b97-bb15377c17ae
# ╟─cab3cd4a-982a-11eb-0588-1b7f6ed39850
# ╠═39be966e-9826-11eb-341d-9938733311b2
# ╟─6445e77c-9826-11eb-1381-2dca29e452f5
# ╟─f519adc4-9826-11eb-331d-ad2f49b97052
# ╟─1705f9ba-9827-11eb-23cd-4d1d4b56ec71
# ╠═c53d3196-9828-11eb-1754-1b58791d28ca
# ╠═9f3ba3c4-982a-11eb-1cba-d1a89e9a945e
# ╠═6ce335a0-9827-11eb-320c-bff6df9f1a98
# ╟─ae4a9d1c-9827-11eb-0926-0376f45930df
# ╟─824b4436-9828-11eb-129c-29750110239f
# ╟─b45153bc-9828-11eb-29f1-15a96c38e9c2
# ╠═24076572-9829-11eb-27a6-61991178669c
# ╟─dd1dbc30-9829-11eb-276d-9961d84b0e84
# ╠═183402de-982a-11eb-3c1f-5f98d38ee402
# ╟─39c629a8-982b-11eb-278c-cf872999d061
