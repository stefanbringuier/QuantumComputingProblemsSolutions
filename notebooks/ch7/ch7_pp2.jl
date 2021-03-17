### A Pluto.jl notebook ###
# v0.12.21

using Markdown
using InteractiveUtils

# ╔═╡ 9bf3cf50-86da-11eb-30eb-b92817a48c1b
using SymPy

# ╔═╡ ef6ff364-86d9-11eb-2bb7-3bf71416ae93
md"""**Problem 2.**
Consider the normalized vector in $\mathbb{C}^4$:

$\mathbf{v} = \frac{1}{2}\begin{pmatrix} i \\ -i \\ i \\ -i \end{pmatrix}$

Show that the matrix $U = I_4 - 2\mathbf{v}\mathbf{v}^{\dagger}$ is unitary and find the corresponding eigenvalues.
"""

# ╔═╡ 9180592a-86da-11eb-2cfe-03e1a0999cd9
md"**Solution.**"

# ╔═╡ b9924f2a-86da-11eb-3762-b1dd345bfb8c
begin
	𝑖 = sympy.I
	⋅(x::T,y) where {T<:Number} = x*y
    ⋅(x::SymMatrix,y) = sympy.MatMul(x.as_explicit(),y,evaluate=true)
    ⋅(x,y::SymMatrix) = sympy.MatMul(x,y.as_explicit(),evaluate=true)
	isunitary(x::Sym) = begin
		sympy.Equality(x.as_explicit().inv(),x.as_explicit().adjoint())
	end
end;

# ╔═╡ 9f1c85f4-86da-11eb-2c33-950b60b609f5
begin
	𝐯 = 1/2 ⋅ [ 𝑖;
		       -𝑖;
		        𝑖;
		        𝑖];
	𝐯ᵈ = sympy.adjoint(𝐯)
	I₄ = sympy.Identity(4) # symbolic identity, could use sympy.eye(4,4)
end;

# ╔═╡ 13249402-86dc-11eb-00e0-dbee20bf1fbb
U = I₄ - 2⋅𝐯⋅𝐯ᵈ;

# ╔═╡ 60a5fe3c-86dc-11eb-1f76-6b1e9f670998
md"""
$ U = $(sympy.latex(U.as_explicit())) $
"""

# ╔═╡ 0c5964aa-86e2-11eb-26b6-097f2aefbf32
md"Now checking if this matrix is indeed unitary (i.e. $U^{-1} = U^{\dagger}$):"

# ╔═╡ 86765b0c-86dc-11eb-2ae1-c5c97ec48562
isunitary(U)

# ╔═╡ db781a74-86e0-11eb-1bb1-195a12610649
md"Now finding the eigenvalues:"

# ╔═╡ 29a073c0-86de-11eb-0a82-19334bd77c22
e = U.as_explicit().eigenvects(dict=true,chop=true);

# ╔═╡ 995710d2-86e0-11eb-35e8-372207b6e49d
md"""A total of $(length(e)) eigenvalues:

$ e_1 = $(round(e[1][1],sigdigits=3)) $

$ e_2 = $(round(e[2][1],sigdigits=3)) $

$ e_3 = $(round(e[3][1],sigdigits=3)) $

$ e_4 = $(round(e[4][1],sigdigits=3)) $.

As one can see 3 of them are degenerate.

"""

# ╔═╡ Cell order:
# ╟─ef6ff364-86d9-11eb-2bb7-3bf71416ae93
# ╟─9180592a-86da-11eb-2cfe-03e1a0999cd9
# ╠═9bf3cf50-86da-11eb-30eb-b92817a48c1b
# ╠═b9924f2a-86da-11eb-3762-b1dd345bfb8c
# ╠═9f1c85f4-86da-11eb-2c33-950b60b609f5
# ╠═13249402-86dc-11eb-00e0-dbee20bf1fbb
# ╟─60a5fe3c-86dc-11eb-1f76-6b1e9f670998
# ╟─0c5964aa-86e2-11eb-26b6-097f2aefbf32
# ╠═86765b0c-86dc-11eb-2ae1-c5c97ec48562
# ╟─db781a74-86e0-11eb-1bb1-195a12610649
# ╠═29a073c0-86de-11eb-0a82-19334bd77c22
# ╟─995710d2-86e0-11eb-35e8-372207b6e49d
