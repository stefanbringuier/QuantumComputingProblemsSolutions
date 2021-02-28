### A Pluto.jl notebook ###
# v0.12.21

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : missing
        el
    end
end

# ╔═╡ 0fd56720-730b-11eb-3ec4-531a7d66207b
using SymPy

# ╔═╡ 37f2abdc-730b-11eb-1072-99952754ba94
md"""
**Problem 1.** Consider the Hadamard basis in $\mathbb{C}^2$:

$\ket{\psi_+} = \frac{1}{\sqrt{2}}\begin{pmatrix} 1 \\ 1 \end{pmatrix} \hskip{10mm} \ket{\psi_-} = \frac{1}{\sqrt{2}}\begin{pmatrix} 1 \\ -1 \end{pmatrix}$

Apply the Kronecker (tensor) product to find a basis in a new $\mathbb{C}^4$.
"""

# ╔═╡ 867ab1e8-7499-11eb-3464-755d09223c49
md"**Solution 1**"

# ╔═╡ 01c67cb2-7669-11eb-0ca2-87fc72f8bf69
md"""
This is a simple permutation of tensor products for the basis states
"""

# ╔═╡ fdd7e022-7312-11eb-1a44-63473aa24a1d
begin
	sqrthalf = 1/sympy.sqrt(2)
	⊗(x,y) = flatten(sympy.tensorproduct(x,y))
	⋅ = *
end;

# ╔═╡ d39d21f0-7669-11eb-35ab-1bd944ef0b31
begin
	ψₚ = sqrthalf ⋅[1;
			        1]
	ψₘ = sqrthalf ⋅[1;
		           -1]
end;

# ╔═╡ 01ceb2ca-7677-11eb-27a3-31b479ac7f3c
md"There are a total of $2^{\otimes N}$ basis states, $N=2$ in this problem."

# ╔═╡ 14ab5c52-766a-11eb-022c-bf4531f5717a
begin
	ψ₁ = ψₚ ⊗ ψₚ
	ψ₂ = ψₚ ⊗ ψₘ
	ψ₃ = ψₘ ⊗ ψₚ
	ψ₄ = ψₘ ⊗ ψₘ
end;

# ╔═╡ 97a5ae70-76ea-11eb-257d-714726b06d99
Ψ = [ψ₁ ψ₂ ψ₃ ψ₄];

# ╔═╡ 08a67988-76eb-11eb-1088-61e5fe4cc0be
md"The new basis set is:"

# ╔═╡ cd95506c-76ea-11eb-05fb-a10975e84836
@bind i html"<input type='range' min=1 max=4>"

# ╔═╡ 4631f88c-766d-11eb-23e6-b385211c44ff
md"""$ \ket{\psi_{$(i)}} = $(sympy.latex(Ψ[i,:])) $"""

# ╔═╡ 4db00d6e-76eb-11eb-0159-d13261ee4d8a
md"And we can check they are orthonormal via inner product:"

# ╔═╡ d2541720-76ed-11eb-0757-25b0e9526980
begin
	p=[[1,2],[2,1],[1,3],[3,1],[1,4],[4,1],
		[2,3],[3,2],[4,2],[2,4],[3,4],[4,3]]
	
		@bind ii html"<input type='range' min=1 max=12>"
end

# ╔═╡ 6b5692c0-76eb-11eb-1ef4-b59f267199cc
begin
	term = Ψ[p[ii][1],:]' ⋅ Ψ[p[ii][2],:];
	j,k = p[ii][1],p[ii][2]
	expr = "\\langle \\psi_$(j)|\\psi_$(k)\\rangle  = $(term)"
	md"""
	$ $(expr) $
	"""
end

# ╔═╡ 027e6a70-76e1-11eb-2e3d-13e0c8f1b406
"""
	try get matrix prefactor. doesn't work like planned.
"""
factor(X::Array{SymPy.Sym}) = begin
	gfac = sympy.gcd_terms(X)
	return sympy.MatMul(1/gfac,X*gfac,evaluate=false)
end

# ╔═╡ Cell order:
# ╟─37f2abdc-730b-11eb-1072-99952754ba94
# ╟─867ab1e8-7499-11eb-3464-755d09223c49
# ╟─01c67cb2-7669-11eb-0ca2-87fc72f8bf69
# ╠═0fd56720-730b-11eb-3ec4-531a7d66207b
# ╠═fdd7e022-7312-11eb-1a44-63473aa24a1d
# ╠═d39d21f0-7669-11eb-35ab-1bd944ef0b31
# ╟─01ceb2ca-7677-11eb-27a3-31b479ac7f3c
# ╠═14ab5c52-766a-11eb-022c-bf4531f5717a
# ╠═97a5ae70-76ea-11eb-257d-714726b06d99
# ╟─08a67988-76eb-11eb-1088-61e5fe4cc0be
# ╟─cd95506c-76ea-11eb-05fb-a10975e84836
# ╟─4631f88c-766d-11eb-23e6-b385211c44ff
# ╟─4db00d6e-76eb-11eb-0159-d13261ee4d8a
# ╟─d2541720-76ed-11eb-0757-25b0e9526980
# ╟─6b5692c0-76eb-11eb-1ef4-b59f267199cc
# ╟─027e6a70-76e1-11eb-2e3d-13e0c8f1b406
