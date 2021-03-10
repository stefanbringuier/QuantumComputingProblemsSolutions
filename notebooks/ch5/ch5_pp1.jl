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

# ╔═╡ 2fef58d0-8156-11eb-179a-1957304d3cb0
using SymPy

# ╔═╡ fbf11ea4-8154-11eb-24a6-e107c8a59806
md""" 
**Problem 1.** 
Consider the hermitian matrix:

$\mathbf{O} = \begin{pmatrix}  0 & 0 & i \\ 0 & 0 & 0 \\ -i & 0 & 0 \end{pmatrix}$

Find the eigenvalues of $\mathbf{O}$ using the fact that:

$\text{tr}(\mathbf{O}) = \lambda_1 + \lambda_2 + \lambda_3$
$\text{tr}(\mathbf{O}^2) = \lambda_1^2 + \lambda_2^2 + \lambda_3^2$
$\text{tr}(\mathbf{O}^3) = \lambda_1^3 + \lambda_2^3 + \lambda_3^3$

"""

# ╔═╡ 7b7ea992-8156-11eb-13ef-fd89426039a5
begin
	𝑖 = sympy.I
	𝐎 = sympy.Matrix([ 0 0 𝑖;
			           0 0 0;
			          -𝑖 0 0]);
	𝚝𝚛(X) = sympy.trace(X);
end;

# ╔═╡ 1b0680c0-8157-11eb-34a0-adae4e75fa41
begin
	λᵢ = sympy.symbols("λ₁ λ₂ λ₃")
end;

# ╔═╡ 8739828e-8158-11eb-1fe1-c5af44752cc3
md"""
Now get the equation representing the equalities in the problem statement.
"""

# ╔═╡ 479f760e-8158-11eb-2b3e-fb70ae0eeb36
get_eq(X,λ;p=1) = sympy.Eq(sum(λ.^p),𝚝𝚛(X^p));

# ╔═╡ 390af132-8157-11eb-0451-251b0e7b6cd0
eq1 = get_eq(𝐎,λᵢ)

# ╔═╡ 650bf492-8158-11eb-158f-9361dd21bfb8
eq2 = get_eq(𝐎,λᵢ,p=2)

# ╔═╡ ca910bae-8158-11eb-2ae6-adec92395fd9
eq3 = get_eq(𝐎,λᵢ,p=3)

# ╔═╡ e9ab44e6-8158-11eb-2348-17a55fbb823f
solutions = solve([eq1,eq2,eq3],λᵢ,dict=true);

# ╔═╡ c6d96e82-815a-11eb-35ff-c98ef9aa5aec
@bind x html"<input type=range min=1 max=6 step=1"

# ╔═╡ ec35b492-815a-11eb-38b2-ddf742738743
md"""Various eigenvalue solutions:

$ $(sympy.latex(solutions[x])) $
"""

# ╔═╡ Cell order:
# ╟─fbf11ea4-8154-11eb-24a6-e107c8a59806
# ╠═2fef58d0-8156-11eb-179a-1957304d3cb0
# ╠═7b7ea992-8156-11eb-13ef-fd89426039a5
# ╠═1b0680c0-8157-11eb-34a0-adae4e75fa41
# ╟─8739828e-8158-11eb-1fe1-c5af44752cc3
# ╠═479f760e-8158-11eb-2b3e-fb70ae0eeb36
# ╠═390af132-8157-11eb-0451-251b0e7b6cd0
# ╠═650bf492-8158-11eb-158f-9361dd21bfb8
# ╠═ca910bae-8158-11eb-2ae6-adec92395fd9
# ╠═e9ab44e6-8158-11eb-2348-17a55fbb823f
# ╟─c6d96e82-815a-11eb-35ff-c98ef9aa5aec
# ╟─ec35b492-815a-11eb-38b2-ddf742738743
