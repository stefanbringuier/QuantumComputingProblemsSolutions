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

# ╔═╡ ab66286e-7bc1-11eb-1742-bb3e77df72a8
using SymPy

# ╔═╡ cbf1b7aa-7bbd-11eb-3bdd-234c32175043
md"""
**Problem 2.** Starting with the identity matrix $I$ of shape $n \times n$ and a invertible matrix $X \in \mathbb{C}^{\,n^2 \times n^2}$. Now if we say that $X$ satisfies the [Yang-Baxter](https://en.wikipedia.org/wiki/Yang%E2%80%93Baxter_equation) equation[^1] :

$(X\otimes I)(I\otimes X)(X\otimes I) = (I\otimes X)(X \otimes I)(I\otimes X)$

then $X^{\dagger}$ satisfies the equation (as well as $X^{-1}$). Now if take an invertable matrix $Q \in \mathbb{C}^{n\times n}$ and express a new matrix as:

$X^{\prime} = (Q \otimes Q) X (Q \otimes Q)^{-1}$

which also satisfies the Yang-Baxter equation. Now show that given the matrix:

$X = \frac{1+\mathit{i}}{2}\begin{pmatrix} 1 & 0 & 0 & 1 \\ 0 & 1 & 1 & 0 \\ 0 & -1 & 1 & 0 \\ -1 & 0 & 0 & 1 \end{pmatrix}$

will satisfy the Yang-Baxter equation when $I$ has size $2\times 2$.
"""

# ╔═╡ 8d3a951e-7bc1-11eb-2e93-7d729067e6d3
md"""
**Solution 2.** The first thing to do is construct the matrices $X$ and $I_2$
"""

# ╔═╡ b17ef41a-7bc1-11eb-2a5e-ab09365f27a5
begin
	𝑖 = sympy.I
	⊗(x::Array{Sym,2},y::Array{Sym,2}) = kron(x,y)
	⋅ = *
end

# ╔═╡ fea39fa2-7bc1-11eb-01f7-734a880721da
X = (1+𝑖)/2 ⋅ [ 1  0 0 1;
	            0  1 1 0;
	            0 -1 1 0;
		       -1  0 0 1];

# ╔═╡ a65d5b0c-7bc2-11eb-02fa-93887788bf0e
@bind n html"<input type=range min=1 max=4>"

# ╔═╡ d45a3414-7bc2-11eb-122a-b726e58da372
md"size of $I$ is $ $(n) \times $(n) $"

# ╔═╡ 2b640bc6-7bc2-11eb-11f3-39163b1f50c0
I = sympy.eye(n,n);

# ╔═╡ 3bd23fe8-7bde-11eb-23c1-273636ba2658
md"Now create a function corresponding to the Yang-Baxter equation."

# ╔═╡ 49e11236-7bc2-11eb-198c-8f52e0840e1b
eq(A,B) = (A⊗B)⋅(B⊗A)⋅(A⊗B);

# ╔═╡ ae84a9f0-7bdd-11eb-1fcb-7791e908240b
"""
use sympy.as_real_imag() to simplify complex part
"""
cmplxsimplify(X) = begin
	A = X.as_real_imag()
	return A[1] + im * A[2]
end;

# ╔═╡ 5d0c6e0e-7bde-11eb-0d51-139aa3028390
md"evaluate the symmetry:"

# ╔═╡ 21fa8d1c-7bdd-11eb-0300-295850c4c684
begin
	IX_XI_IX = eq(I,X) |> cmplxsimplify
	XI_IX_XI = eq(X,I) |> cmplxsimplify
end;

# ╔═╡ 9773fd76-7bc2-11eb-060f-936c2b04c3a9
IX_XI_IX == XI_IX_XI

# ╔═╡ bb59582a-7bde-11eb-38b4-1589c7946ae6
md"The matrices given by the tensor products is:"

# ╔═╡ 684837da-7bde-11eb-1075-ab9793f7922c
IX_XI_IX

# ╔═╡ 182755dc-7bdf-11eb-1e38-95c8a44795f1
XI_IX_XI

# ╔═╡ 92ce53ec-7bbe-11eb-12e8-bf87d78c6a8f
md"""
[^1]: I believe this equation is related to topological quantum computation
"""

# ╔═╡ Cell order:
# ╟─cbf1b7aa-7bbd-11eb-3bdd-234c32175043
# ╟─8d3a951e-7bc1-11eb-2e93-7d729067e6d3
# ╠═ab66286e-7bc1-11eb-1742-bb3e77df72a8
# ╠═b17ef41a-7bc1-11eb-2a5e-ab09365f27a5
# ╠═fea39fa2-7bc1-11eb-01f7-734a880721da
# ╟─a65d5b0c-7bc2-11eb-02fa-93887788bf0e
# ╟─d45a3414-7bc2-11eb-122a-b726e58da372
# ╠═2b640bc6-7bc2-11eb-11f3-39163b1f50c0
# ╟─3bd23fe8-7bde-11eb-23c1-273636ba2658
# ╠═49e11236-7bc2-11eb-198c-8f52e0840e1b
# ╠═ae84a9f0-7bdd-11eb-1fcb-7791e908240b
# ╟─5d0c6e0e-7bde-11eb-0d51-139aa3028390
# ╠═21fa8d1c-7bdd-11eb-0300-295850c4c684
# ╠═9773fd76-7bc2-11eb-060f-936c2b04c3a9
# ╟─bb59582a-7bde-11eb-38b4-1589c7946ae6
# ╠═684837da-7bde-11eb-1075-ab9793f7922c
# ╠═182755dc-7bdf-11eb-1e38-95c8a44795f1
# ╟─92ce53ec-7bbe-11eb-12e8-bf87d78c6a8f
