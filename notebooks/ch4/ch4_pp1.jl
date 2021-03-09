### A Pluto.jl notebook ###
# v0.12.21

using Markdown
using InteractiveUtils

# ╔═╡ 070b3584-7ca7-11eb-3847-43a2c0aeba71
using SymPy

# ╔═╡ 58524254-7c8c-11eb-11f9-f326b132d913
md"""
**Problem 1.** Consider the density matrix:

$\rho = \begin{pmatrix} 3/4 & \frac{\sqrt{2}}{4} e^{-\mathit{i}\,\phi} \\ \frac{\sqrt{2}}{4} e^{-\mathit{i}\,\phi} & 1/4 \end{pmatrix}$

go through the conditions to ensure that this matrix is indeed a density matrix. Furthermore is the matrix a pure or mixed state, i.e. $\rho = \ket{\psi}\bra{\psi}$ or $\rho=\sum_i \mathrm{p_i}\ket{\psi_i}\bra{\psi_i}$.

Also calculate the $\mathrm{tr}(\sigma_1 \rho)$.
"""

# ╔═╡ a984007c-7ca5-11eb-1ec3-6de4c7507e6d
md"""
**Solution 1.** The criteria that a matrix be a density matrix is the following:

1. Positive semidefinite operator, therefore is Hermitian with eigenvalues $\ge 0$.
2. Has $\mathrm{tr}(\rho)=1$
3. 
"""

# ╔═╡ 0ac90b56-7ca7-11eb-0f02-83fdc827d688
begin
	𝑖 = sympy.I
	ϕ = sympy.symbols("ϕ",real=true)
	⋅ = *
end

# ╔═╡ 4564de98-7ca7-11eb-2aed-a9e5ac5823f4
begin
	ρ₁₁ = sympy.Rational(3,4)
	ρ₁₂ = sympy.sqrt(2)/4 ⋅ exp(-𝑖⋅ϕ)
	ρ₂₁ = sympy.sqrt(2)/4 ⋅ exp(𝑖⋅ϕ)
	ρ₂₂ = sympy.Rational(1,4)
	ρ = [ρ₁₁ ρ₁₂;
		 ρ₂₁ ρ₂₂]
end

# ╔═╡ ed1a13aa-7ca8-11eb-3495-5de77c1ebd3d
md"So the easiest condition to check is the second one by taking the trace of the ensity matrix, as below:"

# ╔═╡ 4a50c920-7ca8-11eb-39f1-d3091fa98090
ρ.trace()

# ╔═╡ 019860a2-7ca9-11eb-2dfc-3579ac13e087
md"It satisfies this criteria. Now we need to check if its positive semidefinite. Since this requires that its Hermitian, we can check that $\rho = \rho^{\dagger}$."

# ╔═╡ 9e6784c2-7ca8-11eb-0874-cb1d3b6b7818
begin
	if ρ == ρ.adjoint()
		md"""
		``` julia
		ρ == ρ.adjoint()
		``` $\rho$ is Hermitian.
		"""
	else
		md"""
		``` julia
		ρ == ρ.adjoint()
		``` $\rho$ is not Hermitian.
		"""
	end
end

# ╔═╡ b38bedc0-7ca8-11eb-2caa-db566f11dec2
md"""Now to see if the is postive valued, we can get the eigenspectrum:"""

# ╔═╡ b351db10-7caa-11eb-3d5c-f50a0f91b5ef
e = ρ.eigenvals()

# ╔═╡ ff2b8fa4-7caa-11eb-26dd-8d1fd2f958d0
a,b = keys(e)

# ╔═╡ 0906d25e-7cab-11eb-2763-694393a1009f
sympy.expr(a)

# ╔═╡ Cell order:
# ╟─58524254-7c8c-11eb-11f9-f326b132d913
# ╠═a984007c-7ca5-11eb-1ec3-6de4c7507e6d
# ╠═070b3584-7ca7-11eb-3847-43a2c0aeba71
# ╠═0ac90b56-7ca7-11eb-0f02-83fdc827d688
# ╠═4564de98-7ca7-11eb-2aed-a9e5ac5823f4
# ╟─ed1a13aa-7ca8-11eb-3495-5de77c1ebd3d
# ╠═4a50c920-7ca8-11eb-39f1-d3091fa98090
# ╟─019860a2-7ca9-11eb-2dfc-3579ac13e087
# ╟─9e6784c2-7ca8-11eb-0874-cb1d3b6b7818
# ╟─b38bedc0-7ca8-11eb-2caa-db566f11dec2
# ╠═b351db10-7caa-11eb-3d5c-f50a0f91b5ef
# ╠═ff2b8fa4-7caa-11eb-26dd-8d1fd2f958d0
# ╠═0906d25e-7cab-11eb-2763-694393a1009f
