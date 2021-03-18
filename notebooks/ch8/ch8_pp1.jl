### A Pluto.jl notebook ###
# v0.12.21

using Markdown
using InteractiveUtils

# ╔═╡ 9ba4f93c-87a6-11eb-0611-07528c3e842f
begin 
	using LinearAlgebra
end

# ╔═╡ 4f4e926e-87a6-11eb-28c3-2900b3ecd01e
md"""**Problem 1.** Consider the density matrix:

$\rho = \begin{pmatrix} 5/12 & 1/6 & 1/6 \\ 1/6 & 1/6 & 1/6 \\ 1/6 & 1/6 & 5/12 \end{pmatrix}$

show that we have a mixed state. Find the von Neumann entropy.
"""

# ╔═╡ 9438c3ea-87a6-11eb-0ae5-b90b9938885f
md"""**Solution.**"""

# ╔═╡ 9f2ad41e-87a6-11eb-08df-f5cde37652d1
begin
	⋅ = *
	𝚝𝚛 = tr
	entropy(X::Array{T,1}) where T<: Number = begin
		χ = 0.00e0
		for i=1:length(X)
			χ -= X[i]*log(X[i])
		end
		return χ
	end
			
	entropy(X::Array{T,2}) where T<: Number = -1⋅𝚝𝚛(X⋅log(X))
end;

# ╔═╡ accab4b8-87a6-11eb-269d-1150fa723fdc
begin
	ρ = [5//12 1//6 1//6;
		 1//6  1//6 1//6;
		 1//6  1//6 5//12]
end;

# ╔═╡ ca29e538-87a6-11eb-01c8-dbaa8b09f681
md"""First we check if the density matrix is idempotent, i.e. $\rho^2 = \rho$, if true the matrix is pure else its mixed."""

# ╔═╡ 05c69956-87a7-11eb-0b40-b31fc78ba42d
ρ⋅ρ == ρ

# ╔═╡ 1aeecefc-87a7-11eb-0faa-914ef46c25ce
md"""So the matrix is not a pure state and indeed a mixed.

The von Neumann entropy can be calculated in two equivalent ways:

$S(\rho) = -\text{tr}(\rho \log(\rho))$

$S(\rho) = \sum_i^N \lambda_i \log(\lambda_i)$

where $\lambda_i$ are the eigenvalues. both calculations are given below."""

# ╔═╡ 8975c880-87a7-11eb-1aba-9735e5f307a1
entropy(ρ)

# ╔═╡ c0d614ec-87a7-11eb-3074-5ba8d2257963
𝐞ᵢ = eigen(ρ).values;

# ╔═╡ 153601f2-87a8-11eb-016f-75adcb309000
entropy(𝐞ᵢ)

# ╔═╡ Cell order:
# ╟─4f4e926e-87a6-11eb-28c3-2900b3ecd01e
# ╟─9438c3ea-87a6-11eb-0ae5-b90b9938885f
# ╠═9ba4f93c-87a6-11eb-0611-07528c3e842f
# ╠═9f2ad41e-87a6-11eb-08df-f5cde37652d1
# ╠═accab4b8-87a6-11eb-269d-1150fa723fdc
# ╟─ca29e538-87a6-11eb-01c8-dbaa8b09f681
# ╠═05c69956-87a7-11eb-0b40-b31fc78ba42d
# ╟─1aeecefc-87a7-11eb-0faa-914ef46c25ce
# ╠═8975c880-87a7-11eb-1aba-9735e5f307a1
# ╠═c0d614ec-87a7-11eb-3074-5ba8d2257963
# ╠═153601f2-87a8-11eb-016f-75adcb309000
