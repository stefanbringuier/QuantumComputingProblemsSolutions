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

# ╔═╡ c0f47f04-7b10-11eb-3163-817fe510c4ac
begin
	using SymPy
end

# ╔═╡ 89a6022a-796d-11eb-21f5-a5e63cfa7a71
md"""
**Problem 1.** Given the Pauli matrices

$\sigma_x = \begin{pmatrix} 0 & 1 \\ 1 & 0 \end{pmatrix}, \hskip{5mm} \sigma_y = \begin{pmatrix} 0 & \mathit{i} \\ -\mathit{i} & 0 \end{pmatrix}, \hskip{5mm} \sigma_z = \begin{pmatrix} & 0 \\ 0 & -1 \end{pmatrix}$

and a hermitian matrix that has dimensions 8x8 and written as:

$H = \left(\sigma_x \otimes \sigma_x + \sigma_y \otimes \sigma_y + \sigma_z \otimes \sigma_z \right) \otimes \sigma_x.$

Find the eigenvalues and and eigenvectors.
"""

# ╔═╡ c5deba24-7b0f-11eb-111e-cde60dc7e942
md"""
**Solution 1.** The interesting thing to note here is that the hermitian matrix can be written as the direct sum:

$H = \begin{pmatrix} 0 & 1 \\ 1 & 0 \end{pmatrix} \oplus \begin{pmatrix} 0 & -1 & 0 & 2 \\ -1 & 0 & 2 & 0 \\ 0 & 2 & 0 & -1 \\ 2 & 0 & -1 & 0 \end{pmatrix} \oplus \begin{pmatrix} 0 & 1 \\ 1 & 0 \end{pmatrix}$

This means that the eigenspectrum can be calculated from the $2 \times 2$ and $4 \times 4$ matrices.
"""

# ╔═╡ c7442e02-7b10-11eb-37e2-678e8c25ff65
begin
	𝑖 = sympy.I
	⊗(x,y)=kron(x,y)
	⊗(x::Array{Sym,2},y::Array{Sym,2}) = kron(x,y)
	𝐓(x::Array{Sym,2}) = sympy.Matrix(sympy.transpose(x))
	
	"""Direct sum of vector space.
	""" 
	⊕(x,y) = begin
		xdim = size(x);
		ydim = size(y);
		M = [           x           zeros(Int,xdim[1],ydim[2]);
		      zeros(Int,ydim[1],xdim[2])          y           ];
		return M
	end
end;

# ╔═╡ e51ae1be-7b10-11eb-0bde-6d5cfbe1101d
begin
	σ₁ = [0 1;
		  1 0]
	σ₂ = [0 -𝑖;
		  𝑖 0]
	σ₃ = [1 0;
		  0 -1]	  
end;

# ╔═╡ a4319c16-7b14-11eb-34a2-5b074883a573
md"The hermitian matrix given by the expression above is then:"

# ╔═╡ 3852575e-7b11-11eb-27c6-39ea3342fb0e
H = (σ₁ ⊗ σ₁ + σ₂ ⊗ σ₂ + σ₃ ⊗ σ₃) ⊗ σ₁

# ╔═╡ 1a802b4e-7b15-11eb-319c-e9e7e39cf11c
md"Now just checking the direct sum comparison."

# ╔═╡ 299a7d78-7b15-11eb-0e8e-3557aed91786
begin
	D = Sym[ 0 -1  0  2;
		    -1  0  2  0;
		     0  2  0 -1;
		     2  0 -1  0];
	H′ = σ₁ ⊕ D ⊕ σ₁
end

# ╔═╡ b52dd2f4-7b15-11eb-2b54-29298216d930
@assert H == H′ "Direct sum doesn't equal hermitian matrix"

# ╔═╡ fc7603de-7b15-11eb-3b3e-873641a7c8e8
md"Now finding the eigenvalues and eigenvectors"

