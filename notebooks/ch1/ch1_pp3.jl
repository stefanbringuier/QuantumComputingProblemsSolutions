### A Pluto.jl notebook ###
# v0.12.21

using Markdown
using InteractiveUtils

# ╔═╡ deca3f3c-7555-11eb-0467-c1115abf3c99
begin
	using SymPy
	using Plots
	pyplot()
end

# ╔═╡ d045eda8-7555-11eb-1f5f-7fe11a175e3a
md"""
**Problem 3**. Find the eigenvalues and normalized eigenvectors of the Hamiltonian operator:

$\hat{K} = \frac{1}{\hbar \omega} \hat{H} = \frac{1}{\sqrt{2}} \begin{pmatrix} 1 & 1 \\ 1 & -1 \end{pmatrix}$

"""

# ╔═╡ 5d6d0824-7556-11eb-0ae1-8503f61ffc43
md"**Solution 3.**"

# ╔═╡ c3d9cb46-7561-11eb-0e04-891c9df22350
md"Definitions:"

# ╔═╡ 8273c4c6-7556-11eb-2709-ef2be31241c4
begin
	π,𝑖 = sympy.symbols("π 𝑖")
	sqrthalf = 1/sympy.sqrt(2)
	⋅(x::SymMatrix,y::SymMatrix) = sympy.Matrix.dot(x,y).simplify()
end;

# ╔═╡ a8caf5f6-7556-11eb-3f15-137324bbd210
md"This operator is the Hadamard gate."

# ╔═╡ ea82dbde-7555-11eb-39c7-e54345be3666
K̂ = sqrthalf * sympy.Matrix([1 1;
	       	                 1 -1]);

# ╔═╡ 809e4128-755b-11eb-263b-8f0f053cdb14
md"Now calculating the eigenvalues and eigenvectors using SymPy."

# ╔═╡ 5d68c704-7557-11eb-0674-bd5e07dd5a97
begin
	eᵢ = K̂.eigenvals(multiple=true,rational=true)
	vᵢ = [sympy.simplify(v[end][1]) for v in K̂.eigenvects(chop=true)]
end;

# ╔═╡ f2919eb4-7557-11eb-20d9-b7f512e61873
md"""
The eigenvectors, which are not normalized, and eigenvalues are:

$ \textbf{v}\_1= $(sympy.latex(vᵢ[1])) ,\hskip{10mm}  e_1= $(sympy.latex(eᵢ[1])) $

$ \textbf{v}\_2= $(sympy.latex(vᵢ[2])) ,\hskip{10mm}  e_2= $(sympy.latex(eᵢ[2])) $

"""

# ╔═╡ e8b0afc8-755e-11eb-1823-55b2fc58ae73
md"The characteristics that make these eigenvectors is that the inner product is a scalar value equal to 0, as seen below,"

# ╔═╡ 1bfe687a-755f-11eb-0a5b-716bb2cec7eb
begin
	v₁, v₂ = vᵢ[1], vᵢ[2];
	v₁'⋅ v₂
end

# ╔═╡ Cell order:
# ╟─d045eda8-7555-11eb-1f5f-7fe11a175e3a
# ╟─5d6d0824-7556-11eb-0ae1-8503f61ffc43
# ╠═deca3f3c-7555-11eb-0467-c1115abf3c99
# ╟─c3d9cb46-7561-11eb-0e04-891c9df22350
# ╠═8273c4c6-7556-11eb-2709-ef2be31241c4
# ╟─a8caf5f6-7556-11eb-3f15-137324bbd210
# ╠═ea82dbde-7555-11eb-39c7-e54345be3666
# ╟─809e4128-755b-11eb-263b-8f0f053cdb14
# ╠═5d68c704-7557-11eb-0674-bd5e07dd5a97
# ╠═f2919eb4-7557-11eb-20d9-b7f512e61873
# ╟─e8b0afc8-755e-11eb-1823-55b2fc58ae73
# ╠═1bfe687a-755f-11eb-0a5b-716bb2cec7eb
