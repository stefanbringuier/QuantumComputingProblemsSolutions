### A Pluto.jl notebook ###
# v0.12.21

using Markdown
using InteractiveUtils

# ╔═╡ 070b3584-7ca7-11eb-3847-43a2c0aeba71
begin
	using SymPy
	using Plots
	pyplot()
end;

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
"""

# ╔═╡ 0ac90b56-7ca7-11eb-0f02-83fdc827d688
begin
	𝑖 = sympy.I
	π = sympy.symbols("π")
	ϕ = sympy.symbols("ϕ",real=true)
	𝚝𝚛(X) = sympy.trace(X)
	⋅ = *
end;

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
𝚝𝚛(ρ)

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
md"""Now to see if the is postive valued, we can get the eigenspectrum[^1]:"""

# ╔═╡ b351db10-7caa-11eb-3d5c-f50a0f91b5ef
e = [ i for i in keys(ρ.eigenvals())];

# ╔═╡ 08211218-7cac-11eb-0caa-4110c1707b95
md"""
$ e_1 = $(sympy.latex(e[1])) = $(sympy.latex(e[1].evalf(3))) $

$ e_2 = $(sympy.latex(e[2])) = $(sympy.latex(e[2].evalf(3))) $

as we can see $\rho$ is indeed positive and semidefinite and therefore a density matrix.

The next part is to determine if the density matrix corresponds to a *pure* or *mixed* state.
"""

# ╔═╡ 3d4ace56-7cad-11eb-28ed-3796a4242104
md"For a pure state we can check that $\rho^2=\ket{\psi}\langle\psi|\psi\rangle\bra{\psi}=\rho$:"

# ╔═╡ 499c0552-7cae-11eb-046f-013154547b4e
ρ^2 == ρ

# ╔═╡ f57c62c2-7cae-11eb-3dd8-3b4b8c8c435e
md"so its not a pure state but a mixed state. Finally we want to evaluate the expectation of the Pauli operator $\sigma_x$ using $\mathrm{tr}(\sigma_x \rho)$."

# ╔═╡ e4239418-7caf-11eb-02b1-492c5560d823
σₓ = [0 1;
	  1 0];

# ╔═╡ 313c64a4-7caf-11eb-2e91-99c268d411e3
begin
	_σₓ_ =𝚝𝚛(σₓ⋅ρ)
	_σₓ_ = _σₓ_.rewrite(exp).simplify()
end

# ╔═╡ ce1e1f9c-7cb1-11eb-2438-8b0f79fac61e
ϕ⃗ = range(-pi,stop=pi,length=100);

# ╔═╡ 25a42d74-7cb2-11eb-127b-7f1900a7e32d
plot(ϕᵢ->ϕᵢ,ϕᵢ->_σₓ_(ϕ => ϕᵢ),ϕ⃗,
	 xlabel="ϕ",ylabel="⟨σₓ⟩",
	 size=(400,200),legend=false,
     xticks=([pi*i/4 for i=-4:4],[π*i/4 for i=-4:4]))

# ╔═╡ 089f718a-7cac-11eb-0903-ab6325466f5a
md"[^1]: the returned data type from `ρ.eigenvals()` is a julia dictionary with keys being eigenvalues (SymPy) and values the degeneracy/multiplicty. We just want the dictionary keys here."

# ╔═╡ Cell order:
# ╟─58524254-7c8c-11eb-11f9-f326b132d913
# ╟─a984007c-7ca5-11eb-1ec3-6de4c7507e6d
# ╠═070b3584-7ca7-11eb-3847-43a2c0aeba71
# ╠═0ac90b56-7ca7-11eb-0f02-83fdc827d688
# ╠═4564de98-7ca7-11eb-2aed-a9e5ac5823f4
# ╟─ed1a13aa-7ca8-11eb-3495-5de77c1ebd3d
# ╠═4a50c920-7ca8-11eb-39f1-d3091fa98090
# ╟─019860a2-7ca9-11eb-2dfc-3579ac13e087
# ╟─9e6784c2-7ca8-11eb-0874-cb1d3b6b7818
# ╟─b38bedc0-7ca8-11eb-2caa-db566f11dec2
# ╠═b351db10-7caa-11eb-3d5c-f50a0f91b5ef
# ╟─08211218-7cac-11eb-0caa-4110c1707b95
# ╟─3d4ace56-7cad-11eb-28ed-3796a4242104
# ╠═499c0552-7cae-11eb-046f-013154547b4e
# ╟─f57c62c2-7cae-11eb-3dd8-3b4b8c8c435e
# ╠═e4239418-7caf-11eb-02b1-492c5560d823
# ╠═313c64a4-7caf-11eb-2e91-99c268d411e3
# ╠═ce1e1f9c-7cb1-11eb-2438-8b0f79fac61e
# ╠═25a42d74-7cb2-11eb-127b-7f1900a7e32d
# ╟─089f718a-7cac-11eb-0903-ab6325466f5a