# ╔═╡ 0969d1d8-7b16-11eb-34ff-9d4ca9ffa294
begin
	ℍ = H.eigenvects(chop=true)
	#unpack :e - eigenvalue, :m - multiplicty (degeneracy)
	eₕ = [Dict(:e=>e[1],:m=>e[2]) for e in ℍ]
	vₕ = [v[end][1:end] for v in ℍ]
end;

# ╔═╡ 7771f85e-7b16-11eb-0308-5b6ac0ad623f
begin
	eslider = @bind e html"<select><option value='e'>eigenvalues</option><option value='m'>degeneracy</option></select>"
	lslider = @bind l html"<input type=range min=1 max=4>"
	md"""
	$(eslider)
	
	$(lslider)
	"""
end

# ╔═╡ 83b48d84-7b16-11eb-27a1-8f62e09a9f0f
begin
	label = e == "e" ? "λ" : "m"
	termh = sympy.latex(map((x,y)->"$(label)_$(y) = $(x[Symbol(e)])",eₕ[1:l],1:l))
	md"""
	$ H: $(termh) $
	"""
end

# ╔═╡ 4b59b7ec-7b17-11eb-09d8-33327cb52ff2
md"Let see how these eigenvalues compare to the eigenvalues of the matrix $D$."

# ╔═╡ 64a3627a-7b17-11eb-12a8-59d13761ad9d
begin
	𝔻 = D.eigenvects(chop=true)
	eᵨ = [Dict(:e=>e[1],:m=>e[2]) for e in 𝔻]
	vᵨ = [v[end][1:end] for v in 𝔻]
end;

# ╔═╡ a1bdde7e-7b17-11eb-245e-cd22aa041fe7
begin
	labeld = e == "e" ? "λ" : "m"
	termd = sympy.latex(map((x,y)->"$(labeld)_$(y) = $(x[Symbol(e)])",eᵨ[1:l],1:l))
	md"""
	$ D: $(termd) $
	
	we find that the eigenvalues are the same but the degeneracy is now removed. We can look at the eigenvectors the the $D$ matrix:
	"""
end

# ╔═╡ b6f58446-7b16-11eb-30bd-b9e59d80cc64
@bind v html"<input type=range min=1 max=4>"

# ╔═╡ 0c24db7e-7b17-11eb-19ca-119744b90037
md"eigenvector index $(v)"

# ╔═╡ c6ac77aa-7b16-11eb-2c01-c56600bc83eb
begin 
	md"$ $(sympy.latex(vᵨ[v][1])) $"
end

# ╔═╡ Cell order:
# ╟─89a6022a-796d-11eb-21f5-a5e63cfa7a71
# ╟─c5deba24-7b0f-11eb-111e-cde60dc7e942
# ╠═c0f47f04-7b10-11eb-3163-817fe510c4ac
# ╠═c7442e02-7b10-11eb-37e2-678e8c25ff65
# ╠═e51ae1be-7b10-11eb-0bde-6d5cfbe1101d
# ╟─a4319c16-7b14-11eb-34a2-5b074883a573
# ╠═3852575e-7b11-11eb-27c6-39ea3342fb0e
# ╟─1a802b4e-7b15-11eb-319c-e9e7e39cf11c
# ╠═299a7d78-7b15-11eb-0e8e-3557aed91786
# ╠═b52dd2f4-7b15-11eb-2b54-29298216d930
# ╟─fc7603de-7b15-11eb-3b3e-873641a7c8e8
# ╠═0969d1d8-7b16-11eb-34ff-9d4ca9ffa294
# ╠═7771f85e-7b16-11eb-0308-5b6ac0ad623f
# ╟─83b48d84-7b16-11eb-27a1-8f62e09a9f0f
# ╟─4b59b7ec-7b17-11eb-09d8-33327cb52ff2
# ╠═64a3627a-7b17-11eb-12a8-59d13761ad9d
# ╟─a1bdde7e-7b17-11eb-245e-cd22aa041fe7
# ╟─b6f58446-7b16-11eb-30bd-b9e59d80cc64
# ╟─0c24db7e-7b17-11eb-19ca-119744b90037
# ╟─c6ac77aa-7b16-11eb-2c01-c56600bc83eb
