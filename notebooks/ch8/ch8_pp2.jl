### A Pluto.jl notebook ###
# v0.12.21

using Markdown
using InteractiveUtils

# ╔═╡ cd9b9e7e-8c5a-11eb-3827-e75764b53fe2
begin
	using SymPy
end

# ╔═╡ 91653c6e-8c58-11eb-0c43-c71d418a8ddb
md"""**Problem 2.**

$K_1=\begin{pmatrix} 0 & 0 & -i \\ 0 & 0 & 0 \\ i & 0 & 0 \end{pmatrix} \hskip{5mm} K_2=\begin{pmatrix} 1 & 0 & 0 \\ 0 & 0 & 0 \\ 0 & 0 & -1 \end{pmatrix}$

and the normalized state in $\mathbb{C}^3$,

$\ket{\psi} = \frac{1}{\sqrt{3}} \begin{pmatrix} 1 \\ 1 \\ 1 \end{pmatrix}$.

Find the left and right-hand side of the entropi inequality.

"""

# ╔═╡ 4093acd4-8c59-11eb-2278-2334104acb58
md"""**Solution.**

The entropic inequality is given by:

$ S(\rho) \leq \log(n) $

where $n$ is the dimensions of $\rho$.

In this case we are interested in the Shannon information entropy associated with the hermitian matrices. This requires determining the spectral decomposition, i.e., eigenvectors. Moreover we actuall what to calculate the entropic uncertainty relation for the two hermitian matrices acting on this Hilbert space.
"""

# ╔═╡ d2631ef0-8c5a-11eb-218d-a970a24a96eb
begin
	𝑖 = sympy.I
	⋅(x,y) = x*y
	⋅(x::Array{Sym,2},y) = x.dot(y)
	norm(x,y) = begin
		braket = x.adjoint()⋅x
		sympy.sqrt(braket[1])
	end
end;

# ╔═╡ ddb99c52-8c5a-11eb-13a5-d7d5ad1383d4
begin
	K₁ = [0 0 -𝑖;
		  0 0  0;
		  𝑖 0  0];
	K₂ = sympy.Matrix([1 0  0;
		               0 0  0;
		               0 0 -1]);
	ψ = 1/sympy.sqrt(3) ⋅ [1;
		                   1;
		                   1];
end;

# ╔═╡ 40b30042-8c61-11eb-1bef-13d8ee49acd5
md"""
The Shannon information entropy for the hermitian matrix, $\mathcal{O}$, is given by:

$S_{\ket{\psi}}(\mathcal{O}) = -\sum_{i=1}^{n} p_i(\mathcal{O},\ket{\psi}) \cdot \ln(p_i(\mathcal{O},\ket{\psi}))$

where the probability $p_i$ is obtained from:

$p_i(\mathcal{O},\ket{\psi}) = |\langle \psi| \alpha_i \rangle|^2$

with $\ket{\alpha_i}$ being the $i^{\text{th}}$ eigenvector. 

Therefore we first need to find the eigenspectrum for the matrices $K_1$ and $K_2$"

"""

# ╔═╡ f48cf124-8c5b-11eb-237e-e5bb45350b62
begin
	𝐞₁ = K₁.eigenvects()
	𝐞₂ = K₂.eigenvects()
end;

# ╔═╡ 01958574-8c5f-11eb-3fad-7322b19ee2a6
md"""Now normalize the eigenvectors since we want the probabilities:
$p(K,\ket{\psi}) = | \langle \psi | \alpha \rangle | ^2$
"""

# ╔═╡ 0cc08dcc-8c5f-11eb-2b47-35c34f2404aa
begin
	# There are 3 eigenvectors
	𝐯₁ = Array{Array{Sym}}(undef,3)
	𝐯₂ = Array{Array{Sym}}(undef,3)
	for i=1:3 
		ν₁,ν₂ = 𝐞₁[i][3][1],𝐞₂[i][3][1]
		n₁,n₂ = norm(ν₁,ν₁),norm(ν₂,ν₂)
	    𝐯₁[i] = ν₁/n₁
	    𝐯₂[i] = ν₂/n₂
	end
end

# ╔═╡ 80d2be5e-8d2e-11eb-3ad6-41c88fcb92e8
md"Calculating the Shannon entropy for each hermitian matrice:"

# ╔═╡ 23919f76-8c5c-11eb-24e3-b7d3c421c1b4
begin
	S₁ = 0.00
	S₂ = 0.00
	for i=1:3
		p¹ᵢ = sympy.Abs(ψ.adjoint()⋅𝐯₁[i])^2 
		p²ᵢ = sympy.Abs(ψ.adjoint()⋅𝐯₁[i])^2
		S₁ -= p¹ᵢ ⋅ sympy.log(p¹ᵢ)
		S₂ -= p²ᵢ ⋅ sympy.log(p²ᵢ)
	end
end

# ╔═╡ 07fed6ea-8c64-11eb-0cea-113450cc5e25
md"""
Now we want to calculate the terms on the right and left sides of the following inequality:

$S_{\ket{\psi}}(K_1) + S_{\ket{\psi}}(K_2) \geq -2 \ln(\max_{1\leq i, j\leq n}\; |\langle \alpha_i | \beta_j \rangle|)$

The left hand side is then just:

$ $(sympy.latex(S₁+S₂)) $.

Calculating the right hand side:
"""

# ╔═╡ f8fe7ce6-8d2f-11eb-2be8-e56aa2abec75
rhs = -2⋅sympy.log(maximum([sympy.Abs(𝐯₁[i].adjoint()⋅𝐯₂[j]) for i=1:3,j=1:3]));

# ╔═╡ 975f4532-8d30-11eb-10f2-5f8a8d32e0e8
md"""
$ $(sympy.latex(S₁+S₂)) \geq $(rhs) $

The right hand side of the inequality makes sense since both $K_1$ and $K_2$ share a common eigenvector:


$\begin{pmatrix} 0 \\ 1 \\ 0 \end{pmatrix}$

"""

# ╔═╡ Cell order:
# ╟─91653c6e-8c58-11eb-0c43-c71d418a8ddb
# ╟─4093acd4-8c59-11eb-2278-2334104acb58
# ╠═cd9b9e7e-8c5a-11eb-3827-e75764b53fe2
# ╠═d2631ef0-8c5a-11eb-218d-a970a24a96eb
# ╠═ddb99c52-8c5a-11eb-13a5-d7d5ad1383d4
# ╟─40b30042-8c61-11eb-1bef-13d8ee49acd5
# ╠═f48cf124-8c5b-11eb-237e-e5bb45350b62
# ╟─01958574-8c5f-11eb-3fad-7322b19ee2a6
# ╠═0cc08dcc-8c5f-11eb-2b47-35c34f2404aa
# ╟─80d2be5e-8d2e-11eb-3ad6-41c88fcb92e8
# ╠═23919f76-8c5c-11eb-24e3-b7d3c421c1b4
# ╟─07fed6ea-8c64-11eb-0cea-113450cc5e25
# ╠═f8fe7ce6-8d2f-11eb-2be8-e56aa2abec75
# ╟─975f4532-8d30-11eb-10f2-5f8a8d32e0e8
